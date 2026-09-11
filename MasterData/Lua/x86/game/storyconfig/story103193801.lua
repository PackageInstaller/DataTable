return {
	Play319381001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319381001
		arg_1_1.duration_ = 7.03

		local var_1_0 = {
			zh = 5.666,
			ja = 7.033
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
				arg_1_0:Play319381002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11l == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11l")
				var_4_0.name = "I11l"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11l = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11l

				arg_1_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11l" then
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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
			local var_4_15 = 0.3

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(319381001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)

				if (12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381001", "story_v_out_319381.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_319381", "319381001", "story_v_out_319381.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_319381", "319381001", "story_v_out_319381.awb")

						arg_1_1:RecordAudio("319381001", var_4_22)
						arg_1_1:RecordAudio("319381001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319381", "319381001", "story_v_out_319381.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319381", "319381001", "story_v_out_319381.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319381002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319381002
		arg_9_1.duration_ = 5.3

		local var_9_0 = {
			zh = 3.166,
			ja = 5.3
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
				arg_9_0:Play319381003(arg_9_1)
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

				arg_9_1:ShowWeapon(arg_9_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.35

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

				local var_12_10 = arg_9_1:GetWordFromCfg(319381002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 14 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 14)

				if (14 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 14)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381002", "story_v_out_319381.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381002", "story_v_out_319381.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_319381", "319381002", "story_v_out_319381.awb")

						arg_9_1:RecordAudio("319381002", var_12_15)
						arg_9_1:RecordAudio("319381002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319381", "319381002", "story_v_out_319381.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319381", "319381002", "story_v_out_319381.awb")
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319381003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319381003
		arg_13_1.duration_ = 5.03

		local var_13_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_13_0:Play319381004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

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
			local var_16_2 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(319381003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 12 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 12)

				if (12 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 12)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381003", "story_v_out_319381.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_319381", "319381003", "story_v_out_319381.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319381", "319381003", "story_v_out_319381.awb")

						arg_13_1:RecordAudio("319381003", var_16_8)
						arg_13_1:RecordAudio("319381003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319381", "319381003", "story_v_out_319381.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319381", "319381003", "story_v_out_319381.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319381004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319381004
		arg_17_1.duration_ = 3.17

		local var_17_0 = {
			zh = 2.766,
			ja = 3.166
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
				arg_17_0:Play319381005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = arg_17_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(arg_17_1.actors_["1084ui_story"]) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_2 = 0
			local var_20_3 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
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

				local var_20_4 = arg_17_1:GetWordFromCfg(319381004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 15 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 15)

				if (15 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 15)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381004", "story_v_out_319381.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381004", "story_v_out_319381.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_319381", "319381004", "story_v_out_319381.awb")

						arg_17_1:RecordAudio("319381004", var_20_9)
						arg_17_1:RecordAudio("319381004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319381", "319381004", "story_v_out_319381.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319381", "319381004", "story_v_out_319381.awb")
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
	Play319381005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319381005
		arg_21_1.duration_ = 5.03

		local var_21_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_21_0:Play319381006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = arg_21_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

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
			local var_24_2 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(319381005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 12 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 12)

				if (12 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 12)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381005", "story_v_out_319381.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_319381", "319381005", "story_v_out_319381.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_319381", "319381005", "story_v_out_319381.awb")

						arg_21_1:RecordAudio("319381005", var_24_8)
						arg_21_1:RecordAudio("319381005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319381", "319381005", "story_v_out_319381.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319381", "319381005", "story_v_out_319381.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319381006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319381006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 2.933,
			ja = 4
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
				arg_25_0:Play319381007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = arg_25_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1084ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
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

				local var_28_6 = arg_25_1:GetWordFromCfg(319381006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)

				if (9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381006", "story_v_out_319381.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381006", "story_v_out_319381.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319381", "319381006", "story_v_out_319381.awb")

						arg_25_1:RecordAudio("319381006", var_28_11)
						arg_25_1:RecordAudio("319381006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319381", "319381006", "story_v_out_319381.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319381", "319381006", "story_v_out_319381.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play319381007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319381007
		arg_29_1.duration_ = 5.03

		local var_29_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_29_0:Play319381008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = arg_29_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

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
			local var_32_2 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(319381007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 12 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 12)

				if (12 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 12)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381007", "story_v_out_319381.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_319381", "319381007", "story_v_out_319381.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_319381", "319381007", "story_v_out_319381.awb")

						arg_29_1:RecordAudio("319381007", var_32_8)
						arg_29_1:RecordAudio("319381007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319381", "319381007", "story_v_out_319381.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319381", "319381007", "story_v_out_319381.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319381008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319381008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319381009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.05

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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319381008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 2)

				if (2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 2)) > 0 and var_36_0 < var_36_3 then
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
	Play319381009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319381009
		arg_37_1.duration_ = 8.3

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319381010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = arg_37_1.bgs_.I11l

				arg_37_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_1 = var_40_0:GetComponent("SpriteRenderer")

				if var_40_1 and var_40_1.sprite then
					local var_40_2 = 2 * (var_40_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_0.transform.localScale = Vector3.New(var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I11l" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_3 = arg_37_1.bgs_.I11l

				arg_37_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_4 = var_40_3:GetComponent("SpriteRenderer")

				if var_40_4 and var_40_4.sprite then
					local var_40_5 = 2 * (var_40_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_3.transform.localScale = Vector3.New(var_40_5 / var_40_4.sprite.bounds.size.y < var_40_5 * manager.ui.mainCameraCom_.aspect / var_40_4.sprite.bounds.size.x and var_40_5 * manager.ui.mainCameraCom_.aspect / var_40_4.sprite.bounds.size.x or var_40_5 / var_40_4.sprite.bounds.size.y, var_40_5 / var_40_4.sprite.bounds.size.y < var_40_5 * manager.ui.mainCameraCom_.aspect / var_40_4.sprite.bounds.size.x and var_40_5 * manager.ui.mainCameraCom_.aspect / var_40_4.sprite.bounds.size.x or var_40_5 / var_40_4.sprite.bounds.size.y, 0)
				end

				for iter_40_2, iter_40_3 in pairs(arg_37_1.bgs_) do
					if iter_40_2 ~= "I11l" then
						iter_40_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_6 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_7 = 2

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = Color.New(0, 0, 0)

				var_40_8.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_6) / var_40_7)
				arg_37_1.mask_.color = var_40_8
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				local var_40_9 = Color.New(0, 0, 0)

				var_40_9.a = 1
				arg_37_1.mask_.color = var_40_9
			end

			local var_40_10 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_11 = 1.3

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 then
				local var_40_12 = Color.New(0, 0, 0)

				var_40_12.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_10) / var_40_11)
				arg_37_1.mask_.color = var_40_12
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 then
				local var_40_13 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_13.a = 0
				arg_37_1.mask_.color = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["1084ui_story"].transform

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = var_40_14.localPosition

				arg_37_1:ShowWeapon(arg_37_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_40_15 = 0.001

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_15 then
				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 2) / var_40_15)
				var_40_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_14.position).x, (manager.ui.mainCamera.transform.position - var_40_14.position).y, (manager.ui.mainCamera.transform.position - var_40_14.position).z)
				var_40_14.localEulerAngles.z = 0
				var_40_14.localEulerAngles.x = 0
				var_40_14.localEulerAngles = var_40_14.localEulerAngles
			end

			if arg_37_1.time_ >= 2 + var_40_15 and arg_37_1.time_ < 2 + var_40_15 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(0, 100, 0)
				var_40_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_14.position).x, (manager.ui.mainCamera.transform.position - var_40_14.position).y, (manager.ui.mainCamera.transform.position - var_40_14.position).z)
				var_40_14.localEulerAngles.z = 0
				var_40_14.localEulerAngles.x = 0
				var_40_14.localEulerAngles = var_40_14.localEulerAngles
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_16 = 3.3
			local var_40_17 = 0.275

			if 3.3 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_18 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_18:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(319381009).content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 11 <= 0 and var_40_17 or var_40_17 * (utf8.len(var_40_19) / 11)

				if (11 <= 0 and var_40_17 or var_40_17 * (utf8.len(var_40_19) / 11)) > 0 and var_40_17 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21
					var_40_16 = var_40_16 + 0.3

					if var_40_21 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = var_40_16 + 0.3
			local var_40_23 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_22 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_22) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_22 + var_40_23 and arg_37_1.time_ < var_40_22 + var_40_23 + arg_40_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319381010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319381010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play319381011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.375

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(319381010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 15 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 15)

				if (15 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 15)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319381011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319381011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319381012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.35

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319381011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 54 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 54)

				if (54 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 54)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319381012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319381012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319381013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319381012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 58 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 58)

				if (58 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 58)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319381013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319381013
		arg_55_1.duration_ = 7.27

		local var_55_0 = {
			zh = 3.3,
			ja = 7.266
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319381014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_58_0 = 0.6

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				local var_58_1, var_58_2 = math.modf((arg_55_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_58_2 * 0.13, var_58_2 * 0.13, var_58_2 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				manager.ui.mainCamera.transform.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_3 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_3 + 0.6 and arg_55_1.time_ < var_58_3 + 0.6 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_4 = 0
			local var_58_5 = 0.375

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_6 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_6:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_7 = arg_55_1:GetWordFromCfg(319381013)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 15 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_8) / 15)

				if (15 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_8) / 15)) > 0 and var_58_5 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10
					var_58_4 = var_58_4 + 0.3

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381013", "story_v_out_319381.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_319381", "319381013", "story_v_out_319381.awb") / 1000

					if var_58_11 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_4
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_319381", "319381013", "story_v_out_319381.awb")

						arg_55_1:RecordAudio("319381013", var_58_12)
						arg_55_1:RecordAudio("319381013", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319381", "319381013", "story_v_out_319381.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319381", "319381013", "story_v_out_319381.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = var_58_4 + 0.3
			local var_58_14 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_13 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_13) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_13 + var_58_14 and arg_55_1.time_ < var_58_13 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play319381014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319381014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319381015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.475

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

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(319381014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 59 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 59)

				if (59 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 59)) > 0 and var_64_0 < var_64_3 then
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
	Play319381015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319381015
		arg_65_1.duration_ = 8.83

		local var_65_0 = {
			zh = 2.633,
			ja = 8.833
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
				arg_65_0:Play319381016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.25

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(319381015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 10)

				if (10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 10)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381015", "story_v_out_319381.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_319381", "319381015", "story_v_out_319381.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_319381", "319381015", "story_v_out_319381.awb")

						arg_65_1:RecordAudio("319381015", var_68_6)
						arg_65_1:RecordAudio("319381015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319381", "319381015", "story_v_out_319381.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319381", "319381015", "story_v_out_319381.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319381016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319381016
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319381017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = arg_69_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(arg_69_1.actors_["1084ui_story"]) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_72_2 = arg_69_1.actors_["1084ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1084ui_story = var_72_2.localPosition

				arg_69_1:ShowWeapon(arg_69_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_72_3 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_69_1.time_ - 0) / var_72_3)
				var_72_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_2.position).x, (manager.ui.mainCamera.transform.position - var_72_2.position).y, (manager.ui.mainCamera.transform.position - var_72_2.position).z)
				var_72_2.localEulerAngles.z = 0
				var_72_2.localEulerAngles.x = 0
				var_72_2.localEulerAngles = var_72_2.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -0.97, -6)
				var_72_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_2.position).x, (manager.ui.mainCamera.transform.position - var_72_2.position).y, (manager.ui.mainCamera.transform.position - var_72_2.position).z)
				var_72_2.localEulerAngles.z = 0
				var_72_2.localEulerAngles.x = 0
				var_72_2.localEulerAngles = var_72_2.localEulerAngles
			end

			local var_72_4 = 0
			local var_72_5 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
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

				local var_72_6 = arg_69_1:GetWordFromCfg(319381016)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 6 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 6)

				if (6 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 6)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381016", "story_v_out_319381.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381016", "story_v_out_319381.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_319381", "319381016", "story_v_out_319381.awb")

						arg_69_1:RecordAudio("319381016", var_72_11)
						arg_69_1:RecordAudio("319381016", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319381", "319381016", "story_v_out_319381.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319381", "319381016", "story_v_out_319381.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play319381017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319381017
		arg_73_1.duration_ = 9.27

		local var_73_0 = {
			zh = 2.5,
			ja = 9.266
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
				arg_73_0:Play319381018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "10066ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["10066ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["10066ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["10066ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["10066ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10066ui_story = var_76_3.localPosition
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["10066ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect10066ui_story == nil then
				arg_73_1.var_.characterEffect10066ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect10066ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect10066ui_story then
				arg_73_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_8 = arg_73_1.actors_["1084ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1084ui_story = var_76_8.localPosition
			end

			local var_76_9 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 then
				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_73_1.time_ - 0) / var_76_9)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			local var_76_10 = arg_73_1.actors_["1084ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_11 and not isNil(var_76_10) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_10) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_11)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_11 and arg_73_1.time_ < 0 + var_76_11 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_12 = 0
			local var_76_13 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(319381017)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 10 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 10)

				if (10 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 10)) > 0 and var_76_13 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381017", "story_v_out_319381.awb") ~= 0 then
					local var_76_18 = manager.audio:GetVoiceLength("story_v_out_319381", "319381017", "story_v_out_319381.awb") / 1000

					if var_76_18 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_12
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_319381", "319381017", "story_v_out_319381.awb")

						arg_73_1:RecordAudio("319381017", var_76_19)
						arg_73_1:RecordAudio("319381017", var_76_19)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319381", "319381017", "story_v_out_319381.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319381", "319381017", "story_v_out_319381.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_20 and arg_73_1.time_ < var_76_12 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play319381018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319381018
		arg_77_1.duration_ = 5.77

		local var_77_0 = {
			zh = 3.666,
			ja = 5.766
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
				arg_77_0:Play319381019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10066ui_story"]) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = arg_77_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10066ui_story"]) then
				if arg_77_1.var_.characterEffect10066ui_story and not isNil(arg_77_1.actors_["10066ui_story"]) then
					arg_77_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10066ui_story"]) and arg_77_1.var_.characterEffect10066ui_story then
				arg_77_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_80_1 = arg_77_1.actors_["1084ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(319381018)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 20 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 20)

				if (20 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 20)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381018", "story_v_out_319381.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381018", "story_v_out_319381.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_319381", "319381018", "story_v_out_319381.awb")

						arg_77_1:RecordAudio("319381018", var_80_11)
						arg_77_1:RecordAudio("319381018", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319381", "319381018", "story_v_out_319381.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319381", "319381018", "story_v_out_319381.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319381019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319381019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319381020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = arg_81_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(arg_81_1.actors_["1084ui_story"]) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 1

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

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(319381019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 40 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 40)

				if (40 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 40)) > 0 and var_84_2 < var_84_5 then
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

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319381020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319381020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319381021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.525

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

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(319381020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 61 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 61)

				if (61 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 61)) > 0 and var_88_0 < var_88_3 then
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
	Play319381021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319381021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319381022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.85

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319381021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 34 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 34)

				if (34 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 34)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319381022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319381022
		arg_93_1.duration_ = 8.2

		local var_93_0 = {
			zh = 8.2,
			ja = 6.533
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
				arg_93_0:Play319381023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10066ui_story"]) and arg_93_1.var_.characterEffect10066ui_story == nil then
				arg_93_1.var_.characterEffect10066ui_story = arg_93_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10066ui_story"]) then
				if arg_93_1.var_.characterEffect10066ui_story and not isNil(arg_93_1.actors_["10066ui_story"]) then
					arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10066ui_story"]) and arg_93_1.var_.characterEffect10066ui_story then
				arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action445")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(319381022)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 26 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 26)

				if (26 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 26)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381022", "story_v_out_319381.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381022", "story_v_out_319381.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_319381", "319381022", "story_v_out_319381.awb")

						arg_93_1:RecordAudio("319381022", var_96_9)
						arg_93_1:RecordAudio("319381022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319381", "319381022", "story_v_out_319381.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319381", "319381022", "story_v_out_319381.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319381023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319381023
		arg_97_1.duration_ = 10.57

		local var_97_0 = {
			zh = 6.3,
			ja = 10.566
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
				arg_97_0:Play319381024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = arg_97_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).z)
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles = arg_97_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_97_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).z)
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles = arg_97_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1084ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_100_4 = arg_97_1.actors_["10066ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10066ui_story then
				arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_100_6 = 0
			local var_100_7 = 0.7

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
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

				local var_100_8 = arg_97_1:GetWordFromCfg(319381023)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 28 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 28)

				if (28 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 28)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381023", "story_v_out_319381.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381023", "story_v_out_319381.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_319381", "319381023", "story_v_out_319381.awb")

						arg_97_1:RecordAudio("319381023", var_100_13)
						arg_97_1:RecordAudio("319381023", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319381", "319381023", "story_v_out_319381.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319381", "319381023", "story_v_out_319381.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319381024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319381024
		arg_101_1.duration_ = 9.5

		local var_101_0 = {
			zh = 6.2,
			ja = 9.5
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
				arg_101_0:Play319381025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = arg_101_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

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

			local var_104_1 = arg_101_1.actors_["10066ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10066ui_story == nil then
				arg_101_1.var_.characterEffect10066ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10066ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10066ui_story then
				arg_101_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action453")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(319381024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 24 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 24)

				if (24 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 24)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381024", "story_v_out_319381.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381024", "story_v_out_319381.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_319381", "319381024", "story_v_out_319381.awb")

						arg_101_1:RecordAudio("319381024", var_104_11)
						arg_101_1:RecordAudio("319381024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319381", "319381024", "story_v_out_319381.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319381", "319381024", "story_v_out_319381.awb")
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

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319381025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319381025
		arg_105_1.duration_ = 6.33

		local var_105_0 = {
			zh = 3.4,
			ja = 6.333
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
				arg_105_0:Play319381026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10066ui_story = arg_105_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).z)
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles = arg_105_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_105_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).z)
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles = arg_105_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10066ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10066ui_story == nil then
				arg_105_1.var_.characterEffect10066ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10066ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10066ui_story then
				arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(319381025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 14 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 14)

				if (14 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 14)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381025", "story_v_out_319381.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381025", "story_v_out_319381.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_319381", "319381025", "story_v_out_319381.awb")

						arg_105_1:RecordAudio("319381025", var_108_11)
						arg_105_1:RecordAudio("319381025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319381", "319381025", "story_v_out_319381.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319381", "319381025", "story_v_out_319381.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play319381026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319381026
		arg_109_1.duration_ = 3.23

		local var_109_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_109_0:Play319381027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10066ui_story"]) and arg_109_1.var_.characterEffect10066ui_story == nil then
				arg_109_1.var_.characterEffect10066ui_story = arg_109_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10066ui_story"]) then
				if arg_109_1.var_.characterEffect10066ui_story and not isNil(arg_109_1.actors_["10066ui_story"]) then
					arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10066ui_story"]) and arg_109_1.var_.characterEffect10066ui_story then
				arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["1084ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
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

				local var_112_6 = arg_109_1:GetWordFromCfg(319381026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 5 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 5)

				if (5 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 5)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381026", "story_v_out_319381.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381026", "story_v_out_319381.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_319381", "319381026", "story_v_out_319381.awb")

						arg_109_1:RecordAudio("319381026", var_112_11)
						arg_109_1:RecordAudio("319381026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319381", "319381026", "story_v_out_319381.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319381", "319381026", "story_v_out_319381.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319381027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319381027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319381028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = arg_113_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(arg_113_1.actors_["1084ui_story"]) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(319381027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 27)

				if (27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 27)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319381028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319381028
		arg_117_1.duration_ = 16.07

		local var_117_0 = {
			zh = 5.733,
			ja = 16.066
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
				arg_117_0:Play319381029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10066ui_story = arg_117_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).z)
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles = arg_117_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_117_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10066ui_story"].transform.position).z)
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10066ui_story"].transform.localEulerAngles = arg_117_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10066ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10066ui_story == nil then
				arg_117_1.var_.characterEffect10066ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10066ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10066ui_story then
				arg_117_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.65

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(319381028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 26 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 26)

				if (26 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 26)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381028", "story_v_out_319381.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381028", "story_v_out_319381.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_319381", "319381028", "story_v_out_319381.awb")

						arg_117_1:RecordAudio("319381028", var_120_11)
						arg_117_1:RecordAudio("319381028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319381", "319381028", "story_v_out_319381.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319381", "319381028", "story_v_out_319381.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play319381029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319381029
		arg_121_1.duration_ = 4.67

		local var_121_0 = {
			zh = 2.866,
			ja = 4.666
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
				arg_121_0:Play319381030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = arg_121_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).z)
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles = arg_121_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_121_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).z)
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles = arg_121_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1084ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = arg_121_1.actors_["10066ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10066ui_story == nil then
				arg_121_1.var_.characterEffect10066ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect10066ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10066ui_story then
				arg_121_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			local var_124_6 = 0
			local var_124_7 = 0.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
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

				local var_124_8 = arg_121_1:GetWordFromCfg(319381029)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 6 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 6)

				if (6 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 6)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381029", "story_v_out_319381.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381029", "story_v_out_319381.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_319381", "319381029", "story_v_out_319381.awb")

						arg_121_1:RecordAudio("319381029", var_124_13)
						arg_121_1:RecordAudio("319381029", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319381", "319381029", "story_v_out_319381.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319381", "319381029", "story_v_out_319381.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play319381030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319381030
		arg_125_1.duration_ = 7.33

		local var_125_0 = {
			zh = 4.633,
			ja = 7.333
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
				arg_125_0:Play319381031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = arg_125_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

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

			local var_128_1 = arg_125_1.actors_["10066ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10066ui_story == nil then
				arg_125_1.var_.characterEffect10066ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10066ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10066ui_story then
				arg_125_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(319381030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 18 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 18)

				if (18 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 18)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381030", "story_v_out_319381.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381030", "story_v_out_319381.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_319381", "319381030", "story_v_out_319381.awb")

						arg_125_1:RecordAudio("319381030", var_128_11)
						arg_125_1:RecordAudio("319381030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319381", "319381030", "story_v_out_319381.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319381", "319381030", "story_v_out_319381.awb")
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

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319381031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319381031
		arg_129_1.duration_ = 3.47

		local var_129_0 = {
			zh = 3.466,
			ja = 3.4
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
				arg_129_0:Play319381032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10066ui_story"]) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = arg_129_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10066ui_story"]) then
				if arg_129_1.var_.characterEffect10066ui_story and not isNil(arg_129_1.actors_["10066ui_story"]) then
					arg_129_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10066ui_story"]) and arg_129_1.var_.characterEffect10066ui_story then
				arg_129_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_132_1 = arg_129_1.actors_["1084ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.2

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(319381031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 8 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 8)

				if (8 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 8)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381031", "story_v_out_319381.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381031", "story_v_out_319381.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_319381", "319381031", "story_v_out_319381.awb")

						arg_129_1:RecordAudio("319381031", var_132_11)
						arg_129_1:RecordAudio("319381031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319381", "319381031", "story_v_out_319381.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319381", "319381031", "story_v_out_319381.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319381032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319381032
		arg_133_1.duration_ = 7.1

		local var_133_0 = {
			zh = 2.766,
			ja = 7.1
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
				arg_133_0:Play319381033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = arg_133_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) then
				if arg_133_1.var_.characterEffect10066ui_story and not isNil(arg_133_1.actors_["10066ui_story"]) then
					arg_133_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) and arg_133_1.var_.characterEffect10066ui_story then
				arg_133_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["1084ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(319381032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 9 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 9)

				if (9 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 9)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381032", "story_v_out_319381.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381032", "story_v_out_319381.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_319381", "319381032", "story_v_out_319381.awb")

						arg_133_1:RecordAudio("319381032", var_136_11)
						arg_133_1:RecordAudio("319381032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319381", "319381032", "story_v_out_319381.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319381", "319381032", "story_v_out_319381.awb")
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
	Play319381033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319381033
		arg_137_1.duration_ = 5.17

		local var_137_0 = {
			zh = 5.166,
			ja = 4.3
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
				arg_137_0:Play319381034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_0 = 0
			local var_140_1 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(319381033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 20 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 20)

				if (20 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 20)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381033", "story_v_out_319381.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_319381", "319381033", "story_v_out_319381.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_319381", "319381033", "story_v_out_319381.awb")

						arg_137_1:RecordAudio("319381033", var_140_7)
						arg_137_1:RecordAudio("319381033", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319381", "319381033", "story_v_out_319381.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319381", "319381033", "story_v_out_319381.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319381034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319381034
		arg_141_1.duration_ = 3.7

		local var_141_0 = {
			zh = 1.999999999999,
			ja = 3.7
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
				arg_141_0:Play319381035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = arg_141_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(arg_141_1.actors_["1084ui_story"]) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_2 = arg_141_1.actors_["10066ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10066ui_story == nil then
				arg_141_1.var_.characterEffect10066ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect10066ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10066ui_story then
				arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(319381034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 3 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 3)

				if (3 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 3)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381034", "story_v_out_319381.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381034", "story_v_out_319381.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_319381", "319381034", "story_v_out_319381.awb")

						arg_141_1:RecordAudio("319381034", var_144_11)
						arg_141_1:RecordAudio("319381034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319381", "319381034", "story_v_out_319381.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319381", "319381034", "story_v_out_319381.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319381035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319381035
		arg_145_1.duration_ = 12.43

		local var_145_0 = {
			zh = 8.4,
			ja = 12.433
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
				arg_145_0:Play319381036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.I11q == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11q")
				var_148_0.name = "I11q"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.I11q = var_148_0
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.I11q

				arg_145_1.bgs_.I11q.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "I11q" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_4 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_5 = 2

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_5 then
				local var_148_6 = Color.New(0, 0, 0)

				var_148_6.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_4) / var_148_5)
				arg_145_1.mask_.color = var_148_6
			end

			if arg_145_1.time_ >= var_148_4 + var_148_5 and arg_145_1.time_ < var_148_4 + var_148_5 + arg_148_0 then
				local var_148_7 = Color.New(0, 0, 0)

				var_148_7.a = 1
				arg_145_1.mask_.color = var_148_7
			end

			local var_148_8 = 2

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 then
				local var_148_10 = Color.New(0, 0, 0)

				var_148_10.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_8) / var_148_9)
				arg_145_1.mask_.color = var_148_10
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 then
				local var_148_11 = Color.New(0, 0, 0)

				arg_145_1.mask_.enabled = false
				var_148_11.a = 0
				arg_145_1.mask_.color = var_148_11
			end

			local var_148_12 = arg_145_1.actors_["1084ui_story"].transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPos1084ui_story = var_148_12.localPosition
			end

			local var_148_13 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_13 then
				var_148_12.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 2) / var_148_13)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles
			end

			if arg_145_1.time_ >= 2 + var_148_13 and arg_145_1.time_ < 2 + var_148_13 + arg_148_0 then
				var_148_12.localPosition = Vector3.New(0, 100, 0)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles
			end

			local var_148_14 = arg_145_1.actors_["1084ui_story"]

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_15 = 0.200000002980232

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_15 and not isNil(var_148_14) then
				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_14) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 2) / var_148_15)
				end
			end

			if arg_145_1.time_ >= 2 + var_148_15 and arg_145_1.time_ < 2 + var_148_15 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_148_16 = "1095ui_story"

			if arg_145_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_148_17 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_145_1.stage_.transform)

				var_148_17.name = var_148_16
				var_148_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_16] = var_148_17

				local var_148_18 = var_148_17:GetComponentInChildren(typeof(CharacterEffect))

				var_148_18.enabled = true

				local var_148_19 = GameObjectTools.GetOrAddComponent(var_148_17, typeof(DynamicBoneHelper))

				if var_148_19 then
					var_148_19:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_18.transform, false)

				arg_145_1.var_[var_148_16 .. "Animator"] = var_148_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_16 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_16 .. "LipSync"] = var_148_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_20 = arg_145_1.actors_["1095ui_story"].transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = var_148_20.localPosition
			end

			local var_148_21 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_21 then
				var_148_20.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_145_1.time_ - 2) / var_148_21)
				var_148_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_20.position).x, (manager.ui.mainCamera.transform.position - var_148_20.position).y, (manager.ui.mainCamera.transform.position - var_148_20.position).z)
				var_148_20.localEulerAngles.z = 0
				var_148_20.localEulerAngles.x = 0
				var_148_20.localEulerAngles = var_148_20.localEulerAngles
			end

			if arg_145_1.time_ >= 2 + var_148_21 and arg_145_1.time_ < 2 + var_148_21 + arg_148_0 then
				var_148_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_148_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_20.position).x, (manager.ui.mainCamera.transform.position - var_148_20.position).y, (manager.ui.mainCamera.transform.position - var_148_20.position).z)
				var_148_20.localEulerAngles.z = 0
				var_148_20.localEulerAngles.x = 0
				var_148_20.localEulerAngles = var_148_20.localEulerAngles
			end

			local var_148_22 = arg_145_1.actors_["1095ui_story"]

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_23 = 0.200000002980232

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_23 and not isNil(var_148_22) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_22) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 2 + var_148_23 and arg_145_1.time_ < 2 + var_148_23 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_25 = arg_145_1.actors_["10066ui_story"]

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 and not isNil(var_148_25) and arg_145_1.var_.characterEffect10066ui_story == nil then
				arg_145_1.var_.characterEffect10066ui_story = var_148_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_26 = 0.200000002980232

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_26 and not isNil(var_148_25) then
				if arg_145_1.var_.characterEffect10066ui_story and not isNil(var_148_25) then
					arg_145_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 2) / var_148_26)
				end
			end

			if arg_145_1.time_ >= 2 + var_148_26 and arg_145_1.time_ < 2 + var_148_26 + arg_148_0 and not isNil(var_148_25) and arg_145_1.var_.characterEffect10066ui_story then
				arg_145_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_148_27 = arg_145_1.actors_["10066ui_story"].transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPos10066ui_story = var_148_27.localPosition
			end

			local var_148_28 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_28 then
				var_148_27.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 2) / var_148_28)
				var_148_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_27.position).x, (manager.ui.mainCamera.transform.position - var_148_27.position).y, (manager.ui.mainCamera.transform.position - var_148_27.position).z)
				var_148_27.localEulerAngles.z = 0
				var_148_27.localEulerAngles.x = 0
				var_148_27.localEulerAngles = var_148_27.localEulerAngles
			end

			if arg_145_1.time_ >= 2 + var_148_28 and arg_145_1.time_ < 2 + var_148_28 + arg_148_0 then
				var_148_27.localPosition = Vector3.New(0, 100, 0)
				var_148_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_27.position).x, (manager.ui.mainCamera.transform.position - var_148_27.position).y, (manager.ui.mainCamera.transform.position - var_148_27.position).z)
				var_148_27.localEulerAngles.z = 0
				var_148_27.localEulerAngles.x = 0
				var_148_27.localEulerAngles = var_148_27.localEulerAngles
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_29 = "10079ui_story"

			if arg_145_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_148_30 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_145_1.stage_.transform)

				var_148_30.name = var_148_29
				var_148_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_29] = var_148_30

				local var_148_31 = var_148_30:GetComponentInChildren(typeof(CharacterEffect))

				var_148_31.enabled = true

				local var_148_32 = GameObjectTools.GetOrAddComponent(var_148_30, typeof(DynamicBoneHelper))

				if var_148_32 then
					var_148_32:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_31.transform, false)

				arg_145_1.var_[var_148_29 .. "Animator"] = var_148_31.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_29 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_29 .. "LipSync"] = var_148_31.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_33 = arg_145_1.actors_["10079ui_story"].transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPos10079ui_story = var_148_33.localPosition
			end

			local var_148_34 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_34 then
				var_148_33.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_145_1.time_ - 2) / var_148_34)
				var_148_33.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_33.position).x, (manager.ui.mainCamera.transform.position - var_148_33.position).y, (manager.ui.mainCamera.transform.position - var_148_33.position).z)
				var_148_33.localEulerAngles.z = 0
				var_148_33.localEulerAngles.x = 0
				var_148_33.localEulerAngles = var_148_33.localEulerAngles
			end

			if arg_145_1.time_ >= 2 + var_148_34 and arg_145_1.time_ < 2 + var_148_34 + arg_148_0 then
				var_148_33.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_148_33.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_33.position).x, (manager.ui.mainCamera.transform.position - var_148_33.position).y, (manager.ui.mainCamera.transform.position - var_148_33.position).z)
				var_148_33.localEulerAngles.z = 0
				var_148_33.localEulerAngles.x = 0
				var_148_33.localEulerAngles = var_148_33.localEulerAngles
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_35 = arg_145_1.actors_["10079ui_story"]

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 and not isNil(var_148_35) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = var_148_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_36 = 0.200000002980232

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_36 and not isNil(var_148_35) then
				if arg_145_1.var_.characterEffect10079ui_story and not isNil(var_148_35) then
					arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 2) / var_148_36)
				end
			end

			if arg_145_1.time_ >= 2 + var_148_36 and arg_145_1.time_ < 2 + var_148_36 + arg_148_0 and not isNil(var_148_35) and arg_145_1.var_.characterEffect10079ui_story then
				arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_148_37 = 2

			arg_145_1.isInRecall_ = false

			if var_148_37 < arg_145_1.time_ and arg_145_1.time_ <= var_148_37 + arg_148_0 then
				arg_145_1.screenFilterGo_:SetActive(true)

				arg_145_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_148_2, iter_148_3 in pairs(arg_145_1.actors_) do
					for iter_148_4, iter_148_5 in ipairs((iter_148_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_148_5.color = iter_148_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_148_38 = 0.034000001847744

			if var_148_37 <= arg_145_1.time_ and arg_145_1.time_ < var_148_37 + var_148_38 then
				arg_145_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_37) / var_148_38)
			end

			if arg_145_1.time_ >= var_148_37 + var_148_38 and arg_145_1.time_ < var_148_37 + var_148_38 + arg_148_0 then
				arg_145_1.screenFilterEffect_.weight = 1
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_39 = 2
			local var_148_40 = 0.7

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_39 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_41 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_41:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_42 = arg_145_1:GetWordFromCfg(319381035)
				local var_148_43 = arg_145_1:FormatText(var_148_42.content)

				arg_145_1.text_.text = var_148_43

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_45 = 28 <= 0 and var_148_40 or var_148_40 * (utf8.len(var_148_43) / 28)

				if (28 <= 0 and var_148_40 or var_148_40 * (utf8.len(var_148_43) / 28)) > 0 and var_148_40 < var_148_45 then
					arg_145_1.talkMaxDuration = var_148_45
					var_148_39 = var_148_39 + 0.3

					if var_148_45 + var_148_39 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_45 + var_148_39
					end
				end

				arg_145_1.text_.text = var_148_43
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381035", "story_v_out_319381.awb") ~= 0 then
					local var_148_46 = manager.audio:GetVoiceLength("story_v_out_319381", "319381035", "story_v_out_319381.awb") / 1000

					if var_148_46 + var_148_39 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_46 + var_148_39
					end

					if var_148_42.prefab_name ~= "" and arg_145_1.actors_[var_148_42.prefab_name] ~= nil then
						local var_148_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_42.prefab_name].transform, "story_v_out_319381", "319381035", "story_v_out_319381.awb")

						arg_145_1:RecordAudio("319381035", var_148_47)
						arg_145_1:RecordAudio("319381035", var_148_47)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319381", "319381035", "story_v_out_319381.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319381", "319381035", "story_v_out_319381.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_48 = var_148_39 + 0.3
			local var_148_49 = math.max(var_148_40, arg_145_1.talkMaxDuration)

			if var_148_39 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_48 + var_148_49 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_48) / var_148_49

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_48 + var_148_49 and arg_145_1.time_ < var_148_48 + var_148_49 + arg_148_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play319381036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319381036
		arg_151_1.duration_ = 7.83

		local var_151_0 = {
			zh = 4.533,
			ja = 7.833
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
				arg_151_0:Play319381037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1095ui_story"]) and arg_151_1.var_.characterEffect1095ui_story == nil then
				arg_151_1.var_.characterEffect1095ui_story = arg_151_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1095ui_story"]) then
				if arg_151_1.var_.characterEffect1095ui_story and not isNil(arg_151_1.actors_["1095ui_story"]) then
					arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1095ui_story"]) and arg_151_1.var_.characterEffect1095ui_story then
				arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["10079ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10079ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10079ui_story then
				arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_154_3 = 0
			local var_154_4 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:GetWordFromCfg(319381036)
				local var_154_6 = arg_151_1:FormatText(var_154_5.content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 24 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 24)

				if (24 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 24)) > 0 and var_154_4 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381036", "story_v_out_319381.awb") ~= 0 then
					local var_154_9 = manager.audio:GetVoiceLength("story_v_out_319381", "319381036", "story_v_out_319381.awb") / 1000

					if var_154_9 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_3
					end

					if var_154_5.prefab_name ~= "" and arg_151_1.actors_[var_154_5.prefab_name] ~= nil then
						local var_154_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_5.prefab_name].transform, "story_v_out_319381", "319381036", "story_v_out_319381.awb")

						arg_151_1:RecordAudio("319381036", var_154_10)
						arg_151_1:RecordAudio("319381036", var_154_10)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319381", "319381036", "story_v_out_319381.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319381", "319381036", "story_v_out_319381.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_11 and arg_151_1.time_ < var_154_3 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319381037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319381037
		arg_155_1.duration_ = 6.47

		local var_155_0 = {
			zh = 6.46666666666667,
			ja = 6.09966666666667
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319381038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				local var_158_0 = arg_155_1.bgs_.I11l

				arg_155_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_1 = var_158_0:GetComponent("SpriteRenderer")

				if var_158_1 and var_158_1.sprite then
					local var_158_2 = 2 * (var_158_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_0.transform.localScale = Vector3.New(var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "I11l" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_3 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_4 = 2

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_4 then
				local var_158_5 = Color.New(0, 0, 0)

				var_158_5.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_3) / var_158_4)
				arg_155_1.mask_.color = var_158_5
			end

			if arg_155_1.time_ >= var_158_3 + var_158_4 and arg_155_1.time_ < var_158_3 + var_158_4 + arg_158_0 then
				local var_158_6 = Color.New(0, 0, 0)

				var_158_6.a = 1
				arg_155_1.mask_.color = var_158_6
			end

			local var_158_7 = 2

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_8 = 2

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 then
				local var_158_9 = Color.New(0, 0, 0)

				var_158_9.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_7) / var_158_8)
				arg_155_1.mask_.color = var_158_9
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 then
				local var_158_10 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_10.a = 0
				arg_155_1.mask_.color = var_158_10
			end

			local var_158_11 = arg_155_1.actors_["1084ui_story"].transform

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = var_158_11.localPosition
			end

			local var_158_12 = 0.001

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_12 then
				var_158_11.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_155_1.time_ - 3.79999999701977) / var_158_12)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_12 and arg_155_1.time_ < 3.79999999701977 + var_158_12 + arg_158_0 then
				var_158_11.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			local var_158_13 = arg_155_1.actors_["1084ui_story"]

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 and not isNil(var_158_13) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = var_158_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_14 = 0.200000002980232

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_14 and not isNil(var_158_13) then
				if arg_155_1.var_.characterEffect1084ui_story and not isNil(var_158_13) then
					arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_14 and arg_155_1.time_ < 3.79999999701977 + var_158_14 + arg_158_0 and not isNil(var_158_13) and arg_155_1.var_.characterEffect1084ui_story then
				arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_158_16 = arg_155_1.actors_["1095ui_story"].transform

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				arg_155_1.var_.moveOldPos1095ui_story = var_158_16.localPosition
			end

			local var_158_17 = 0.001

			if 2 <= arg_155_1.time_ and arg_155_1.time_ < 2 + var_158_17 then
				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 2) / var_158_17)
				var_158_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_16.position).x, (manager.ui.mainCamera.transform.position - var_158_16.position).y, (manager.ui.mainCamera.transform.position - var_158_16.position).z)
				var_158_16.localEulerAngles.z = 0
				var_158_16.localEulerAngles.x = 0
				var_158_16.localEulerAngles = var_158_16.localEulerAngles
			end

			if arg_155_1.time_ >= 2 + var_158_17 and arg_155_1.time_ < 2 + var_158_17 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(0, 100, 0)
				var_158_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_16.position).x, (manager.ui.mainCamera.transform.position - var_158_16.position).y, (manager.ui.mainCamera.transform.position - var_158_16.position).z)
				var_158_16.localEulerAngles.z = 0
				var_158_16.localEulerAngles.x = 0
				var_158_16.localEulerAngles = var_158_16.localEulerAngles
			end

			local var_158_18 = arg_155_1.actors_["1095ui_story"]

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 and not isNil(var_158_18) and arg_155_1.var_.characterEffect1095ui_story == nil then
				arg_155_1.var_.characterEffect1095ui_story = var_158_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_19 = 0.200000002980232

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_19 and not isNil(var_158_18) then
				if arg_155_1.var_.characterEffect1095ui_story and not isNil(var_158_18) then
					arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 3.79999999701977) / var_158_19)
				end
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_19 and arg_155_1.time_ < 3.79999999701977 + var_158_19 + arg_158_0 and not isNil(var_158_18) and arg_155_1.var_.characterEffect1095ui_story then
				arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_158_20 = arg_155_1.actors_["10066ui_story"]

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 and not isNil(var_158_20) and arg_155_1.var_.characterEffect10066ui_story == nil then
				arg_155_1.var_.characterEffect10066ui_story = var_158_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_21 = 0.200000002980232

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_21 and not isNil(var_158_20) then
				if arg_155_1.var_.characterEffect10066ui_story and not isNil(var_158_20) then
					arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 3.79999999701977) / var_158_21)
				end
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_21 and arg_155_1.time_ < 3.79999999701977 + var_158_21 + arg_158_0 and not isNil(var_158_20) and arg_155_1.var_.characterEffect10066ui_story then
				arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_158_22 = arg_155_1.actors_["10066ui_story"].transform

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 then
				arg_155_1.var_.moveOldPos10066ui_story = var_158_22.localPosition
			end

			local var_158_23 = 0.001

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_23 then
				var_158_22.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_155_1.time_ - 3.79999999701977) / var_158_23)
				var_158_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_22.position).x, (manager.ui.mainCamera.transform.position - var_158_22.position).y, (manager.ui.mainCamera.transform.position - var_158_22.position).z)
				var_158_22.localEulerAngles.z = 0
				var_158_22.localEulerAngles.x = 0
				var_158_22.localEulerAngles = var_158_22.localEulerAngles
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_23 and arg_155_1.time_ < 3.79999999701977 + var_158_23 + arg_158_0 then
				var_158_22.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_158_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_22.position).x, (manager.ui.mainCamera.transform.position - var_158_22.position).y, (manager.ui.mainCamera.transform.position - var_158_22.position).z)
				var_158_22.localEulerAngles.z = 0
				var_158_22.localEulerAngles.x = 0
				var_158_22.localEulerAngles = var_158_22.localEulerAngles
			end

			local var_158_24 = arg_155_1.actors_["10079ui_story"].transform

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = var_158_24.localPosition
			end

			local var_158_25 = 0.001

			if 2 <= arg_155_1.time_ and arg_155_1.time_ < 2 + var_158_25 then
				var_158_24.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 2) / var_158_25)
				var_158_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_24.position).x, (manager.ui.mainCamera.transform.position - var_158_24.position).y, (manager.ui.mainCamera.transform.position - var_158_24.position).z)
				var_158_24.localEulerAngles.z = 0
				var_158_24.localEulerAngles.x = 0
				var_158_24.localEulerAngles = var_158_24.localEulerAngles
			end

			if arg_155_1.time_ >= 2 + var_158_25 and arg_155_1.time_ < 2 + var_158_25 + arg_158_0 then
				var_158_24.localPosition = Vector3.New(0, 100, 0)
				var_158_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_24.position).x, (manager.ui.mainCamera.transform.position - var_158_24.position).y, (manager.ui.mainCamera.transform.position - var_158_24.position).z)
				var_158_24.localEulerAngles.z = 0
				var_158_24.localEulerAngles.x = 0
				var_158_24.localEulerAngles = var_158_24.localEulerAngles
			end

			local var_158_26 = arg_155_1.actors_["10079ui_story"]

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 and not isNil(var_158_26) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = var_158_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_27 = 0.200000002980232

			if 3.79999999701977 <= arg_155_1.time_ and arg_155_1.time_ < 3.79999999701977 + var_158_27 and not isNil(var_158_26) then
				if arg_155_1.var_.characterEffect10079ui_story and not isNil(var_158_26) then
					arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 3.79999999701977) / var_158_27)
				end
			end

			if arg_155_1.time_ >= 3.79999999701977 + var_158_27 and arg_155_1.time_ < 3.79999999701977 + var_158_27 + arg_158_0 and not isNil(var_158_26) and arg_155_1.var_.characterEffect10079ui_story then
				arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 3.79999999701977 < arg_155_1.time_ and arg_155_1.time_ <= 3.79999999701977 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_28 = 2

			arg_155_1.isInRecall_ = false

			if var_158_28 < arg_155_1.time_ and arg_155_1.time_ <= var_158_28 + arg_158_0 then
				arg_155_1.screenFilterGo_:SetActive(false)

				for iter_158_2, iter_158_3 in pairs(arg_155_1.actors_) do
					for iter_158_4, iter_158_5 in ipairs((iter_158_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_158_5.color = iter_158_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_158_29 = 0.0166666666666667

			if var_158_28 <= arg_155_1.time_ and arg_155_1.time_ < var_158_28 + var_158_29 then
				arg_155_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_28) / var_158_29)
			end

			if arg_155_1.time_ >= var_158_28 + var_158_29 and arg_155_1.time_ < var_158_28 + var_158_29 + arg_158_0 then
				arg_155_1.screenFilterEffect_.weight = 0
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_30 = 4.16666666666667
			local var_158_31 = 0.225

			if 4.16666666666667 < arg_155_1.time_ and arg_155_1.time_ <= var_158_30 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_32 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_32:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_33 = arg_155_1:GetWordFromCfg(319381037)
				local var_158_34 = arg_155_1:FormatText(var_158_33.content)

				arg_155_1.text_.text = var_158_34

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_36 = 9 <= 0 and var_158_31 or var_158_31 * (utf8.len(var_158_34) / 9)

				if (9 <= 0 and var_158_31 or var_158_31 * (utf8.len(var_158_34) / 9)) > 0 and var_158_31 < var_158_36 then
					arg_155_1.talkMaxDuration = var_158_36
					var_158_30 = var_158_30 + 0.3

					if var_158_36 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_36 + var_158_30
					end
				end

				arg_155_1.text_.text = var_158_34
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381037", "story_v_out_319381.awb") ~= 0 then
					local var_158_37 = manager.audio:GetVoiceLength("story_v_out_319381", "319381037", "story_v_out_319381.awb") / 1000

					if var_158_37 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_37 + var_158_30
					end

					if var_158_33.prefab_name ~= "" and arg_155_1.actors_[var_158_33.prefab_name] ~= nil then
						local var_158_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_33.prefab_name].transform, "story_v_out_319381", "319381037", "story_v_out_319381.awb")

						arg_155_1:RecordAudio("319381037", var_158_38)
						arg_155_1:RecordAudio("319381037", var_158_38)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319381", "319381037", "story_v_out_319381.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319381", "319381037", "story_v_out_319381.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_39 = var_158_30 + 0.3
			local var_158_40 = math.max(var_158_31, arg_155_1.talkMaxDuration)

			if var_158_30 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_40 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_39) / var_158_40

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_39 + var_158_40 and arg_155_1.time_ < var_158_39 + var_158_40 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319381038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319381038
		arg_161_1.duration_ = 5.73

		local var_161_0 = {
			zh = 5.466,
			ja = 5.733
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
				arg_161_0:Play319381039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10066ui_story"]) and arg_161_1.var_.characterEffect10066ui_story == nil then
				arg_161_1.var_.characterEffect10066ui_story = arg_161_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10066ui_story"]) then
				if arg_161_1.var_.characterEffect10066ui_story and not isNil(arg_161_1.actors_["10066ui_story"]) then
					arg_161_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10066ui_story"]) and arg_161_1.var_.characterEffect10066ui_story then
				arg_161_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_164_2 = arg_161_1.actors_["1084ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1084ui_story then
				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_164_4 = 0
			local var_164_5 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(319381038)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 13 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 13)

				if (13 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 13)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381038", "story_v_out_319381.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381038", "story_v_out_319381.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_319381", "319381038", "story_v_out_319381.awb")

						arg_161_1:RecordAudio("319381038", var_164_11)
						arg_161_1:RecordAudio("319381038", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319381", "319381038", "story_v_out_319381.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319381", "319381038", "story_v_out_319381.awb")
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

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319381039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319381039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319381040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10066ui_story"]) and arg_165_1.var_.characterEffect10066ui_story == nil then
				arg_165_1.var_.characterEffect10066ui_story = arg_165_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10066ui_story"]) then
				if arg_165_1.var_.characterEffect10066ui_story and not isNil(arg_165_1.actors_["10066ui_story"]) then
					arg_165_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10066ui_story"]) and arg_165_1.var_.characterEffect10066ui_story then
				arg_165_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 1.025

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(319381039).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 41 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 41)

				if (41 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 41)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319381040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319381040
		arg_169_1.duration_ = 8.97

		local var_169_0 = {
			zh = 4.933,
			ja = 8.966
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
				arg_169_0:Play319381041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) and arg_169_1.var_.characterEffect10066ui_story == nil then
				arg_169_1.var_.characterEffect10066ui_story = arg_169_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) then
				if arg_169_1.var_.characterEffect10066ui_story and not isNil(arg_169_1.actors_["10066ui_story"]) then
					arg_169_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) and arg_169_1.var_.characterEffect10066ui_story then
				arg_169_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_172_2 = arg_169_1.actors_["1084ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1084ui_story == nil then
				arg_169_1.var_.characterEffect1084ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1084ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1084ui_story then
				arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.35

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(319381040)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 14 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 14)

				if (14 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 14)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381040", "story_v_out_319381.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381040", "story_v_out_319381.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_319381", "319381040", "story_v_out_319381.awb")

						arg_169_1:RecordAudio("319381040", var_172_11)
						arg_169_1:RecordAudio("319381040", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319381", "319381040", "story_v_out_319381.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319381", "319381040", "story_v_out_319381.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319381041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319381041
		arg_173_1.duration_ = 5.73

		local var_173_0 = {
			zh = 2.566,
			ja = 5.733
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319381042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1084ui_story = arg_173_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).z)
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles = arg_173_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_173_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).z)
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles = arg_173_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1084ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1084ui_story == nil then
				arg_173_1.var_.characterEffect1084ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1084ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1084ui_story then
				arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["10066ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10066ui_story == nil then
				arg_173_1.var_.characterEffect10066ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect10066ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10066ui_story then
				arg_173_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_176_6 = 0
			local var_176_7 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(319381041)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 9 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 9)

				if (9 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 9)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381041", "story_v_out_319381.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381041", "story_v_out_319381.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_319381", "319381041", "story_v_out_319381.awb")

						arg_173_1:RecordAudio("319381041", var_176_13)
						arg_173_1:RecordAudio("319381041", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319381", "319381041", "story_v_out_319381.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319381", "319381041", "story_v_out_319381.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319381042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319381042
		arg_177_1.duration_ = 10.77

		local var_177_0 = {
			zh = 4.833,
			ja = 10.766
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
				arg_177_0:Play319381043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10066ui_story = arg_177_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).z)
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles = arg_177_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_177_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10066ui_story"].transform.position).z)
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10066ui_story"].transform.localEulerAngles = arg_177_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10066ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10066ui_story == nil then
				arg_177_1.var_.characterEffect10066ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10066ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10066ui_story then
				arg_177_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1084ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_180_6 = 0
			local var_180_7 = 0.525

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(319381042)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 21 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 21)

				if (21 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 21)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381042", "story_v_out_319381.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381042", "story_v_out_319381.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_319381", "319381042", "story_v_out_319381.awb")

						arg_177_1:RecordAudio("319381042", var_180_13)
						arg_177_1:RecordAudio("319381042", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319381", "319381042", "story_v_out_319381.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319381", "319381042", "story_v_out_319381.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play319381043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319381043
		arg_181_1.duration_ = 14.07

		local var_181_0 = {
			zh = 7.5,
			ja = 14.066
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
				arg_181_0:Play319381044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_184_0 = 0
			local var_184_1 = 0.775

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(319381043)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 31 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 31)

				if (31 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 31)) > 0 and var_184_1 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381043", "story_v_out_319381.awb") ~= 0 then
					local var_184_6 = manager.audio:GetVoiceLength("story_v_out_319381", "319381043", "story_v_out_319381.awb") / 1000

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end

					if var_184_2.prefab_name ~= "" and arg_181_1.actors_[var_184_2.prefab_name] ~= nil then
						local var_184_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_2.prefab_name].transform, "story_v_out_319381", "319381043", "story_v_out_319381.awb")

						arg_181_1:RecordAudio("319381043", var_184_7)
						arg_181_1:RecordAudio("319381043", var_184_7)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319381", "319381043", "story_v_out_319381.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319381", "319381043", "story_v_out_319381.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319381044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319381044
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 4.166,
			ja = 7.3
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
				arg_185_0:Play319381045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10066ui_story"]) and arg_185_1.var_.characterEffect10066ui_story == nil then
				arg_185_1.var_.characterEffect10066ui_story = arg_185_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10066ui_story"]) then
				if arg_185_1.var_.characterEffect10066ui_story and not isNil(arg_185_1.actors_["10066ui_story"]) then
					arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10066ui_story"]) and arg_185_1.var_.characterEffect10066ui_story then
				arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_188_1 = arg_185_1.actors_["1084ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.425

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
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

				local var_188_6 = arg_185_1:GetWordFromCfg(319381044)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 17 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 17)

				if (17 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 17)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381044", "story_v_out_319381.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381044", "story_v_out_319381.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_319381", "319381044", "story_v_out_319381.awb")

						arg_185_1:RecordAudio("319381044", var_188_11)
						arg_185_1:RecordAudio("319381044", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319381", "319381044", "story_v_out_319381.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319381", "319381044", "story_v_out_319381.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319381045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319381045
		arg_189_1.duration_ = 2.27

		local var_189_0 = {
			zh = 1.433,
			ja = 2.266
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
				arg_189_0:Play319381046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10066ui_story"]) and arg_189_1.var_.characterEffect10066ui_story == nil then
				arg_189_1.var_.characterEffect10066ui_story = arg_189_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10066ui_story"]) then
				if arg_189_1.var_.characterEffect10066ui_story and not isNil(arg_189_1.actors_["10066ui_story"]) then
					arg_189_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10066ui_story"]) and arg_189_1.var_.characterEffect10066ui_story then
				arg_189_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["1084ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_192_4 = 0
			local var_192_5 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(319381045)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 3 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 3)

				if (3 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 3)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381045", "story_v_out_319381.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381045", "story_v_out_319381.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_319381", "319381045", "story_v_out_319381.awb")

						arg_189_1:RecordAudio("319381045", var_192_11)
						arg_189_1:RecordAudio("319381045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319381", "319381045", "story_v_out_319381.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319381", "319381045", "story_v_out_319381.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319381046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319381046
		arg_193_1.duration_ = 3.2

		local var_193_0 = {
			zh = 2.3,
			ja = 3.2
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
				arg_193_0:Play319381047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1084ui_story = arg_193_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10066ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10066ui_story == nil then
				arg_193_1.var_.characterEffect10066ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10066ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_2)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10066ui_story then
				arg_193_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_196_3 = arg_193_1.actors_["1084ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_4 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 and not isNil(var_196_3) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_3) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_6 = 0
			local var_196_7 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(319381046)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 9 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 9)

				if (9 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 9)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381046", "story_v_out_319381.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381046", "story_v_out_319381.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_319381", "319381046", "story_v_out_319381.awb")

						arg_193_1:RecordAudio("319381046", var_196_13)
						arg_193_1:RecordAudio("319381046", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319381", "319381046", "story_v_out_319381.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319381", "319381046", "story_v_out_319381.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play319381047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319381047
		arg_197_1.duration_ = 5.23

		local var_197_0 = {
			zh = 2,
			ja = 5.233
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
				arg_197_0:Play319381048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10066ui_story = arg_197_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).z)
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles = arg_197_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_197_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10066ui_story"].transform.position).z)
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10066ui_story"].transform.localEulerAngles = arg_197_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["10066ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10066ui_story == nil then
				arg_197_1.var_.characterEffect10066ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect10066ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10066ui_story then
				arg_197_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_200_4 = arg_197_1.actors_["1084ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1084ui_story == nil then
				arg_197_1.var_.characterEffect1084ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_5 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 and not isNil(var_200_4) then
				if arg_197_1.var_.characterEffect1084ui_story and not isNil(var_200_4) then
					arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_5)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1084ui_story then
				arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_200_6 = 0
			local var_200_7 = 0.2

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(319381047)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 8 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 8)

				if (8 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 8)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381047", "story_v_out_319381.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381047", "story_v_out_319381.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_319381", "319381047", "story_v_out_319381.awb")

						arg_197_1:RecordAudio("319381047", var_200_13)
						arg_197_1:RecordAudio("319381047", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319381", "319381047", "story_v_out_319381.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319381", "319381047", "story_v_out_319381.awb")
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play319381048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319381048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319381049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10066ui_story"]) and arg_201_1.var_.characterEffect10066ui_story == nil then
				arg_201_1.var_.characterEffect10066ui_story = arg_201_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10066ui_story"]) then
				if arg_201_1.var_.characterEffect10066ui_story and not isNil(arg_201_1.actors_["10066ui_story"]) then
					arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10066ui_story"]) and arg_201_1.var_.characterEffect10066ui_story then
				arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 1.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(319381048).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 45 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 45)

				if (45 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 45)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319381049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319381049
		arg_205_1.duration_ = 14.23

		local var_205_0 = {
			zh = 11.366,
			ja = 14.233
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319381050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10066ui_story"]) and arg_205_1.var_.characterEffect10066ui_story == nil then
				arg_205_1.var_.characterEffect10066ui_story = arg_205_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10066ui_story"]) then
				if arg_205_1.var_.characterEffect10066ui_story and not isNil(arg_205_1.actors_["10066ui_story"]) then
					arg_205_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10066ui_story"]) and arg_205_1.var_.characterEffect10066ui_story then
				arg_205_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_208_2 = 0
			local var_208_3 = 1.325

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(319381049)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 53 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 53)

				if (53 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 53)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381049", "story_v_out_319381.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381049", "story_v_out_319381.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_319381", "319381049", "story_v_out_319381.awb")

						arg_205_1:RecordAudio("319381049", var_208_9)
						arg_205_1:RecordAudio("319381049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319381", "319381049", "story_v_out_319381.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319381", "319381049", "story_v_out_319381.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319381050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319381050
		arg_209_1.duration_ = 16.1

		local var_209_0 = {
			zh = 9.433,
			ja = 16.1
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
				arg_209_0:Play319381051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.075

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(319381050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 43 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 43)

				if (43 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 43)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381050", "story_v_out_319381.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_319381", "319381050", "story_v_out_319381.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_319381", "319381050", "story_v_out_319381.awb")

						arg_209_1:RecordAudio("319381050", var_212_6)
						arg_209_1:RecordAudio("319381050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319381", "319381050", "story_v_out_319381.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319381", "319381050", "story_v_out_319381.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319381051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319381051
		arg_213_1.duration_ = 15.33

		local var_213_0 = {
			zh = 7.9,
			ja = 15.333
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319381052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1084ui_story = arg_213_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).z)
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles = arg_213_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_213_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1084ui_story"].transform.position).z)
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1084ui_story"].transform.localEulerAngles = arg_213_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_216_1 = 0
			local var_216_2 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(319381051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 34 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 34)

				if (34 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 34)) > 0 and var_216_2 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381051", "story_v_out_319381.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_319381", "319381051", "story_v_out_319381.awb") / 1000

					if var_216_7 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_1
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_319381", "319381051", "story_v_out_319381.awb")

						arg_213_1:RecordAudio("319381051", var_216_8)
						arg_213_1:RecordAudio("319381051", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319381", "319381051", "story_v_out_319381.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319381", "319381051", "story_v_out_319381.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_9 and arg_213_1.time_ < var_216_1 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play319381052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319381052
		arg_217_1.duration_ = 2.57

		local var_217_0 = {
			zh = 2.066,
			ja = 2.566
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319381053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10066ui_story"]) and arg_217_1.var_.characterEffect10066ui_story == nil then
				arg_217_1.var_.characterEffect10066ui_story = arg_217_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10066ui_story"]) then
				if arg_217_1.var_.characterEffect10066ui_story and not isNil(arg_217_1.actors_["10066ui_story"]) then
					arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10066ui_story"]) and arg_217_1.var_.characterEffect10066ui_story then
				arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_220_1 = arg_217_1.actors_["1084ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1084ui_story == nil then
				arg_217_1.var_.characterEffect1084ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1084ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1084ui_story then
				arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4124")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_220_4 = 0
			local var_220_5 = 0.125

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(319381052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 5 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 5)

				if (5 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 5)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381052", "story_v_out_319381.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381052", "story_v_out_319381.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_319381", "319381052", "story_v_out_319381.awb")

						arg_217_1:RecordAudio("319381052", var_220_11)
						arg_217_1:RecordAudio("319381052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319381", "319381052", "story_v_out_319381.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319381", "319381052", "story_v_out_319381.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319381053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319381053
		arg_221_1.duration_ = 3.27

		local var_221_0 = {
			zh = 2.566,
			ja = 3.266
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
				arg_221_0:Play319381054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = arg_221_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["10066ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_224_4 = arg_221_1.actors_["1084ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect1084ui_story == nil then
				arg_221_1.var_.characterEffect1084ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_5 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 and not isNil(var_224_4) then
				if arg_221_1.var_.characterEffect1084ui_story and not isNil(var_224_4) then
					arg_221_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_5)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect1084ui_story then
				arg_221_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_224_6 = 0
			local var_224_7 = 0.15

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(319381053)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 6 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 6)

				if (6 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 6)) > 0 and var_224_7 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381053", "story_v_out_319381.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381053", "story_v_out_319381.awb") / 1000

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_out_319381", "319381053", "story_v_out_319381.awb")

						arg_221_1:RecordAudio("319381053", var_224_13)
						arg_221_1:RecordAudio("319381053", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319381", "319381053", "story_v_out_319381.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319381", "319381053", "story_v_out_319381.awb")
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play319381054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319381054
		arg_225_1.duration_ = 7.1

		local var_225_0 = {
			zh = 4.2,
			ja = 7.1
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319381055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = arg_225_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) then
				if arg_225_1.var_.characterEffect10066ui_story and not isNil(arg_225_1.actors_["10066ui_story"]) then
					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) and arg_225_1.var_.characterEffect10066ui_story then
				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_228_1 = arg_225_1.actors_["1084ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1084ui_story then
				arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_228_4 = 0
			local var_228_5 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(319381054)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 17 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 17)

				if (17 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 17)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381054", "story_v_out_319381.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381054", "story_v_out_319381.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_319381", "319381054", "story_v_out_319381.awb")

						arg_225_1:RecordAudio("319381054", var_228_11)
						arg_225_1:RecordAudio("319381054", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319381", "319381054", "story_v_out_319381.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319381", "319381054", "story_v_out_319381.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319381055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319381055
		arg_229_1.duration_ = 5.9

		local var_229_0 = {
			zh = 5.533,
			ja = 5.9
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
				arg_229_0:Play319381056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_232_0 = 0
			local var_232_1 = 0.55

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(319381055)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 22 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 22)

				if (22 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 22)) > 0 and var_232_1 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381055", "story_v_out_319381.awb") ~= 0 then
					local var_232_6 = manager.audio:GetVoiceLength("story_v_out_319381", "319381055", "story_v_out_319381.awb") / 1000

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end

					if var_232_2.prefab_name ~= "" and arg_229_1.actors_[var_232_2.prefab_name] ~= nil then
						local var_232_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_2.prefab_name].transform, "story_v_out_319381", "319381055", "story_v_out_319381.awb")

						arg_229_1:RecordAudio("319381055", var_232_7)
						arg_229_1:RecordAudio("319381055", var_232_7)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319381", "319381055", "story_v_out_319381.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319381", "319381055", "story_v_out_319381.awb")
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
	Play319381056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319381056
		arg_233_1.duration_ = 6.63

		local var_233_0 = {
			zh = 4.166,
			ja = 6.633
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319381057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10066ui_story = arg_233_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).z)
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles = arg_233_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_233_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10066ui_story"].transform.position).z)
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10066ui_story"].transform.localEulerAngles = arg_233_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["10066ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10066ui_story == nil then
				arg_233_1.var_.characterEffect10066ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect10066ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10066ui_story then
				arg_233_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["1084ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_5 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 and not isNil(var_236_4) then
				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_4) then
					arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_5)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1084ui_story then
				arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_236_6 = 0
			local var_236_7 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(319381056)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 18 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 18)

				if (18 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 18)) > 0 and var_236_7 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381056", "story_v_out_319381.awb") ~= 0 then
					local var_236_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381056", "story_v_out_319381.awb") / 1000

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end

					if var_236_8.prefab_name ~= "" and arg_233_1.actors_[var_236_8.prefab_name] ~= nil then
						local var_236_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_8.prefab_name].transform, "story_v_out_319381", "319381056", "story_v_out_319381.awb")

						arg_233_1:RecordAudio("319381056", var_236_13)
						arg_233_1:RecordAudio("319381056", var_236_13)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319381", "319381056", "story_v_out_319381.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319381", "319381056", "story_v_out_319381.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_14 and arg_233_1.time_ < var_236_6 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play319381057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319381057
		arg_237_1.duration_ = 11.5

		local var_237_0 = {
			zh = 5.966,
			ja = 11.5
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319381058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10066ui_story"]) and arg_237_1.var_.characterEffect10066ui_story == nil then
				arg_237_1.var_.characterEffect10066ui_story = arg_237_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10066ui_story"]) then
				if arg_237_1.var_.characterEffect10066ui_story and not isNil(arg_237_1.actors_["10066ui_story"]) then
					arg_237_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10066ui_story"]) and arg_237_1.var_.characterEffect10066ui_story then
				arg_237_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_240_1 = arg_237_1.actors_["1084ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_240_4 = 0
			local var_240_5 = 0.6

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(319381057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 24 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 24)

				if (24 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 24)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381057", "story_v_out_319381.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381057", "story_v_out_319381.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_319381", "319381057", "story_v_out_319381.awb")

						arg_237_1:RecordAudio("319381057", var_240_11)
						arg_237_1:RecordAudio("319381057", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319381", "319381057", "story_v_out_319381.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319381", "319381057", "story_v_out_319381.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319381058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319381058
		arg_241_1.duration_ = 12.3

		local var_241_0 = {
			zh = 6.7,
			ja = 12.3
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
				arg_241_0:Play319381059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) and arg_241_1.var_.characterEffect10066ui_story == nil then
				arg_241_1.var_.characterEffect10066ui_story = arg_241_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) then
				if arg_241_1.var_.characterEffect10066ui_story and not isNil(arg_241_1.actors_["10066ui_story"]) then
					arg_241_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) and arg_241_1.var_.characterEffect10066ui_story then
				arg_241_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["1084ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect1084ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1084ui_story then
				arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(319381058)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 32 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 32)

				if (32 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 32)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381058", "story_v_out_319381.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381058", "story_v_out_319381.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_319381", "319381058", "story_v_out_319381.awb")

						arg_241_1:RecordAudio("319381058", var_244_11)
						arg_241_1:RecordAudio("319381058", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319381", "319381058", "story_v_out_319381.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319381", "319381058", "story_v_out_319381.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319381059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319381059
		arg_245_1.duration_ = 13.17

		local var_245_0 = {
			zh = 8.5,
			ja = 13.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319381060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_248_0 = 0
			local var_248_1 = 1.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(319381059)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 45 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 45)

				if (45 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 45)) > 0 and var_248_1 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381059", "story_v_out_319381.awb") ~= 0 then
					local var_248_6 = manager.audio:GetVoiceLength("story_v_out_319381", "319381059", "story_v_out_319381.awb") / 1000

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end

					if var_248_2.prefab_name ~= "" and arg_245_1.actors_[var_248_2.prefab_name] ~= nil then
						local var_248_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_2.prefab_name].transform, "story_v_out_319381", "319381059", "story_v_out_319381.awb")

						arg_245_1:RecordAudio("319381059", var_248_7)
						arg_245_1:RecordAudio("319381059", var_248_7)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319381", "319381059", "story_v_out_319381.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319381", "319381059", "story_v_out_319381.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319381060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319381060
		arg_249_1.duration_ = 4.57

		local var_249_0 = {
			zh = 3.4,
			ja = 4.566
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319381061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10066ui_story"]) and arg_249_1.var_.characterEffect10066ui_story == nil then
				arg_249_1.var_.characterEffect10066ui_story = arg_249_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10066ui_story"]) then
				if arg_249_1.var_.characterEffect10066ui_story and not isNil(arg_249_1.actors_["10066ui_story"]) then
					arg_249_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10066ui_story"]) and arg_249_1.var_.characterEffect10066ui_story then
				arg_249_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_252_1 = arg_249_1.actors_["1084ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(319381060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)

				if (13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381060", "story_v_out_319381.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381060", "story_v_out_319381.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_319381", "319381060", "story_v_out_319381.awb")

						arg_249_1:RecordAudio("319381060", var_252_11)
						arg_249_1:RecordAudio("319381060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319381", "319381060", "story_v_out_319381.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319381", "319381060", "story_v_out_319381.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319381061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319381061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319381062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = arg_253_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) then
				if arg_253_1.var_.characterEffect1084ui_story and not isNil(arg_253_1.actors_["1084ui_story"]) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 1.275

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(319381061).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 51 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 51)

				if (51 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 51)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319381062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319381062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319381063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.95

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(319381062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 38 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 38)

				if (38 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 38)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319381063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319381063
		arg_261_1.duration_ = 9.57

		local var_261_0 = {
			zh = 6.73400000184774,
			ja = 9.56700000184775
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319381064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 3.7 < arg_261_1.time_ and arg_261_1.time_ <= 3.7 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = arg_261_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 3.7 <= arg_261_1.time_ and arg_261_1.time_ < 3.7 + var_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_261_1.time_ - 3.7) / var_264_0)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 3.7 + var_264_0 and arg_261_1.time_ < 3.7 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1084ui_story"]

			if 3.7 < arg_261_1.time_ and arg_261_1.time_ <= 3.7 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 3.7 <= arg_261_1.time_ and arg_261_1.time_ < 3.7 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 3.7 + var_264_2 and arg_261_1.time_ < 3.7 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1084ui_story then
				arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				local var_264_4 = arg_261_1.bgs_.I11l

				arg_261_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_5 = var_264_4:GetComponent("SpriteRenderer")

				if var_264_5 and var_264_5.sprite then
					local var_264_6 = 2 * (var_264_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_4.transform.localScale = Vector3.New(var_264_6 / var_264_5.sprite.bounds.size.y < var_264_6 * manager.ui.mainCameraCom_.aspect / var_264_5.sprite.bounds.size.x and var_264_6 * manager.ui.mainCameraCom_.aspect / var_264_5.sprite.bounds.size.x or var_264_6 / var_264_5.sprite.bounds.size.y, var_264_6 / var_264_5.sprite.bounds.size.y < var_264_6 * manager.ui.mainCameraCom_.aspect / var_264_5.sprite.bounds.size.x and var_264_6 * manager.ui.mainCameraCom_.aspect / var_264_5.sprite.bounds.size.x or var_264_6 / var_264_5.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "I11l" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_7 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_8 = 2

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_8 then
				local var_264_9 = Color.New(0, 0, 0)

				var_264_9.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_7) / var_264_8)
				arg_261_1.mask_.color = var_264_9
			end

			if arg_261_1.time_ >= var_264_7 + var_264_8 and arg_261_1.time_ < var_264_7 + var_264_8 + arg_264_0 then
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = 1
				arg_261_1.mask_.color = var_264_10
			end

			local var_264_11 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_12 = 2

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_12 then
				local var_264_13 = Color.New(0, 0, 0)

				var_264_13.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_11) / var_264_12)
				arg_261_1.mask_.color = var_264_13
			end

			if arg_261_1.time_ >= var_264_11 + var_264_12 and arg_261_1.time_ < var_264_11 + var_264_12 + arg_264_0 then
				local var_264_14 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_14.a = 0
				arg_261_1.mask_.color = var_264_14
			end

			local var_264_15 = arg_261_1.actors_["1084ui_story"].transform

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_15.localPosition
			end

			local var_264_16 = 0.001

			if 2 <= arg_261_1.time_ and arg_261_1.time_ < 2 + var_264_16 then
				var_264_15.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 2) / var_264_16)
				var_264_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_15.position).x, (manager.ui.mainCamera.transform.position - var_264_15.position).y, (manager.ui.mainCamera.transform.position - var_264_15.position).z)
				var_264_15.localEulerAngles.z = 0
				var_264_15.localEulerAngles.x = 0
				var_264_15.localEulerAngles = var_264_15.localEulerAngles
			end

			if arg_261_1.time_ >= 2 + var_264_16 and arg_261_1.time_ < 2 + var_264_16 + arg_264_0 then
				var_264_15.localPosition = Vector3.New(0, 100, 0)
				var_264_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_15.position).x, (manager.ui.mainCamera.transform.position - var_264_15.position).y, (manager.ui.mainCamera.transform.position - var_264_15.position).z)
				var_264_15.localEulerAngles.z = 0
				var_264_15.localEulerAngles.x = 0
				var_264_15.localEulerAngles = var_264_15.localEulerAngles
			end

			local var_264_17 = arg_261_1.actors_["10066ui_story"].transform

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				arg_261_1.var_.moveOldPos10066ui_story = var_264_17.localPosition
			end

			local var_264_18 = 0.001

			if 2 <= arg_261_1.time_ and arg_261_1.time_ < 2 + var_264_18 then
				var_264_17.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 2) / var_264_18)
				var_264_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_17.position).x, (manager.ui.mainCamera.transform.position - var_264_17.position).y, (manager.ui.mainCamera.transform.position - var_264_17.position).z)
				var_264_17.localEulerAngles.z = 0
				var_264_17.localEulerAngles.x = 0
				var_264_17.localEulerAngles = var_264_17.localEulerAngles
			end

			if arg_261_1.time_ >= 2 + var_264_18 and arg_261_1.time_ < 2 + var_264_18 + arg_264_0 then
				var_264_17.localPosition = Vector3.New(0, 100, 0)
				var_264_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_17.position).x, (manager.ui.mainCamera.transform.position - var_264_17.position).y, (manager.ui.mainCamera.transform.position - var_264_17.position).z)
				var_264_17.localEulerAngles.z = 0
				var_264_17.localEulerAngles.x = 0
				var_264_17.localEulerAngles = var_264_17.localEulerAngles
			end

			if 3.7 < arg_261_1.time_ and arg_261_1.time_ <= 3.7 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 3.7 < arg_261_1.time_ and arg_261_1.time_ <= 3.7 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_19 = 3.73400000184774
			local var_264_20 = 0.35

			if 3.73400000184774 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_21 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_21:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_22 = arg_261_1:GetWordFromCfg(319381063)
				local var_264_23 = arg_261_1:FormatText(var_264_22.content)

				arg_261_1.text_.text = var_264_23

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_25 = 14 <= 0 and var_264_20 or var_264_20 * (utf8.len(var_264_23) / 14)

				if (14 <= 0 and var_264_20 or var_264_20 * (utf8.len(var_264_23) / 14)) > 0 and var_264_20 < var_264_25 then
					arg_261_1.talkMaxDuration = var_264_25
					var_264_19 = var_264_19 + 0.3

					if var_264_25 + var_264_19 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_25 + var_264_19
					end
				end

				arg_261_1.text_.text = var_264_23
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381063", "story_v_out_319381.awb") ~= 0 then
					local var_264_26 = manager.audio:GetVoiceLength("story_v_out_319381", "319381063", "story_v_out_319381.awb") / 1000

					if var_264_26 + var_264_19 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_26 + var_264_19
					end

					if var_264_22.prefab_name ~= "" and arg_261_1.actors_[var_264_22.prefab_name] ~= nil then
						local var_264_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_22.prefab_name].transform, "story_v_out_319381", "319381063", "story_v_out_319381.awb")

						arg_261_1:RecordAudio("319381063", var_264_27)
						arg_261_1:RecordAudio("319381063", var_264_27)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319381", "319381063", "story_v_out_319381.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319381", "319381063", "story_v_out_319381.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_28 = var_264_19 + 0.3
			local var_264_29 = math.max(var_264_20, arg_261_1.talkMaxDuration)

			if var_264_19 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_28 + var_264_29 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_28) / var_264_29

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_28 + var_264_29 and arg_261_1.time_ < var_264_28 + var_264_29 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play319381064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 319381064
		arg_267_1.duration_ = 3.07

		local var_267_0 = {
			zh = 2.066,
			ja = 3.066
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play319381065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story == nil then
				arg_267_1.var_.characterEffect1084ui_story = arg_267_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) then
				if arg_267_1.var_.characterEffect1084ui_story and not isNil(arg_267_1.actors_["1084ui_story"]) then
					arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story then
				arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_270_1 = arg_267_1.actors_["10066ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10066ui_story == nil then
				arg_267_1.var_.characterEffect10066ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect10066ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10066ui_story then
				arg_267_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["1084ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1084ui_story = var_270_4.localPosition
			end

			local var_270_5 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 then
				var_270_4.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_267_1.time_ - 0) / var_270_5)
				var_270_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_4.position).x, (manager.ui.mainCamera.transform.position - var_270_4.position).y, (manager.ui.mainCamera.transform.position - var_270_4.position).z)
				var_270_4.localEulerAngles.z = 0
				var_270_4.localEulerAngles.x = 0
				var_270_4.localEulerAngles = var_270_4.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 then
				var_270_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_270_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_4.position).x, (manager.ui.mainCamera.transform.position - var_270_4.position).y, (manager.ui.mainCamera.transform.position - var_270_4.position).z)
				var_270_4.localEulerAngles.z = 0
				var_270_4.localEulerAngles.x = 0
				var_270_4.localEulerAngles = var_270_4.localEulerAngles
			end

			local var_270_6 = arg_267_1.actors_["10066ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10066ui_story = var_270_6.localPosition
			end

			local var_270_7 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				var_270_6.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_267_1.time_ - 0) / var_270_7)
				var_270_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_6.position).x, (manager.ui.mainCamera.transform.position - var_270_6.position).y, (manager.ui.mainCamera.transform.position - var_270_6.position).z)
				var_270_6.localEulerAngles.z = 0
				var_270_6.localEulerAngles.x = 0
				var_270_6.localEulerAngles = var_270_6.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				var_270_6.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_270_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_6.position).x, (manager.ui.mainCamera.transform.position - var_270_6.position).y, (manager.ui.mainCamera.transform.position - var_270_6.position).z)
				var_270_6.localEulerAngles.z = 0
				var_270_6.localEulerAngles.x = 0
				var_270_6.localEulerAngles = var_270_6.localEulerAngles
			end

			local var_270_8 = 0
			local var_270_9 = 0.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_10 = arg_267_1:GetWordFromCfg(319381064)
				local var_270_11 = arg_267_1:FormatText(var_270_10.content)

				arg_267_1.text_.text = var_270_11

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_13 = 7 <= 0 and var_270_9 or var_270_9 * (utf8.len(var_270_11) / 7)

				if (7 <= 0 and var_270_9 or var_270_9 * (utf8.len(var_270_11) / 7)) > 0 and var_270_9 < var_270_13 then
					arg_267_1.talkMaxDuration = var_270_13

					if var_270_13 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_11
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381064", "story_v_out_319381.awb") ~= 0 then
					local var_270_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381064", "story_v_out_319381.awb") / 1000

					if var_270_14 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_8
					end

					if var_270_10.prefab_name ~= "" and arg_267_1.actors_[var_270_10.prefab_name] ~= nil then
						local var_270_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_10.prefab_name].transform, "story_v_out_319381", "319381064", "story_v_out_319381.awb")

						arg_267_1:RecordAudio("319381064", var_270_15)
						arg_267_1:RecordAudio("319381064", var_270_15)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_319381", "319381064", "story_v_out_319381.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_319381", "319381064", "story_v_out_319381.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_16 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_16 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_16

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_16 and arg_267_1.time_ < var_270_8 + var_270_16 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play319381065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319381065
		arg_271_1.duration_ = 6.9

		local var_271_0 = {
			zh = 4.466,
			ja = 6.9
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play319381066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1084ui_story"]) and arg_271_1.var_.characterEffect1084ui_story == nil then
				arg_271_1.var_.characterEffect1084ui_story = arg_271_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1084ui_story"]) then
				if arg_271_1.var_.characterEffect1084ui_story and not isNil(arg_271_1.actors_["1084ui_story"]) then
					arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1084ui_story"]) and arg_271_1.var_.characterEffect1084ui_story then
				arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_274_2 = arg_271_1.actors_["10066ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_3 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_2) then
					arg_271_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_3)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect10066ui_story then
				arg_271_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_4 = 0
			local var_274_5 = 0.525

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(319381065)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 21 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 21)

				if (21 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 21)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381065", "story_v_out_319381.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381065", "story_v_out_319381.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_319381", "319381065", "story_v_out_319381.awb")

						arg_271_1:RecordAudio("319381065", var_274_11)
						arg_271_1:RecordAudio("319381065", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_319381", "319381065", "story_v_out_319381.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_319381", "319381065", "story_v_out_319381.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play319381066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319381066
		arg_275_1.duration_ = 11.03

		local var_275_0 = {
			zh = 6.266,
			ja = 11.033
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play319381067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10066ui_story = arg_275_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).z)
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles = arg_275_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_275_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10066ui_story"].transform.position).z)
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10066ui_story"].transform.localEulerAngles = arg_275_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["10066ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect10066ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10066ui_story then
				arg_275_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_4 = arg_275_1.actors_["1084ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_5 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 and not isNil(var_278_4) then
				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_4) then
					arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_5)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1084ui_story then
				arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_278_6 = 0
			local var_278_7 = 0.575

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(319381066)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 23 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 23)

				if (23 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 23)) > 0 and var_278_7 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381066", "story_v_out_319381.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381066", "story_v_out_319381.awb") / 1000

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_out_319381", "319381066", "story_v_out_319381.awb")

						arg_275_1:RecordAudio("319381066", var_278_13)
						arg_275_1:RecordAudio("319381066", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319381", "319381066", "story_v_out_319381.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319381", "319381066", "story_v_out_319381.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play319381067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319381067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319381068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1084ui_story = arg_279_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).z)
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles = arg_279_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1084ui_story"].transform.position).z)
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1084ui_story"].transform.localEulerAngles = arg_279_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10066ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10066ui_story = var_282_1.localPosition
			end

			local var_282_2 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 then
				var_282_1.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_2)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 then
				var_282_1.localPosition = Vector3.New(0, 100, 0)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			local var_282_3 = 0
			local var_282_4 = 0.675

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_5 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(319381067).content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 27 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 27)

				if (27 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 27)) > 0 and var_282_4 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_3 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_3
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_4, arg_279_1.talkMaxDuration)

			if var_282_3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_3 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_3) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_3 + var_282_8 and arg_279_1.time_ < var_282_3 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play319381068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319381068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319381069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.85

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(319381068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 34 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 34)

				if (34 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 34)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play319381069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319381069
		arg_287_1.duration_ = 6.8

		local var_287_0 = {
			zh = 5.4,
			ja = 6.8
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play319381070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) and arg_287_1.var_.characterEffect10066ui_story == nil then
				arg_287_1.var_.characterEffect10066ui_story = arg_287_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) then
				if arg_287_1.var_.characterEffect10066ui_story and not isNil(arg_287_1.actors_["10066ui_story"]) then
					arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) and arg_287_1.var_.characterEffect10066ui_story then
				arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_290_2 = arg_287_1.actors_["1084ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1084ui_story = var_290_2.localPosition
			end

			local var_290_3 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 0) / var_290_3)
				var_290_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_2.position).x, (manager.ui.mainCamera.transform.position - var_290_2.position).y, (manager.ui.mainCamera.transform.position - var_290_2.position).z)
				var_290_2.localEulerAngles.z = 0
				var_290_2.localEulerAngles.x = 0
				var_290_2.localEulerAngles = var_290_2.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(0, 100, 0)
				var_290_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_2.position).x, (manager.ui.mainCamera.transform.position - var_290_2.position).y, (manager.ui.mainCamera.transform.position - var_290_2.position).z)
				var_290_2.localEulerAngles.z = 0
				var_290_2.localEulerAngles.x = 0
				var_290_2.localEulerAngles = var_290_2.localEulerAngles
			end

			local var_290_4 = arg_287_1.actors_["10066ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10066ui_story = var_290_4.localPosition
			end

			local var_290_5 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 then
				var_290_4.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_287_1.time_ - 0) / var_290_5)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 then
				var_290_4.localPosition = Vector3.New(0, -0.99, -5.83)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_290_6 = 0
			local var_290_7 = 0.6

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_8 = arg_287_1:GetWordFromCfg(319381069)
				local var_290_9 = arg_287_1:FormatText(var_290_8.content)

				arg_287_1.text_.text = var_290_9

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 24 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 24)

				if (24 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 24)) > 0 and var_290_7 < var_290_11 then
					arg_287_1.talkMaxDuration = var_290_11

					if var_290_11 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_9
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381069", "story_v_out_319381.awb") ~= 0 then
					local var_290_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381069", "story_v_out_319381.awb") / 1000

					if var_290_12 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_6
					end

					if var_290_8.prefab_name ~= "" and arg_287_1.actors_[var_290_8.prefab_name] ~= nil then
						local var_290_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_8.prefab_name].transform, "story_v_out_319381", "319381069", "story_v_out_319381.awb")

						arg_287_1:RecordAudio("319381069", var_290_13)
						arg_287_1:RecordAudio("319381069", var_290_13)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319381", "319381069", "story_v_out_319381.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319381", "319381069", "story_v_out_319381.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play319381070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319381070
		arg_291_1.duration_ = 2

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319381071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = arg_291_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) then
				if arg_291_1.var_.characterEffect1084ui_story and not isNil(arg_291_1.actors_["1084ui_story"]) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_294_2 = arg_291_1.actors_["10066ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_3 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_2) then
					arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_3)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story then
				arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_294_4 = arg_291_1.actors_["1084ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1084ui_story = var_294_4.localPosition
			end

			local var_294_5 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 then
				var_294_4.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_291_1.time_ - 0) / var_294_5)
				var_294_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_4.position).x, (manager.ui.mainCamera.transform.position - var_294_4.position).y, (manager.ui.mainCamera.transform.position - var_294_4.position).z)
				var_294_4.localEulerAngles.z = 0
				var_294_4.localEulerAngles.x = 0
				var_294_4.localEulerAngles = var_294_4.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 then
				var_294_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_294_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_4.position).x, (manager.ui.mainCamera.transform.position - var_294_4.position).y, (manager.ui.mainCamera.transform.position - var_294_4.position).z)
				var_294_4.localEulerAngles.z = 0
				var_294_4.localEulerAngles.x = 0
				var_294_4.localEulerAngles = var_294_4.localEulerAngles
			end

			local var_294_6 = arg_291_1.actors_["10066ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10066ui_story = var_294_6.localPosition
			end

			local var_294_7 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				var_294_6.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_291_1.time_ - 0) / var_294_7)
				var_294_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_6.position).x, (manager.ui.mainCamera.transform.position - var_294_6.position).y, (manager.ui.mainCamera.transform.position - var_294_6.position).z)
				var_294_6.localEulerAngles.z = 0
				var_294_6.localEulerAngles.x = 0
				var_294_6.localEulerAngles = var_294_6.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				var_294_6.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_294_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_6.position).x, (manager.ui.mainCamera.transform.position - var_294_6.position).y, (manager.ui.mainCamera.transform.position - var_294_6.position).z)
				var_294_6.localEulerAngles.z = 0
				var_294_6.localEulerAngles.x = 0
				var_294_6.localEulerAngles = var_294_6.localEulerAngles
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_294_8 = 0
			local var_294_9 = 0.175

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(319381070)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 7 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 7)

				if (7 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 7)) > 0 and var_294_9 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381070", "story_v_out_319381.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381070", "story_v_out_319381.awb") / 1000

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end

					if var_294_10.prefab_name ~= "" and arg_291_1.actors_[var_294_10.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_10.prefab_name].transform, "story_v_out_319381", "319381070", "story_v_out_319381.awb")

						arg_291_1:RecordAudio("319381070", var_294_15)
						arg_291_1:RecordAudio("319381070", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319381", "319381070", "story_v_out_319381.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319381", "319381070", "story_v_out_319381.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play319381071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319381071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319381072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = arg_295_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) then
				if arg_295_1.var_.characterEffect1084ui_story and not isNil(arg_295_1.actors_["1084ui_story"]) then
					arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) and arg_295_1.var_.characterEffect1084ui_story then
				arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 1.125

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(319381071).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 45 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 45)

				if (45 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 45)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319381072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319381072
		arg_299_1.duration_ = 5.8

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319381073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.bgs_.STblack == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_302_0.name = "STblack"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.STblack = var_302_0
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.STblack

				arg_299_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "STblack" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_4 = arg_299_1.fswbg_.transform:Find("textbox/adapt/content") or arg_299_1.fswbg_.transform:Find("textbox/content")
				local var_302_5 = arg_299_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_302_6 = var_302_4:GetComponent("RectTransform")

				var_302_4:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_302_6.offsetMin = Vector2.New(0, 0)
				var_302_6.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.fswbg_:SetActive(true)
				arg_299_1.dialog_:SetActive(false)

				arg_299_1.fswtw_.percent = 0
				arg_299_1.fswt_.text = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(319381072).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.fswt_)

				arg_299_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_299_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_299_1.fswtw_:SetDirty()

				arg_299_1.typewritterCharCountI18N = 0

				SetActive(arg_299_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_299_1:ShowNextGo(false)
			end

			local var_302_7 = 0.8

			if 0.8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 then
				arg_299_1.var_.oldValueTypewriter = arg_299_1.fswtw_.percent

				SetActive(arg_299_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_299_1:ShowNextGo(false)
			end

			local var_302_8 = 19
			local var_302_9 = 1.26666666666667
			local var_302_10, var_302_11 = arg_299_1:GetPercentByPara(arg_299_1:FormatText(arg_299_1:GetWordFromCfg(319381072).content), 1)

			if var_302_7 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				local var_302_12 = var_302_8 <= 0 and var_302_9 or var_302_9 * ((var_302_11 - arg_299_1.typewritterCharCountI18N) / var_302_8)

				if (var_302_8 <= 0 and var_302_9 or var_302_9 * ((var_302_11 - arg_299_1.typewritterCharCountI18N) / var_302_8)) > 0 and var_302_9 < var_302_12 then
					arg_299_1.talkMaxDuration = var_302_12

					if var_302_12 + var_302_7 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_7
					end
				end
			end

			local var_302_13 = math.max(1.26666666666667, arg_299_1.talkMaxDuration)

			if var_302_7 <= arg_299_1.time_ and arg_299_1.time_ < var_302_7 + var_302_13 then
				arg_299_1.fswtw_.percent = Mathf.Lerp(arg_299_1.var_.oldValueTypewriter, var_302_10, (arg_299_1.time_ - var_302_7) / var_302_13)
				arg_299_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_299_1.fswtw_:SetDirty()
			end

			if arg_299_1.time_ >= var_302_7 + var_302_13 and arg_299_1.time_ < var_302_7 + var_302_13 + arg_302_0 then
				arg_299_1.fswtw_.percent = var_302_10

				arg_299_1.fswtw_:SetDirty()
				arg_299_1:ShowNextGo(true)

				arg_299_1.typewritterCharCountI18N = var_302_11
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.cswbg_:SetActive(true)

				local var_302_14 = arg_299_1.cswt_:GetComponent("RectTransform")

				arg_299_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_302_14.offsetMin = Vector2.New(410, 330)
				var_302_14.offsetMax = Vector2.New(-400, -175)
				arg_299_1.cswt_.text = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(419016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.cswt_)

				arg_299_1.cswt_.fontSize = 180
				arg_299_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_299_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_299_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_302_15 = arg_299_1.actors_["1084ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1084ui_story = var_302_15.localPosition
			end

			local var_302_16 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_16 then
				var_302_15.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_16)
				var_302_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_15.position).x, (manager.ui.mainCamera.transform.position - var_302_15.position).y, (manager.ui.mainCamera.transform.position - var_302_15.position).z)
				var_302_15.localEulerAngles.z = 0
				var_302_15.localEulerAngles.x = 0
				var_302_15.localEulerAngles = var_302_15.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_16 and arg_299_1.time_ < 0 + var_302_16 + arg_302_0 then
				var_302_15.localPosition = Vector3.New(0, 100, 0)
				var_302_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_15.position).x, (manager.ui.mainCamera.transform.position - var_302_15.position).y, (manager.ui.mainCamera.transform.position - var_302_15.position).z)
				var_302_15.localEulerAngles.z = 0
				var_302_15.localEulerAngles.x = 0
				var_302_15.localEulerAngles = var_302_15.localEulerAngles
			end

			local var_302_17 = arg_299_1.actors_["10066ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10066ui_story = var_302_17.localPosition
			end

			local var_302_18 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_18 then
				var_302_17.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_18)
				var_302_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_17.position).x, (manager.ui.mainCamera.transform.position - var_302_17.position).y, (manager.ui.mainCamera.transform.position - var_302_17.position).z)
				var_302_17.localEulerAngles.z = 0
				var_302_17.localEulerAngles.x = 0
				var_302_17.localEulerAngles = var_302_17.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_18 and arg_299_1.time_ < 0 + var_302_18 + arg_302_0 then
				var_302_17.localPosition = Vector3.New(0, 100, 0)
				var_302_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_17.position).x, (manager.ui.mainCamera.transform.position - var_302_17.position).y, (manager.ui.mainCamera.transform.position - var_302_17.position).z)
				var_302_17.localEulerAngles.z = 0
				var_302_17.localEulerAngles.x = 0
				var_302_17.localEulerAngles = var_302_17.localEulerAngles
			end

			local var_302_19 = 0.8
			local var_302_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381072", "story_v_out_319381.awb") / 1000

			if var_302_20 > 0 and 5 < var_302_20 and var_302_20 + var_302_19 > arg_299_1.duration_ then
				arg_299_1.duration_ = var_302_20 + var_302_19
			end

			if var_302_19 < arg_299_1.time_ and arg_299_1.time_ <= var_302_19 + arg_302_0 then
				arg_299_1:AudioAction("play", "voice", "story_v_out_319381", "319381072", "story_v_out_319381.awb")
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play319381073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319381073
		arg_303_1.duration_ = 1.93

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play319381074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.fswbg_:SetActive(true)
				arg_303_1.dialog_:SetActive(false)

				arg_303_1.fswtw_.percent = 0
				arg_303_1.fswt_.text = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(319381073).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.fswt_)

				arg_303_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_303_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_303_1.fswtw_:SetDirty()

				arg_303_1.typewritterCharCountI18N = 0

				SetActive(arg_303_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_303_1:ShowNextGo(false)
			end

			local var_306_0 = 0.133333333333333

			if 0.133333333333333 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.var_.oldValueTypewriter = arg_303_1.fswtw_.percent

				SetActive(arg_303_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_303_1:ShowNextGo(false)
			end

			local var_306_1 = 5
			local var_306_2 = 0.333333333333333
			local var_306_3, var_306_4 = arg_303_1:GetPercentByPara(arg_303_1:FormatText(arg_303_1:GetWordFromCfg(319381073).content), 1)

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				local var_306_5 = var_306_1 <= 0 and var_306_2 or var_306_2 * ((var_306_4 - arg_303_1.typewritterCharCountI18N) / var_306_1)

				if (var_306_1 <= 0 and var_306_2 or var_306_2 * ((var_306_4 - arg_303_1.typewritterCharCountI18N) / var_306_1)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_0
					end
				end
			end

			local var_306_6 = math.max(0.333333333333333, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_6 then
				arg_303_1.fswtw_.percent = Mathf.Lerp(arg_303_1.var_.oldValueTypewriter, var_306_3, (arg_303_1.time_ - var_306_0) / var_306_6)
				arg_303_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_303_1.fswtw_:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_6 and arg_303_1.time_ < var_306_0 + var_306_6 + arg_306_0 then
				arg_303_1.fswtw_.percent = var_306_3

				arg_303_1.fswtw_:SetDirty()
				arg_303_1:ShowNextGo(true)

				arg_303_1.typewritterCharCountI18N = var_306_4
			end

			local var_306_7 = 0.133333333333333
			local var_306_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381073", "story_v_out_319381.awb") / 1000

			if var_306_8 > 0 and 1.8 < var_306_8 and var_306_8 + var_306_7 > arg_303_1.duration_ then
				arg_303_1.duration_ = var_306_8 + var_306_7
			end

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				arg_303_1:AudioAction("play", "voice", "story_v_out_319381", "319381073", "story_v_out_319381.awb")
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319381074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319381074
		arg_307_1.duration_ = 7.47

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319381075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.fswbg_:SetActive(true)
				arg_307_1.dialog_:SetActive(false)

				arg_307_1.fswtw_.percent = 0
				arg_307_1.fswt_.text = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(319381074).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.fswt_)

				arg_307_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_307_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_307_1.fswtw_:SetDirty()

				arg_307_1.typewritterCharCountI18N = 0

				SetActive(arg_307_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_307_1:ShowNextGo(false)
			end

			local var_310_0 = 0.133333333333333

			if 0.133333333333333 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.var_.oldValueTypewriter = arg_307_1.fswtw_.percent

				SetActive(arg_307_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_307_1:ShowNextGo(false)
			end

			local var_310_1 = 29
			local var_310_2 = 1.93333333333333
			local var_310_3, var_310_4 = arg_307_1:GetPercentByPara(arg_307_1:FormatText(arg_307_1:GetWordFromCfg(319381074).content), 1)

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				local var_310_5 = var_310_1 <= 0 and var_310_2 or var_310_2 * ((var_310_4 - arg_307_1.typewritterCharCountI18N) / var_310_1)

				if (var_310_1 <= 0 and var_310_2 or var_310_2 * ((var_310_4 - arg_307_1.typewritterCharCountI18N) / var_310_1)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_0
					end
				end
			end

			local var_310_6 = math.max(1.93333333333333, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_6 then
				arg_307_1.fswtw_.percent = Mathf.Lerp(arg_307_1.var_.oldValueTypewriter, var_310_3, (arg_307_1.time_ - var_310_0) / var_310_6)
				arg_307_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_307_1.fswtw_:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_6 and arg_307_1.time_ < var_310_0 + var_310_6 + arg_310_0 then
				arg_307_1.fswtw_.percent = var_310_3

				arg_307_1.fswtw_:SetDirty()
				arg_307_1:ShowNextGo(true)

				arg_307_1.typewritterCharCountI18N = var_310_4
			end

			local var_310_7 = 0.133333333333333
			local var_310_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381074", "story_v_out_319381.awb") / 1000

			if var_310_8 > 0 and 7.333 < var_310_8 and var_310_8 + var_310_7 > arg_307_1.duration_ then
				arg_307_1.duration_ = var_310_8 + var_310_7
			end

			if var_310_7 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1:AudioAction("play", "voice", "story_v_out_319381", "319381074", "story_v_out_319381.awb")
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play319381075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319381075
		arg_311_1.duration_ = 2.23

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
			arg_311_1.auto_ = false
		end

		function arg_311_1.playNext_(arg_313_0)
			arg_311_1.onStoryFinished_()
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.fswbg_:SetActive(true)
				arg_311_1.dialog_:SetActive(false)

				arg_311_1.fswtw_.percent = 0
				arg_311_1.fswt_.text = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(319381075).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.fswt_)

				arg_311_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_311_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_311_1.fswtw_:SetDirty()

				arg_311_1.typewritterCharCountI18N = 0

				SetActive(arg_311_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_311_1:ShowNextGo(false)
			end

			local var_314_0 = 0.133333333333333

			if 0.133333333333333 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.var_.oldValueTypewriter = arg_311_1.fswtw_.percent

				SetActive(arg_311_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_311_1:ShowNextGo(false)
			end

			local var_314_1 = 13
			local var_314_2 = 0.866666666666667
			local var_314_3, var_314_4 = arg_311_1:GetPercentByPara(arg_311_1:FormatText(arg_311_1:GetWordFromCfg(319381075).content), 1)

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				local var_314_5 = var_314_1 <= 0 and var_314_2 or var_314_2 * ((var_314_4 - arg_311_1.typewritterCharCountI18N) / var_314_1)

				if (var_314_1 <= 0 and var_314_2 or var_314_2 * ((var_314_4 - arg_311_1.typewritterCharCountI18N) / var_314_1)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_0
					end
				end
			end

			local var_314_6 = math.max(0.866666666666667, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_6 then
				arg_311_1.fswtw_.percent = Mathf.Lerp(arg_311_1.var_.oldValueTypewriter, var_314_3, (arg_311_1.time_ - var_314_0) / var_314_6)
				arg_311_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_311_1.fswtw_:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_6 and arg_311_1.time_ < var_314_0 + var_314_6 + arg_314_0 then
				arg_311_1.fswtw_.percent = var_314_3

				arg_311_1.fswtw_:SetDirty()
				arg_311_1:ShowNextGo(true)

				arg_311_1.typewritterCharCountI18N = var_314_4
			end

			local var_314_7 = 0.133333333333333
			local var_314_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381075", "story_v_out_319381.awb") / 1000

			if var_314_8 > 0 and 2.1 < var_314_8 and var_314_8 + var_314_7 > arg_311_1.duration_ then
				arg_311_1.duration_ = var_314_8 + var_314_7
			end

			if var_314_7 < arg_311_1.time_ and arg_311_1.time_ <= var_314_7 + arg_314_0 then
				arg_311_1:AudioAction("play", "voice", "story_v_out_319381", "319381075", "story_v_out_319381.awb")
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/I11q",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319381.awb"
	}
}
