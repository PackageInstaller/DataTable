return {
	Play411231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411231001
		arg_1_1.duration_ = 10.1

		local var_1_0 = {
			zh = 8.1,
			ja = 10.1
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
				arg_1_0:Play411231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST13a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13a")
				var_4_0.name = "ST13a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST13a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST13a

				arg_1_1.bgs_.ST13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST13a" then
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

			local var_4_8 = "1095ui_story"

			if arg_1_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1095ui_story"].transform

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1095ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_1_1.time_ - 1.46666666666667) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_13 and arg_1_1.time_ < 1.46666666666667 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.98, -6.1)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1095ui_story"]

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1095ui_story == nil then
				arg_1_1.var_.characterEffect1095ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1095ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_15 and arg_1_1.time_ < 1.46666666666667 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1095ui_story then
				arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(411231001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 26 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 26)

				if (26 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 26)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231001", "story_v_out_411231.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_411231", "411231001", "story_v_out_411231.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_411231", "411231001", "story_v_out_411231.awb")

						arg_1_1:RecordAudio("411231001", var_4_31)
						arg_1_1:RecordAudio("411231001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411231", "411231001", "story_v_out_411231.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411231", "411231001", "story_v_out_411231.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play411231002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411231002
		arg_9_1.duration_ = 13

		local var_9_0 = {
			zh = 11.733,
			ja = 13
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
				arg_9_0:Play411231003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.4

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(411231002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 56 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 56)

				if (56 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 56)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231002", "story_v_out_411231.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231002", "story_v_out_411231.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_411231", "411231002", "story_v_out_411231.awb")

						arg_9_1:RecordAudio("411231002", var_12_6)
						arg_9_1:RecordAudio("411231002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411231", "411231002", "story_v_out_411231.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411231", "411231002", "story_v_out_411231.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play411231003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411231003
		arg_13_1.duration_ = 10.37

		local var_13_0 = {
			zh = 4.533,
			ja = 10.366
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
				arg_13_0:Play411231004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_0 = 0
			local var_16_1 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(411231003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 24 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 24)

				if (24 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 24)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231003", "story_v_out_411231.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_out_411231", "411231003", "story_v_out_411231.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_out_411231", "411231003", "story_v_out_411231.awb")

						arg_13_1:RecordAudio("411231003", var_16_7)
						arg_13_1:RecordAudio("411231003", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411231", "411231003", "story_v_out_411231.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411231", "411231003", "story_v_out_411231.awb")
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
	Play411231004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411231004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411231005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = arg_17_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).z)
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles = arg_17_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).z)
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles = arg_17_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.875

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(411231004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 35 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 35)

				if (35 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 35)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play411231005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411231005
		arg_21_1.duration_ = 9.7

		local var_21_0 = {
			zh = 9.7,
			ja = 6.9
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
				arg_21_0:Play411231006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1095ui_story = arg_21_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).z)
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles = arg_21_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_21_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1095ui_story"].transform.position).z)
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1095ui_story"].transform.localEulerAngles = arg_21_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1095ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.975

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(411231005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 39 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 39)

				if (39 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 39)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231005", "story_v_out_411231.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231005", "story_v_out_411231.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_411231", "411231005", "story_v_out_411231.awb")

						arg_21_1:RecordAudio("411231005", var_24_11)
						arg_21_1:RecordAudio("411231005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411231", "411231005", "story_v_out_411231.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411231", "411231005", "story_v_out_411231.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play411231006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411231006
		arg_25_1.duration_ = 10.87

		local var_25_0 = {
			zh = 10.866,
			ja = 8.2
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
				arg_25_0:Play411231007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_28_0 = 0
			local var_28_1 = 0.9

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(411231006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 36 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 36)

				if (36 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 36)) > 0 and var_28_1 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231006", "story_v_out_411231.awb") ~= 0 then
					local var_28_6 = manager.audio:GetVoiceLength("story_v_out_411231", "411231006", "story_v_out_411231.awb") / 1000

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_411231", "411231006", "story_v_out_411231.awb")

						arg_25_1:RecordAudio("411231006", var_28_7)
						arg_25_1:RecordAudio("411231006", var_28_7)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411231", "411231006", "story_v_out_411231.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411231", "411231006", "story_v_out_411231.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411231007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411231007
		arg_29_1.duration_ = 9

		local var_29_0 = {
			zh = 9,
			ja = 7.966
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
				arg_29_0:Play411231008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(411231007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 23 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 23)

				if (23 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 23)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231007", "story_v_out_411231.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231007", "story_v_out_411231.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_411231", "411231007", "story_v_out_411231.awb")

						arg_29_1:RecordAudio("411231007", var_32_6)
						arg_29_1:RecordAudio("411231007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411231", "411231007", "story_v_out_411231.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411231", "411231007", "story_v_out_411231.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play411231008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411231008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411231009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = arg_33_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).z)
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles = arg_33_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).z)
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles = arg_33_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1095ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 1.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(411231008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 42 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 42)

				if (42 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 42)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411231009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411231009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411231010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411231009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 52 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 52)

				if (52 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 52)) > 0 and var_40_0 < var_40_3 then
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
	Play411231010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411231010
		arg_41_1.duration_ = 7.37

		local var_41_0 = {
			zh = 3.066,
			ja = 7.366
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
				arg_41_0:Play411231011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = arg_41_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1095ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(411231010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 17 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 17)

				if (17 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 17)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231010", "story_v_out_411231.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231010", "story_v_out_411231.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_411231", "411231010", "story_v_out_411231.awb")

						arg_41_1:RecordAudio("411231010", var_44_11)
						arg_41_1:RecordAudio("411231010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411231", "411231010", "story_v_out_411231.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411231", "411231010", "story_v_out_411231.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411231011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411231011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play411231012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = arg_45_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) then
				if arg_45_1.var_.characterEffect1095ui_story and not isNil(arg_45_1.actors_["1095ui_story"]) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 1.425

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(411231011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 57 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 57)

				if (57 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 57)) > 0 and var_48_2 < var_48_5 then
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
	Play411231012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411231012
		arg_49_1.duration_ = 9.77

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411231013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.ML0603 == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0603")
				var_52_0.name = "ML0603"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.ML0603 = var_52_0
			end

			if 2.76666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 2.76666666666667 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.ML0603

				arg_49_1.bgs_.ML0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "ML0603" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_5 = 2.76666666666667

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_5 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_4) / var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_4 + var_52_5 and arg_49_1.time_ < var_52_4 + var_52_5 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 2.76666666666667

			if 2.76666666666667 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = Color.New(0, 0, 0)

				var_52_10.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_8) / var_52_9)
				arg_49_1.mask_.color = var_52_10
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_11 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_11.a = 0
				arg_49_1.mask_.color = var_52_11
			end

			local var_52_12 = arg_49_1.actors_["1095ui_story"].transform

			if 2.76666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 2.76666666666667 + arg_52_0 then
				arg_49_1.var_.moveOldPos1095ui_story = var_52_12.localPosition
			end

			local var_52_13 = 0.001

			if 2.76666666666667 <= arg_49_1.time_ and arg_49_1.time_ < 2.76666666666667 + var_52_13 then
				var_52_12.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 2.76666666666667) / var_52_13)
				var_52_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_12.position).x, (manager.ui.mainCamera.transform.position - var_52_12.position).y, (manager.ui.mainCamera.transform.position - var_52_12.position).z)
				var_52_12.localEulerAngles.z = 0
				var_52_12.localEulerAngles.x = 0
				var_52_12.localEulerAngles = var_52_12.localEulerAngles
			end

			if arg_49_1.time_ >= 2.76666666666667 + var_52_13 and arg_49_1.time_ < 2.76666666666667 + var_52_13 + arg_52_0 then
				var_52_12.localPosition = Vector3.New(0, 100, 0)
				var_52_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_12.position).x, (manager.ui.mainCamera.transform.position - var_52_12.position).y, (manager.ui.mainCamera.transform.position - var_52_12.position).z)
				var_52_12.localEulerAngles.z = 0
				var_52_12.localEulerAngles.x = 0
				var_52_12.localEulerAngles = var_52_12.localEulerAngles
			end

			local var_52_14 = arg_49_1.actors_["1095ui_story"]

			if 2.76666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 2.76666666666667 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_15 = 0.200000002980232

			if 2.76666666666667 <= arg_49_1.time_ and arg_49_1.time_ < 2.76666666666667 + var_52_15 and not isNil(var_52_14) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_14) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 2.76666666666667) / var_52_15)
				end
			end

			if arg_49_1.time_ >= 2.76666666666667 + var_52_15 and arg_49_1.time_ < 2.76666666666667 + var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_16 = 4.76666666666666
			local var_52_17 = 1.175

			if 4.76666666666666 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_18 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_18:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(411231012).content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 47 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_19) / 47)

				if (47 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_19) / 47)) > 0 and var_52_17 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21
					var_52_16 = var_52_16 + 0.3

					if var_52_21 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = var_52_16 + 0.3
			local var_52_23 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_22 + var_52_23 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_22) / var_52_23

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_22 + var_52_23 and arg_49_1.time_ < var_52_22 + var_52_23 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play411231013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411231013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play411231014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(411231013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 44 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 44)

				if (44 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 44)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play411231014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411231014
		arg_59_1.duration_ = 2

		local var_59_0 = {
			zh = 1.3,
			ja = 2
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411231015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(411231014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 7 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 7)

				if (7 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 7)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231014", "story_v_out_411231.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231014", "story_v_out_411231.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_411231", "411231014", "story_v_out_411231.awb")

						arg_59_1:RecordAudio("411231014", var_62_6)
						arg_59_1:RecordAudio("411231014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_411231", "411231014", "story_v_out_411231.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_411231", "411231014", "story_v_out_411231.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play411231015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411231015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play411231016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(411231015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)

				if (43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play411231016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411231016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play411231017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(411231016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 58 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 58)

				if (58 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 58)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play411231017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411231017
		arg_71_1.duration_ = 8.67

		local var_71_0 = {
			zh = 8.43266666666667,
			ja = 8.66666666666667
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play411231018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.bgs_.ML0601 == nil then
				local var_74_0 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0601")
				var_74_0.name = "ML0601"
				var_74_0.transform.parent = arg_71_1.stage_.transform
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_.ML0601 = var_74_0
			end

			if 1.33333333333333 < arg_71_1.time_ and arg_71_1.time_ <= 1.33333333333333 + arg_74_0 then
				local var_74_1 = arg_71_1.bgs_.ML0601

				arg_71_1.bgs_.ML0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_2 = var_74_1:GetComponent("SpriteRenderer")

				if var_74_2 and var_74_2.sprite then
					local var_74_3 = 2 * (var_74_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_1.transform.localScale = Vector3.New(var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ML0601" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_4 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_5 = 1.33333333333333

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_5 then
				local var_74_6 = Color.New(0, 0, 0)

				var_74_6.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_4) / var_74_5)
				arg_71_1.mask_.color = var_74_6
			end

			if arg_71_1.time_ >= var_74_4 + var_74_5 and arg_71_1.time_ < var_74_4 + var_74_5 + arg_74_0 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = 1
				arg_71_1.mask_.color = var_74_7
			end

			local var_74_8 = 1.33333333333333

			if 1.33333333333333 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_9 = 2

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 then
				local var_74_10 = Color.New(0, 0, 0)

				var_74_10.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_8) / var_74_9)
				arg_71_1.mask_.color = var_74_10
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 then
				local var_74_11 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_11.a = 0
				arg_71_1.mask_.color = var_74_11
			end

			local var_74_12 = 3.33333333333333

			if 3.33333333333333 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_12 + 2.93333333333333 and arg_71_1.time_ < var_74_12 + 2.93333333333333 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_13 = 6.26666666666667
			local var_74_14 = 0.35

			if 6.26666666666667 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_15 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_15:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_16 = arg_71_1:GetWordFromCfg(411231017)
				local var_74_17 = arg_71_1:FormatText(var_74_16.content)

				arg_71_1.text_.text = var_74_17

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_19 = 14 <= 0 and var_74_14 or var_74_14 * (utf8.len(var_74_17) / 14)

				if (14 <= 0 and var_74_14 or var_74_14 * (utf8.len(var_74_17) / 14)) > 0 and var_74_14 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19
					var_74_13 = var_74_13 + 0.3

					if var_74_19 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_13
					end
				end

				arg_71_1.text_.text = var_74_17
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231017", "story_v_out_411231.awb") ~= 0 then
					local var_74_20 = manager.audio:GetVoiceLength("story_v_out_411231", "411231017", "story_v_out_411231.awb") / 1000

					if var_74_20 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_13
					end

					if var_74_16.prefab_name ~= "" and arg_71_1.actors_[var_74_16.prefab_name] ~= nil then
						local var_74_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_16.prefab_name].transform, "story_v_out_411231", "411231017", "story_v_out_411231.awb")

						arg_71_1:RecordAudio("411231017", var_74_21)
						arg_71_1:RecordAudio("411231017", var_74_21)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_411231", "411231017", "story_v_out_411231.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_411231", "411231017", "story_v_out_411231.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = var_74_13 + 0.3
			local var_74_23 = math.max(var_74_14, arg_71_1.talkMaxDuration)

			if var_74_13 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_22 + var_74_23 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_22) / var_74_23

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_22 + var_74_23 and arg_71_1.time_ < var_74_22 + var_74_23 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play411231018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 411231018
		arg_77_1.duration_ = 9.07

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play411231019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 1.26666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.26666666666667 + arg_80_0 then
				local var_80_0 = arg_77_1.bgs_.ML0601

				arg_77_1.bgs_.ML0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_1 = var_80_0:GetComponent("SpriteRenderer")

				if var_80_1 and var_80_1.sprite then
					local var_80_2 = 2 * (var_80_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_0.transform.localScale = Vector3.New(var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ML0601" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_3 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_4 = 1.33333333333333

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_4 then
				local var_80_5 = Color.New(0, 0, 0)

				var_80_5.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_3) / var_80_4)
				arg_77_1.mask_.color = var_80_5
			end

			if arg_77_1.time_ >= var_80_3 + var_80_4 and arg_77_1.time_ < var_80_3 + var_80_4 + arg_80_0 then
				local var_80_6 = Color.New(0, 0, 0)

				var_80_6.a = 1
				arg_77_1.mask_.color = var_80_6
			end

			local var_80_7 = 1.33333333333333

			if 1.33333333333333 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_8 = 2

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 then
				local var_80_9 = Color.New(0, 0, 0)

				var_80_9.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_7) / var_80_8)
				arg_77_1.mask_.color = var_80_9
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 then
				local var_80_10 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_10.a = 0
				arg_77_1.mask_.color = var_80_10
			end

			local var_80_11 = arg_77_1.bgs_.ML0601.transform

			if 1.33333333333333 < arg_77_1.time_ and arg_77_1.time_ <= 1.33333333333333 + arg_80_0 then
				arg_77_1.var_.moveOldPosML0601 = var_80_11.localPosition
			end

			local var_80_12 = 0.001

			if 1.33333333333333 <= arg_77_1.time_ and arg_77_1.time_ < 1.33333333333333 + var_80_12 then
				var_80_11.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPosML0601, Vector3.New(0, 1, 10), (arg_77_1.time_ - 1.33333333333333) / var_80_12)
			end

			if arg_77_1.time_ >= 1.33333333333333 + var_80_12 and arg_77_1.time_ < 1.33333333333333 + var_80_12 + arg_80_0 then
				var_80_11.localPosition = Vector3.New(0, 1, 10)
			end

			local var_80_13 = arg_77_1.bgs_.ML0601.transform

			if 1.36666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.36666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPosML0601 = var_80_13.localPosition
			end

			local var_80_14 = 3.03333333333333

			if 1.36666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 1.36666666666667 + var_80_14 then
				var_80_13.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPosML0601, Vector3.New(0, 0.91, 8.79), (arg_77_1.time_ - 1.36666666666667) / var_80_14)
			end

			if arg_77_1.time_ >= 1.36666666666667 + var_80_14 and arg_77_1.time_ < 1.36666666666667 + var_80_14 + arg_80_0 then
				var_80_13.localPosition = Vector3.New(0, 0.91, 8.79)
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_15 = 4.06666666666667
			local var_80_16 = 1.05

			if 4.06666666666667 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_17 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_17:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(411231018).content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 42 <= 0 and var_80_16 or var_80_16 * (utf8.len(var_80_18) / 42)

				if (42 <= 0 and var_80_16 or var_80_16 * (utf8.len(var_80_18) / 42)) > 0 and var_80_16 < var_80_20 then
					arg_77_1.talkMaxDuration = var_80_20
					var_80_15 = var_80_15 + 0.3

					if var_80_20 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_20 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_21 = var_80_15 + 0.3
			local var_80_22 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_21) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333334,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.03333333333333,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play411231019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411231019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411231020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.125

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(411231019).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 45 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 45)

				if (45 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 45)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play411231020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411231020
		arg_87_1.duration_ = 6

		local var_87_0 = {
			zh = 4.5,
			ja = 6
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411231021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.6

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(411231020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 24 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 24)

				if (24 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 24)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231020", "story_v_out_411231.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231020", "story_v_out_411231.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_411231", "411231020", "story_v_out_411231.awb")

						arg_87_1:RecordAudio("411231020", var_90_6)
						arg_87_1:RecordAudio("411231020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_411231", "411231020", "story_v_out_411231.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_411231", "411231020", "story_v_out_411231.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play411231021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411231021
		arg_91_1.duration_ = 3.43

		local var_91_0 = {
			zh = 2.233,
			ja = 3.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play411231022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.35

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(411231021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 14 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 14)

				if (14 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 14)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231021", "story_v_out_411231.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231021", "story_v_out_411231.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_411231", "411231021", "story_v_out_411231.awb")

						arg_91_1:RecordAudio("411231021", var_94_6)
						arg_91_1:RecordAudio("411231021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_411231", "411231021", "story_v_out_411231.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_411231", "411231021", "story_v_out_411231.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411231022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411231022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411231023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(411231022).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 59 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 59)

				if (59 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 59)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play411231023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411231023
		arg_99_1.duration_ = 2.93

		local var_99_0 = {
			zh = 1.4,
			ja = 2.933
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411231024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(411231023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 6)

				if (6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 6)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231023", "story_v_out_411231.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231023", "story_v_out_411231.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_411231", "411231023", "story_v_out_411231.awb")

						arg_99_1:RecordAudio("411231023", var_102_6)
						arg_99_1:RecordAudio("411231023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411231", "411231023", "story_v_out_411231.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411231", "411231023", "story_v_out_411231.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play411231024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411231024
		arg_103_1.duration_ = 1.37

		local var_103_0 = {
			zh = 1.366,
			ja = 1.033
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411231025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_106_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_2 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_2

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_2
						arg_103_1.bgmTxt2_.text = var_106_2
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_106_3 = 0
			local var_106_4 = 0.05

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_5 = arg_103_1:GetWordFromCfg(411231024)
				local var_106_6 = arg_103_1:FormatText(var_106_5.content)

				arg_103_1.text_.text = var_106_6

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_8 = 2 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 2)

				if (2 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 2)) > 0 and var_106_4 < var_106_8 then
					arg_103_1.talkMaxDuration = var_106_8

					if var_106_8 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_6
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231024", "story_v_out_411231.awb") ~= 0 then
					local var_106_9 = manager.audio:GetVoiceLength("story_v_out_411231", "411231024", "story_v_out_411231.awb") / 1000

					if var_106_9 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_3
					end

					if var_106_5.prefab_name ~= "" and arg_103_1.actors_[var_106_5.prefab_name] ~= nil then
						local var_106_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_5.prefab_name].transform, "story_v_out_411231", "411231024", "story_v_out_411231.awb")

						arg_103_1:RecordAudio("411231024", var_106_10)
						arg_103_1:RecordAudio("411231024", var_106_10)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_411231", "411231024", "story_v_out_411231.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_411231", "411231024", "story_v_out_411231.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_11 and arg_103_1.time_ < var_106_3 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411231025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 411231025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play411231026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.025

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(411231025).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 41 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 41)

				if (41 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 41)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play411231026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 411231026
		arg_112_1.duration_ = 1.67

		local var_112_0 = {
			zh = 1.133,
			ja = 1.666
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
				arg_112_0:Play411231027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.125

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(411231026)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 5 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 5)

				if (5 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 5)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231026", "story_v_out_411231.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231026", "story_v_out_411231.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_411231", "411231026", "story_v_out_411231.awb")

						arg_112_1:RecordAudio("411231026", var_115_6)
						arg_112_1:RecordAudio("411231026", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_411231", "411231026", "story_v_out_411231.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_411231", "411231026", "story_v_out_411231.awb")
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
	Play411231027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 411231027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play411231028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.8

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(411231027).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 32 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 32)

				if (32 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 32)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play411231028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 411231028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play411231029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.925

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(411231028).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 37 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 37)

				if (37 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 37)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play411231029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411231029
		arg_124_1.duration_ = 1.8

		local var_124_0 = {
			zh = 1.666,
			ja = 1.8
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
				arg_124_0:Play411231030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.125

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(411231029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 5 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 5)

				if (5 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 5)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231029", "story_v_out_411231.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231029", "story_v_out_411231.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_411231", "411231029", "story_v_out_411231.awb")

						arg_124_1:RecordAudio("411231029", var_127_6)
						arg_124_1:RecordAudio("411231029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_411231", "411231029", "story_v_out_411231.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_411231", "411231029", "story_v_out_411231.awb")
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
	Play411231030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411231030
		arg_128_1.duration_ = 1.43

		local var_128_0 = {
			zh = 1.033,
			ja = 1.433
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
				arg_128_0:Play411231031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.125

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(411231030)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 5 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 5)

				if (5 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 5)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231030", "story_v_out_411231.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231030", "story_v_out_411231.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_411231", "411231030", "story_v_out_411231.awb")

						arg_128_1:RecordAudio("411231030", var_131_6)
						arg_128_1:RecordAudio("411231030", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411231", "411231030", "story_v_out_411231.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411231", "411231030", "story_v_out_411231.awb")
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
	Play411231031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 411231031
		arg_132_1.duration_ = 1.63

		local var_132_0 = {
			zh = 1.5,
			ja = 1.633
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
				arg_132_0:Play411231032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_135_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_132_1.bgmTxt_.text ~= var_135_2 and arg_132_1.bgmTxt_.text ~= "" then
						if arg_132_1.bgmTxt2_.text ~= "" then
							arg_132_1.bgmTxt_.text = arg_132_1.bgmTxt2_.text
						end

						arg_132_1.bgmTxt2_.text = var_135_2

						arg_132_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_132_1.bgmTxt_.text = var_135_2
						arg_132_1.bgmTxt2_.text = var_135_2
					end

					if arg_132_1.bgmTimer then
						arg_132_1.bgmTimer:Stop()

						arg_132_1.bgmTimer = nil
					end

					if arg_132_1.settingData.show_music_name == 1 then
						arg_132_1.musicController:SetSelectedState("show")
						arg_132_1.musicAnimator_:Play("open", 0, 0)

						if arg_132_1.settingData.music_time ~= 0 then
							arg_132_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_132_1.settingData.music_time), function()
								if arg_132_1 == nil or isNil(arg_132_1.bgmTxt_) then
									return
								end

								arg_132_1.musicController:SetSelectedState("hide")
								arg_132_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_132_1.time_ and arg_132_1.time_ <= 0.433333333333333 + arg_135_0 then
				arg_132_1:AudioAction("play", "music", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld.awb")

				local var_135_5 = manager.audio:GetAudioName("bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld")

				if "" ~= "" then
					if arg_132_1.bgmTxt_.text ~= var_135_5 and arg_132_1.bgmTxt_.text ~= "" then
						if arg_132_1.bgmTxt2_.text ~= "" then
							arg_132_1.bgmTxt_.text = arg_132_1.bgmTxt2_.text
						end

						arg_132_1.bgmTxt2_.text = var_135_5

						arg_132_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_132_1.bgmTxt_.text = var_135_5
						arg_132_1.bgmTxt2_.text = var_135_5
					end

					if arg_132_1.bgmTimer then
						arg_132_1.bgmTimer:Stop()

						arg_132_1.bgmTimer = nil
					end

					if arg_132_1.settingData.show_music_name == 1 then
						arg_132_1.musicController:SetSelectedState("show")
						arg_132_1.musicAnimator_:Play("open", 0, 0)

						if arg_132_1.settingData.music_time ~= 0 then
							arg_132_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_132_1.settingData.music_time), function()
								if arg_132_1 == nil or isNil(arg_132_1.bgmTxt_) then
									return
								end

								arg_132_1.musicController:SetSelectedState("hide")
								arg_132_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_135_6 = 0
			local var_135_7 = 0.1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_8 = arg_132_1:GetWordFromCfg(411231031)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 4 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 4)

				if (4 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 4)) > 0 and var_135_7 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231031", "story_v_out_411231.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_411231", "411231031", "story_v_out_411231.awb") / 1000

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_411231", "411231031", "story_v_out_411231.awb")

						arg_132_1:RecordAudio("411231031", var_135_13)
						arg_132_1:RecordAudio("411231031", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_411231", "411231031", "story_v_out_411231.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_411231", "411231031", "story_v_out_411231.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play411231032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 411231032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play411231033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 1.1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(411231032).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 44 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 44)

				if (44 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 44)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play411231033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 411231033
		arg_142_1.duration_ = 1.6

		local var_142_0 = {
			zh = 1.4,
			ja = 1.6
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
				arg_142_0:Play411231034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:GetWordFromCfg(411231033)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 5 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 5)

				if (5 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 5)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231033", "story_v_out_411231.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231033", "story_v_out_411231.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_411231", "411231033", "story_v_out_411231.awb")

						arg_142_1:RecordAudio("411231033", var_145_6)
						arg_142_1:RecordAudio("411231033", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_411231", "411231033", "story_v_out_411231.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_411231", "411231033", "story_v_out_411231.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play411231034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 411231034
		arg_146_1.duration_ = 9

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play411231035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.bgs_.STblack == nil then
				local var_149_0 = Object.Instantiate(arg_146_1.paintGo_)

				var_149_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_149_0.name = "STblack"
				var_149_0.transform.parent = arg_146_1.stage_.transform
				var_149_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.bgs_.STblack = var_149_0
			end

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				local var_149_1 = arg_146_1.bgs_.STblack

				arg_146_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_149_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_2 = var_149_1:GetComponent("SpriteRenderer")

				if var_149_2 and var_149_2.sprite then
					local var_149_3 = 2 * (var_149_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_149_1.transform.localScale = Vector3.New(var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "STblack" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_4 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_5 = 2

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_5 then
				local var_149_6 = Color.New(0, 0, 0)

				var_149_6.a = Mathf.Lerp(0, 1, (arg_146_1.time_ - var_149_4) / var_149_5)
				arg_146_1.mask_.color = var_149_6
			end

			if arg_146_1.time_ >= var_149_4 + var_149_5 and arg_146_1.time_ < var_149_4 + var_149_5 + arg_149_0 then
				local var_149_7 = Color.New(0, 0, 0)

				var_149_7.a = 1
				arg_146_1.mask_.color = var_149_7
			end

			local var_149_8 = 2

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_9 = 2

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_9 then
				local var_149_10 = Color.New(0, 0, 0)

				var_149_10.a = Mathf.Lerp(1, 0, (arg_146_1.time_ - var_149_8) / var_149_9)
				arg_146_1.mask_.color = var_149_10
			end

			if arg_146_1.time_ >= var_149_8 + var_149_9 and arg_146_1.time_ < var_149_8 + var_149_9 + arg_149_0 then
				local var_149_11 = Color.New(0, 0, 0)

				arg_146_1.mask_.enabled = false
				var_149_11.a = 0
				arg_146_1.mask_.color = var_149_11
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_12 = 4
			local var_149_13 = 1.075

			if 4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_14 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_14:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_15 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(411231034).content)

				arg_146_1.text_.text = var_149_15

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_17 = 43 <= 0 and var_149_13 or var_149_13 * (utf8.len(var_149_15) / 43)

				if (43 <= 0 and var_149_13 or var_149_13 * (utf8.len(var_149_15) / 43)) > 0 and var_149_13 < var_149_17 then
					arg_146_1.talkMaxDuration = var_149_17
					var_149_12 = var_149_12 + 0.3

					if var_149_17 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_17 + var_149_12
					end
				end

				arg_146_1.text_.text = var_149_15
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_18 = var_149_12 + 0.3
			local var_149_19 = math.max(var_149_13, arg_146_1.talkMaxDuration)

			if var_149_12 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_18 + var_149_19 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_18) / var_149_19

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_18 + var_149_19 and arg_146_1.time_ < var_149_18 + var_149_19 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play411231035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411231035
		arg_152_1.duration_ = 9

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play411231036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if arg_152_1.bgs_.I07a == nil then
				local var_155_0 = Object.Instantiate(arg_152_1.paintGo_)

				var_155_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_155_0.name = "I07a"
				var_155_0.transform.parent = arg_152_1.stage_.transform
				var_155_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.bgs_.I07a = var_155_0
			end

			if 2 < arg_152_1.time_ and arg_152_1.time_ <= 2 + arg_155_0 then
				local var_155_1 = arg_152_1.bgs_.I07a

				arg_152_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_155_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_155_2 = var_155_1:GetComponent("SpriteRenderer")

				if var_155_2 and var_155_2.sprite then
					local var_155_3 = 2 * (var_155_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_155_1.transform.localScale = Vector3.New(var_155_3 / var_155_2.sprite.bounds.size.y < var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x and var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x or var_155_3 / var_155_2.sprite.bounds.size.y, var_155_3 / var_155_2.sprite.bounds.size.y < var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x and var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x or var_155_3 / var_155_2.sprite.bounds.size.y, 0)
				end

				for iter_155_0, iter_155_1 in pairs(arg_152_1.bgs_) do
					if iter_155_0 ~= "I07a" then
						iter_155_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_155_4 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_5 = 2

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_5 then
				local var_155_6 = Color.New(0, 0, 0)

				var_155_6.a = Mathf.Lerp(0, 1, (arg_152_1.time_ - var_155_4) / var_155_5)
				arg_152_1.mask_.color = var_155_6
			end

			if arg_152_1.time_ >= var_155_4 + var_155_5 and arg_152_1.time_ < var_155_4 + var_155_5 + arg_155_0 then
				local var_155_7 = Color.New(0, 0, 0)

				var_155_7.a = 1
				arg_152_1.mask_.color = var_155_7
			end

			local var_155_8 = 2

			if 2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_9 = 2

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_9 then
				local var_155_10 = Color.New(0, 0, 0)

				var_155_10.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_8) / var_155_9)
				arg_152_1.mask_.color = var_155_10
			end

			if arg_152_1.time_ >= var_155_8 + var_155_9 and arg_152_1.time_ < var_155_8 + var_155_9 + arg_155_0 then
				local var_155_11 = Color.New(0, 0, 0)

				arg_152_1.mask_.enabled = false
				var_155_11.a = 0
				arg_152_1.mask_.color = var_155_11
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_12 = 4
			local var_155_13 = 0.825

			if 4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_14 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_14:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_15 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(411231035).content)

				arg_152_1.text_.text = var_155_15

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 33 <= 0 and var_155_13 or var_155_13 * (utf8.len(var_155_15) / 33)

				if (33 <= 0 and var_155_13 or var_155_13 * (utf8.len(var_155_15) / 33)) > 0 and var_155_13 < var_155_17 then
					arg_152_1.talkMaxDuration = var_155_17
					var_155_12 = var_155_12 + 0.3

					if var_155_17 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_17 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_15
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_18 = var_155_12 + 0.3
			local var_155_19 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 + 0.3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_18 + var_155_19 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_18) / var_155_19

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_18 + var_155_19 and arg_152_1.time_ < var_155_18 + var_155_19 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play411231036 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 411231036
		arg_158_1.duration_ = 4.23

		local var_158_0 = {
			zh = 3.866,
			ja = 4.233
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
				arg_158_0:Play411231037(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1095ui_story = arg_158_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).z)
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles = arg_158_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_158_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1095ui_story"].transform.position).z)
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1095ui_story"].transform.localEulerAngles = arg_158_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1095ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1095ui_story == nil then
				arg_158_1.var_.characterEffect1095ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1095ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1095ui_story then
				arg_158_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_161_4 = 0
			local var_161_5 = 0.325

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(411231036)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 13 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 13)

				if (13 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 13)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231036", "story_v_out_411231.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231036", "story_v_out_411231.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_411231", "411231036", "story_v_out_411231.awb")

						arg_158_1:RecordAudio("411231036", var_161_11)
						arg_158_1:RecordAudio("411231036", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_411231", "411231036", "story_v_out_411231.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_411231", "411231036", "story_v_out_411231.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play411231037 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 411231037
		arg_162_1.duration_ = 1.87

		local var_162_0 = {
			zh = 0.999999999999,
			ja = 1.866
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play411231038(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1095ui_story"]) and arg_162_1.var_.characterEffect1095ui_story == nil then
				arg_162_1.var_.characterEffect1095ui_story = arg_162_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1095ui_story"]) then
				if arg_162_1.var_.characterEffect1095ui_story and not isNil(arg_162_1.actors_["1095ui_story"]) then
					arg_162_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1095ui_story"]) and arg_162_1.var_.characterEffect1095ui_story then
				arg_162_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.05

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(411231037)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 2 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 2)

				if (2 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 2)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231037", "story_v_out_411231.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_411231", "411231037", "story_v_out_411231.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_411231", "411231037", "story_v_out_411231.awb")

						arg_162_1:RecordAudio("411231037", var_165_8)
						arg_162_1:RecordAudio("411231037", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_411231", "411231037", "story_v_out_411231.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_411231", "411231037", "story_v_out_411231.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play411231038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 411231038
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play411231039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.225

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

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(411231038).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 49 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 49)

				if (49 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 49)) > 0 and var_169_0 < var_169_3 then
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
	Play411231039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 411231039
		arg_170_1.duration_ = 3.73

		local var_170_0 = {
			zh = 3.733,
			ja = 3.5
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
				arg_170_0:Play411231040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1095ui_story = arg_170_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).z)
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles = arg_170_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_170_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1095ui_story"].transform.position).z)
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1095ui_story"].transform.localEulerAngles = arg_170_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1095ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1095ui_story == nil then
				arg_170_1.var_.characterEffect1095ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1095ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1095ui_story then
				arg_170_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_173_4 = 0
			local var_173_5 = 0.375

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(411231039)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 15 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 15)

				if (15 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 15)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231039", "story_v_out_411231.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231039", "story_v_out_411231.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_411231", "411231039", "story_v_out_411231.awb")

						arg_170_1:RecordAudio("411231039", var_173_11)
						arg_170_1:RecordAudio("411231039", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_411231", "411231039", "story_v_out_411231.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_411231", "411231039", "story_v_out_411231.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411231040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 411231040
		arg_174_1.duration_ = 2.4

		local var_174_0 = {
			zh = 0.999999999999,
			ja = 2.4
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
				arg_174_0:Play411231041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) and arg_174_1.var_.characterEffect1095ui_story == nil then
				arg_174_1.var_.characterEffect1095ui_story = arg_174_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) then
				if arg_174_1.var_.characterEffect1095ui_story and not isNil(arg_174_1.actors_["1095ui_story"]) then
					arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) and arg_174_1.var_.characterEffect1095ui_story then
				arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.05

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(411231040)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_6 = 2 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_4) / 2)

				if (2 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_4) / 2)) > 0 and var_177_2 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231040", "story_v_out_411231.awb") ~= 0 then
					local var_177_7 = manager.audio:GetVoiceLength("story_v_out_411231", "411231040", "story_v_out_411231.awb") / 1000

					if var_177_7 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_1
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_411231", "411231040", "story_v_out_411231.awb")

						arg_174_1:RecordAudio("411231040", var_177_8)
						arg_174_1:RecordAudio("411231040", var_177_8)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_411231", "411231040", "story_v_out_411231.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_411231", "411231040", "story_v_out_411231.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_9 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_9 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_9

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_9 and arg_174_1.time_ < var_177_1 + var_177_9 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play411231041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411231041
		arg_178_1.duration_ = 4.2

		local var_178_0 = {
			zh = 4.2,
			ja = 3.3
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
				arg_178_0:Play411231042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1095ui_story = arg_178_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).z)
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles = arg_178_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_178_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).z)
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles = arg_178_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1095ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1095ui_story == nil then
				arg_178_1.var_.characterEffect1095ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1095ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1095ui_story then
				arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_4 = 0
			local var_181_5 = 0.525

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(411231041)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 21 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 21)

				if (21 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 21)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231041", "story_v_out_411231.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231041", "story_v_out_411231.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_411231", "411231041", "story_v_out_411231.awb")

						arg_178_1:RecordAudio("411231041", var_181_11)
						arg_178_1:RecordAudio("411231041", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_411231", "411231041", "story_v_out_411231.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_411231", "411231041", "story_v_out_411231.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play411231042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411231042
		arg_182_1.duration_ = 2.13

		local var_182_0 = {
			zh = 0.999999999999,
			ja = 2.133
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
				arg_182_0:Play411231043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = arg_182_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) then
				if arg_182_1.var_.characterEffect1095ui_story and not isNil(arg_182_1.actors_["1095ui_story"]) then
					arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) and arg_182_1.var_.characterEffect1095ui_story then
				arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_185_1 = 0
			local var_185_2 = 0.05

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(411231042)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 2 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_4) / 2)

				if (2 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_4) / 2)) > 0 and var_185_2 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231042", "story_v_out_411231.awb") ~= 0 then
					local var_185_7 = manager.audio:GetVoiceLength("story_v_out_411231", "411231042", "story_v_out_411231.awb") / 1000

					if var_185_7 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_1
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_411231", "411231042", "story_v_out_411231.awb")

						arg_182_1:RecordAudio("411231042", var_185_8)
						arg_182_1:RecordAudio("411231042", var_185_8)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_411231", "411231042", "story_v_out_411231.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_411231", "411231042", "story_v_out_411231.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_9 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_9 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_9

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_9 and arg_182_1.time_ < var_185_1 + var_185_9 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play411231043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 411231043
		arg_186_1.duration_ = 4.37

		local var_186_0 = {
			zh = 4.366,
			ja = 2.966
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
				arg_186_0:Play411231044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = arg_186_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) then
				if arg_186_1.var_.characterEffect1095ui_story and not isNil(arg_186_1.actors_["1095ui_story"]) then
					arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) and arg_186_1.var_.characterEffect1095ui_story then
				arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_2 = 0
			local var_189_3 = 0.5

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(411231043)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 20 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 20)

				if (20 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 20)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231043", "story_v_out_411231.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_411231", "411231043", "story_v_out_411231.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_411231", "411231043", "story_v_out_411231.awb")

						arg_186_1:RecordAudio("411231043", var_189_9)
						arg_186_1:RecordAudio("411231043", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_411231", "411231043", "story_v_out_411231.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_411231", "411231043", "story_v_out_411231.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play411231044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 411231044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play411231045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story == nil then
				arg_190_1.var_.characterEffect1095ui_story = arg_190_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) then
				if arg_190_1.var_.characterEffect1095ui_story and not isNil(arg_190_1.actors_["1095ui_story"]) then
					arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story then
				arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_193_1 = 0
			local var_193_2 = 1.4

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(411231044).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 56 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 56)

				if (56 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 56)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play411231045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 411231045
		arg_194_1.duration_ = 15.77

		local var_194_0 = {
			zh = 11.933,
			ja = 15.766
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play411231046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) and arg_194_1.var_.characterEffect1095ui_story == nil then
				arg_194_1.var_.characterEffect1095ui_story = arg_194_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) then
				if arg_194_1.var_.characterEffect1095ui_story and not isNil(arg_194_1.actors_["1095ui_story"]) then
					arg_194_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) and arg_194_1.var_.characterEffect1095ui_story then
				arg_194_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_197_2 = 0
			local var_197_3 = 1.175

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(411231045)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 47 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 47)

				if (47 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 47)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231045", "story_v_out_411231.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_411231", "411231045", "story_v_out_411231.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_411231", "411231045", "story_v_out_411231.awb")

						arg_194_1:RecordAudio("411231045", var_197_9)
						arg_194_1:RecordAudio("411231045", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_411231", "411231045", "story_v_out_411231.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_411231", "411231045", "story_v_out_411231.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play411231046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411231046
		arg_198_1.duration_ = 11.17

		local var_198_0 = {
			zh = 9.466,
			ja = 11.166
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
				arg_198_0:Play411231047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.275

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(411231046)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 51 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 51)

				if (51 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 51)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231046", "story_v_out_411231.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231046", "story_v_out_411231.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_411231", "411231046", "story_v_out_411231.awb")

						arg_198_1:RecordAudio("411231046", var_201_6)
						arg_198_1:RecordAudio("411231046", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411231", "411231046", "story_v_out_411231.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411231", "411231046", "story_v_out_411231.awb")
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
	Play411231047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411231047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411231048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) and arg_202_1.var_.characterEffect1095ui_story == nil then
				arg_202_1.var_.characterEffect1095ui_story = arg_202_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) then
				if arg_202_1.var_.characterEffect1095ui_story and not isNil(arg_202_1.actors_["1095ui_story"]) then
					arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) and arg_202_1.var_.characterEffect1095ui_story then
				arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 1.375

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(411231047).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 55 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 55)

				if (55 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 55)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play411231048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411231048
		arg_206_1.duration_ = 11.03

		local var_206_0 = {
			zh = 11.033,
			ja = 10.233
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
				arg_206_0:Play411231049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) and arg_206_1.var_.characterEffect1095ui_story == nil then
				arg_206_1.var_.characterEffect1095ui_story = arg_206_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) then
				if arg_206_1.var_.characterEffect1095ui_story and not isNil(arg_206_1.actors_["1095ui_story"]) then
					arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) and arg_206_1.var_.characterEffect1095ui_story then
				arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_2 = 0
			local var_209_3 = 1.075

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(411231048)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 43 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 43)

				if (43 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 43)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231048", "story_v_out_411231.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_411231", "411231048", "story_v_out_411231.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_411231", "411231048", "story_v_out_411231.awb")

						arg_206_1:RecordAudio("411231048", var_209_9)
						arg_206_1:RecordAudio("411231048", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_411231", "411231048", "story_v_out_411231.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_411231", "411231048", "story_v_out_411231.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play411231049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411231049
		arg_210_1.duration_ = 3.3

		local var_210_0 = {
			zh = 3.3,
			ja = 3.133
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
				arg_210_0:Play411231050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.375

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(411231049)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 15 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 15)

				if (15 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 15)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231049", "story_v_out_411231.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231049", "story_v_out_411231.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_411231", "411231049", "story_v_out_411231.awb")

						arg_210_1:RecordAudio("411231049", var_213_6)
						arg_210_1:RecordAudio("411231049", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411231", "411231049", "story_v_out_411231.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411231", "411231049", "story_v_out_411231.awb")
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
	Play411231050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411231050
		arg_214_1.duration_ = 2.9

		local var_214_0 = {
			zh = 0.999999999999,
			ja = 2.9
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play411231051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) and arg_214_1.var_.characterEffect1095ui_story == nil then
				arg_214_1.var_.characterEffect1095ui_story = arg_214_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) then
				if arg_214_1.var_.characterEffect1095ui_story and not isNil(arg_214_1.actors_["1095ui_story"]) then
					arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) and arg_214_1.var_.characterEffect1095ui_story then
				arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.05

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(411231050)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 2 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 2)

				if (2 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 2)) > 0 and var_217_2 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231050", "story_v_out_411231.awb") ~= 0 then
					local var_217_7 = manager.audio:GetVoiceLength("story_v_out_411231", "411231050", "story_v_out_411231.awb") / 1000

					if var_217_7 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_1
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_411231", "411231050", "story_v_out_411231.awb")

						arg_214_1:RecordAudio("411231050", var_217_8)
						arg_214_1:RecordAudio("411231050", var_217_8)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_411231", "411231050", "story_v_out_411231.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_411231", "411231050", "story_v_out_411231.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_9 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_9

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_9 and arg_214_1.time_ < var_217_1 + var_217_9 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play411231051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411231051
		arg_218_1.duration_ = 4.83

		local var_218_0 = {
			zh = 3.2,
			ja = 4.833
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
				arg_218_0:Play411231052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = arg_218_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) then
				if arg_218_1.var_.characterEffect1095ui_story and not isNil(arg_218_1.actors_["1095ui_story"]) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_221_2 = 0
			local var_221_3 = 0.275

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:GetWordFromCfg(411231051)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 11 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 11)

				if (11 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 11)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231051", "story_v_out_411231.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_411231", "411231051", "story_v_out_411231.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_411231", "411231051", "story_v_out_411231.awb")

						arg_218_1:RecordAudio("411231051", var_221_9)
						arg_218_1:RecordAudio("411231051", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411231", "411231051", "story_v_out_411231.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411231", "411231051", "story_v_out_411231.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play411231052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411231052
		arg_222_1.duration_ = 11.5

		local var_222_0 = {
			zh = 11.5,
			ja = 6.6
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
				arg_222_0:Play411231053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.275

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(411231052)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 51 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 51)

				if (51 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 51)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231052", "story_v_out_411231.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231052", "story_v_out_411231.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_411231", "411231052", "story_v_out_411231.awb")

						arg_222_1:RecordAudio("411231052", var_225_6)
						arg_222_1:RecordAudio("411231052", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_411231", "411231052", "story_v_out_411231.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_411231", "411231052", "story_v_out_411231.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play411231053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411231053
		arg_226_1.duration_ = 12.6

		local var_226_0 = {
			zh = 12.6,
			ja = 10.4
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
				arg_226_0:Play411231054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.3

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(411231053)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 52 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 52)

				if (52 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 52)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231053", "story_v_out_411231.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231053", "story_v_out_411231.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_411231", "411231053", "story_v_out_411231.awb")

						arg_226_1:RecordAudio("411231053", var_229_6)
						arg_226_1:RecordAudio("411231053", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411231", "411231053", "story_v_out_411231.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411231", "411231053", "story_v_out_411231.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411231054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411231054
		arg_230_1.duration_ = 15

		local var_230_0 = {
			zh = 15,
			ja = 12.1
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411231055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.425

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(411231054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 57 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 57)

				if (57 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 57)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231054", "story_v_out_411231.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231054", "story_v_out_411231.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_411231", "411231054", "story_v_out_411231.awb")

						arg_230_1:RecordAudio("411231054", var_233_6)
						arg_230_1:RecordAudio("411231054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_411231", "411231054", "story_v_out_411231.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_411231", "411231054", "story_v_out_411231.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play411231055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411231055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play411231056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1095ui_story = arg_234_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).z)
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles = arg_234_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1095ui_story"].transform.position).z)
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1095ui_story"].transform.localEulerAngles = arg_234_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1095ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1095ui_story == nil then
				arg_234_1.var_.characterEffect1095ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1095ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_2)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1095ui_story then
				arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_237_3 = 0
			local var_237_4 = 0.475

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_5 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(411231055).content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 19 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 19)

				if (19 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 19)) > 0 and var_237_4 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_3 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_3
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_4, arg_234_1.talkMaxDuration)

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_3) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_3 + var_237_8 and arg_234_1.time_ < var_237_3 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411231056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411231056
		arg_238_1.duration_ = 13.13

		local var_238_0 = {
			zh = 12.066,
			ja = 13.133
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
				arg_238_0:Play411231057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = arg_238_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).z)
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles = arg_238_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_238_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).z)
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles = arg_238_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["1095ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_4 = 0
			local var_241_5 = 1.225

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_6 = arg_238_1:GetWordFromCfg(411231056)
				local var_241_7 = arg_238_1:FormatText(var_241_6.content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 49 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 49)

				if (49 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 49)) > 0 and var_241_5 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231056", "story_v_out_411231.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231056", "story_v_out_411231.awb") / 1000

					if var_241_10 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_4
					end

					if var_241_6.prefab_name ~= "" and arg_238_1.actors_[var_241_6.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_6.prefab_name].transform, "story_v_out_411231", "411231056", "story_v_out_411231.awb")

						arg_238_1:RecordAudio("411231056", var_241_11)
						arg_238_1:RecordAudio("411231056", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_411231", "411231056", "story_v_out_411231.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_411231", "411231056", "story_v_out_411231.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_12 and arg_238_1.time_ < var_241_4 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411231057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 411231057
		arg_242_1.duration_ = 16.87

		local var_242_0 = {
			zh = 16.866,
			ja = 6.066
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
				arg_242_0:Play411231058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.475

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(411231057)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 59 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 59)

				if (59 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 59)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231057", "story_v_out_411231.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231057", "story_v_out_411231.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_411231", "411231057", "story_v_out_411231.awb")

						arg_242_1:RecordAudio("411231057", var_245_6)
						arg_242_1:RecordAudio("411231057", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_411231", "411231057", "story_v_out_411231.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_411231", "411231057", "story_v_out_411231.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play411231058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 411231058
		arg_246_1.duration_ = 13.63

		local var_246_0 = {
			zh = 13.633,
			ja = 4.7
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
				arg_246_0:Play411231059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.975

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(411231058)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 39 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 39)

				if (39 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 39)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231058", "story_v_out_411231.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231058", "story_v_out_411231.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_411231", "411231058", "story_v_out_411231.awb")

						arg_246_1:RecordAudio("411231058", var_249_6)
						arg_246_1:RecordAudio("411231058", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_411231", "411231058", "story_v_out_411231.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_411231", "411231058", "story_v_out_411231.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play411231059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 411231059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play411231060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1095ui_story = arg_250_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).z)
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles = arg_250_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).z)
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles = arg_250_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1095ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1095ui_story == nil then
				arg_250_1.var_.characterEffect1095ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1095ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_2)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1095ui_story then
				arg_250_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_253_3 = 0
			local var_253_4 = 0.825

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_5 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(411231059).content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 33 <= 0 and var_253_4 or var_253_4 * (utf8.len(var_253_5) / 33)

				if (33 <= 0 and var_253_4 or var_253_4 * (utf8.len(var_253_5) / 33)) > 0 and var_253_4 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_3 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_3
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_4, arg_250_1.talkMaxDuration)

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_3) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_3 + var_253_8 and arg_250_1.time_ < var_253_3 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play411231060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 411231060
		arg_254_1.duration_ = 13.3

		local var_254_0 = {
			zh = 13.3,
			ja = 8.9
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
				arg_254_0:Play411231061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1095ui_story = arg_254_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).z)
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles = arg_254_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_254_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1095ui_story"].transform.position).z)
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1095ui_story"].transform.localEulerAngles = arg_254_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1095ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1095ui_story == nil then
				arg_254_1.var_.characterEffect1095ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1095ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1095ui_story then
				arg_254_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_257_4 = 0
			local var_257_5 = 1.35

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(411231060)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 54 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 54)

				if (54 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 54)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231060", "story_v_out_411231.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231060", "story_v_out_411231.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_411231", "411231060", "story_v_out_411231.awb")

						arg_254_1:RecordAudio("411231060", var_257_11)
						arg_254_1:RecordAudio("411231060", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_411231", "411231060", "story_v_out_411231.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_411231", "411231060", "story_v_out_411231.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play411231061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411231061
		arg_258_1.duration_ = 6.83

		local var_258_0 = {
			zh = 6.833,
			ja = 5.7
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play411231062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.65

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(411231061)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 26 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 26)

				if (26 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 26)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231061", "story_v_out_411231.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231061", "story_v_out_411231.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_411231", "411231061", "story_v_out_411231.awb")

						arg_258_1:RecordAudio("411231061", var_261_6)
						arg_258_1:RecordAudio("411231061", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_411231", "411231061", "story_v_out_411231.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_411231", "411231061", "story_v_out_411231.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play411231062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 411231062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play411231063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1095ui_story"]) and arg_262_1.var_.characterEffect1095ui_story == nil then
				arg_262_1.var_.characterEffect1095ui_story = arg_262_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1095ui_story"]) then
				if arg_262_1.var_.characterEffect1095ui_story and not isNil(arg_262_1.actors_["1095ui_story"]) then
					arg_262_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1095ui_story"]) and arg_262_1.var_.characterEffect1095ui_story then
				arg_262_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_265_1 = 0
			local var_265_2 = 0.95

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(411231062).content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 38 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 38)

				if (38 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 38)) > 0 and var_265_2 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_6 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_6 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_6

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_6 and arg_262_1.time_ < var_265_1 + var_265_6 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play411231063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 411231063
		arg_266_1.duration_ = 7.27

		local var_266_0 = {
			zh = 7.266,
			ja = 5.4
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
				arg_266_0:Play411231064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) and arg_266_1.var_.characterEffect1095ui_story == nil then
				arg_266_1.var_.characterEffect1095ui_story = arg_266_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) then
				if arg_266_1.var_.characterEffect1095ui_story and not isNil(arg_266_1.actors_["1095ui_story"]) then
					arg_266_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) and arg_266_1.var_.characterEffect1095ui_story then
				arg_266_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_269_2 = 0
			local var_269_3 = 1.05

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:GetWordFromCfg(411231063)
				local var_269_5 = arg_266_1:FormatText(var_269_4.content)

				arg_266_1.text_.text = var_269_5

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 42 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_5) / 42)

				if (42 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_5) / 42)) > 0 and var_269_3 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_5
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231063", "story_v_out_411231.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_411231", "411231063", "story_v_out_411231.awb") / 1000

					if var_269_8 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_2
					end

					if var_269_4.prefab_name ~= "" and arg_266_1.actors_[var_269_4.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_4.prefab_name].transform, "story_v_out_411231", "411231063", "story_v_out_411231.awb")

						arg_266_1:RecordAudio("411231063", var_269_9)
						arg_266_1:RecordAudio("411231063", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_411231", "411231063", "story_v_out_411231.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_411231", "411231063", "story_v_out_411231.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_10 and arg_266_1.time_ < var_269_2 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play411231064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411231064
		arg_270_1.duration_ = 14.7

		local var_270_0 = {
			zh = 14.7,
			ja = 5.8
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play411231065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 1.225

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:GetWordFromCfg(411231064)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 49 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 49)

				if (49 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 49)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231064", "story_v_out_411231.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231064", "story_v_out_411231.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_411231", "411231064", "story_v_out_411231.awb")

						arg_270_1:RecordAudio("411231064", var_273_6)
						arg_270_1:RecordAudio("411231064", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411231", "411231064", "story_v_out_411231.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411231", "411231064", "story_v_out_411231.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play411231065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411231065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play411231066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1095ui_story = arg_274_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).z)
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles = arg_274_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1095ui_story"].transform.position).z)
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1095ui_story"].transform.localEulerAngles = arg_274_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1095ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1095ui_story == nil then
				arg_274_1.var_.characterEffect1095ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect1095ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_2)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1095ui_story then
				arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_277_3 = 0
			local var_277_4 = 0.8

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_5 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(411231065).content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 32 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 32)

				if (32 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 32)) > 0 and var_277_4 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_3
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_4, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_3) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_8 and arg_274_1.time_ < var_277_3 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play411231066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 411231066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play411231067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(411231066).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 17 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 17)

				if (17 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 17)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play411231067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 411231067
		arg_282_1.duration_ = 5.97

		local var_282_0 = {
			zh = 5.966,
			ja = 3.766
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
				arg_282_0:Play411231068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1095ui_story = arg_282_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).z)
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles = arg_282_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_282_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).z)
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles = arg_282_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1095ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1095ui_story == nil then
				arg_282_1.var_.characterEffect1095ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect1095ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1095ui_story then
				arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_4 = 0
			local var_285_5 = 0.575

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_6 = arg_282_1:GetWordFromCfg(411231067)
				local var_285_7 = arg_282_1:FormatText(var_285_6.content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 23 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 23)

				if (23 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 23)) > 0 and var_285_5 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231067", "story_v_out_411231.awb") ~= 0 then
					local var_285_10 = manager.audio:GetVoiceLength("story_v_out_411231", "411231067", "story_v_out_411231.awb") / 1000

					if var_285_10 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_4
					end

					if var_285_6.prefab_name ~= "" and arg_282_1.actors_[var_285_6.prefab_name] ~= nil then
						local var_285_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_6.prefab_name].transform, "story_v_out_411231", "411231067", "story_v_out_411231.awb")

						arg_282_1:RecordAudio("411231067", var_285_11)
						arg_282_1:RecordAudio("411231067", var_285_11)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_411231", "411231067", "story_v_out_411231.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_411231", "411231067", "story_v_out_411231.awb")
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

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play411231068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 411231068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play411231069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1095ui_story = arg_286_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).z)
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles = arg_286_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).z)
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles = arg_286_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["1095ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1095ui_story == nil then
				arg_286_1.var_.characterEffect1095ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect1095ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_2)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1095ui_story then
				arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_289_3 = 0
			local var_289_4 = 0.825

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_5 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(411231068).content)

				arg_286_1.text_.text = var_289_5

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 33 <= 0 and var_289_4 or var_289_4 * (utf8.len(var_289_5) / 33)

				if (33 <= 0 and var_289_4 or var_289_4 * (utf8.len(var_289_5) / 33)) > 0 and var_289_4 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_3 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_3
					end
				end

				arg_286_1.text_.text = var_289_5
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_4, arg_286_1.talkMaxDuration)

			if var_289_3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_3 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_3) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_3 + var_289_8 and arg_286_1.time_ < var_289_3 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play411231069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411231069
		arg_290_1.duration_ = 1.7

		local var_290_0 = {
			zh = 1.7,
			ja = 1.633
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
				arg_290_0:Play411231070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.1

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:GetWordFromCfg(411231069)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 4 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 4)

				if (4 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 4)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411231", "411231069", "story_v_out_411231.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_411231", "411231069", "story_v_out_411231.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_411231", "411231069", "story_v_out_411231.awb")

						arg_290_1:RecordAudio("411231069", var_293_6)
						arg_290_1:RecordAudio("411231069", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411231", "411231069", "story_v_out_411231.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411231", "411231069", "story_v_out_411231.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play411231070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411231070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
			arg_294_1.auto_ = false
		end

		function arg_294_1.playNext_(arg_296_0)
			arg_294_1.onStoryFinished_()
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.5

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(411231070).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 20 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 20)

				if (20 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 20)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST13a",
		"TextureConfig/Background/ML0603",
		"TextureConfig/Background/ML0601",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a"
	},
	voices = {
		"story_v_out_411231.awb"
	}
}
