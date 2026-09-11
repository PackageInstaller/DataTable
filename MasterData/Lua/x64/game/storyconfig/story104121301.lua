return {
	Play412131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412131001
		arg_1_1.duration_ = 10.13

		local var_1_0 = {
			zh = 9.46600000298023,
			ja = 10.1330000029802
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
				arg_1_0:Play412131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST84a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST84a")
				var_4_0.name = "ST84a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST84a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST84a

				arg_1_1.bgs_.ST84a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST84a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1066ui_story"

			if arg_1_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1066ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.77, -6.1)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1066ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 2.00000000298023
			local var_4_25 = 1.025

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(412131001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 41 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 41)

				if (41 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 41)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131001", "story_v_out_412131.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_412131", "412131001", "story_v_out_412131.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_412131", "412131001", "story_v_out_412131.awb")

						arg_1_1:RecordAudio("412131001", var_4_32)
						arg_1_1:RecordAudio("412131001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412131", "412131001", "story_v_out_412131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412131", "412131001", "story_v_out_412131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play412131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412131002
		arg_9_1.duration_ = 13

		local var_9_0 = {
			zh = 9.4,
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
				arg_9_0:Play412131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(412131002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 47)

				if (47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 47)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131002", "story_v_out_412131.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131002", "story_v_out_412131.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_412131", "412131002", "story_v_out_412131.awb")

						arg_9_1:RecordAudio("412131002", var_12_6)
						arg_9_1:RecordAudio("412131002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412131", "412131002", "story_v_out_412131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412131", "412131002", "story_v_out_412131.awb")
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
	Play412131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412131003
		arg_13_1.duration_ = 5.87

		local var_13_0 = {
			zh = 2.7,
			ja = 5.866
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
				arg_13_0:Play412131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1097ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1097ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1097ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1097ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1097ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1097ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_8 = arg_13_1.actors_["1066ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1066ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, 100, 0)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["1066ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1066ui_story then
				arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(412131003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 10 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 10)

				if (10 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 10)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131003", "story_v_out_412131.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_412131", "412131003", "story_v_out_412131.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_412131", "412131003", "story_v_out_412131.awb")

						arg_13_1:RecordAudio("412131003", var_16_19)
						arg_13_1:RecordAudio("412131003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412131", "412131003", "story_v_out_412131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412131", "412131003", "story_v_out_412131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play412131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412131004
		arg_17_1.duration_ = 6.33

		local var_17_0 = {
			zh = 6.333,
			ja = 5.833
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
				arg_17_0:Play412131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1066ui_story = arg_17_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).z)
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles = arg_17_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_17_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1066ui_story"].transform.position).z)
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1066ui_story"].transform.localEulerAngles = arg_17_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1066ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1066ui_story == nil then
				arg_17_1.var_.characterEffect1066ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1066ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1066ui_story then
				arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_4 = arg_17_1.actors_["1097ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_4.localPosition
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_5)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, 100, 0)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			local var_20_6 = 0
			local var_20_7 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
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

				local var_20_8 = arg_17_1:GetWordFromCfg(412131004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 23 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 23)

				if (23 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 23)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131004", "story_v_out_412131.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_412131", "412131004", "story_v_out_412131.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_412131", "412131004", "story_v_out_412131.awb")

						arg_17_1:RecordAudio("412131004", var_20_13)
						arg_17_1:RecordAudio("412131004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412131", "412131004", "story_v_out_412131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412131", "412131004", "story_v_out_412131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412131005
		arg_21_1.duration_ = 7.1

		local var_21_0 = {
			zh = 7.10000000298023,
			ja = 7.00000000298023
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
				arg_21_0:Play412131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.bgs_.F01a == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_24_0.name = "F01a"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.F01a = var_24_0
			end

			if 2.00000000298023 < arg_21_1.time_ and arg_21_1.time_ <= 2.00000000298023 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.F01a

				arg_21_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "F01a" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 4.00000000298023

			if 4.00000000298023 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_4 + 0.3 and arg_21_1.time_ < var_24_4 + 0.3 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_5 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_6 = 2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 then
				local var_24_7 = Color.New(0, 0, 0)

				var_24_7.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_5) / var_24_6)
				arg_21_1.mask_.color = var_24_7
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 then
				local var_24_8 = Color.New(0, 0, 0)

				var_24_8.a = 1
				arg_21_1.mask_.color = var_24_8
			end

			local var_24_9 = 2.00000000298023

			if 2.00000000298023 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_10 = 2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 then
				local var_24_11 = Color.New(0, 0, 0)

				var_24_11.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_9) / var_24_10)
				arg_21_1.mask_.color = var_24_11
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 then
				local var_24_12 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_12.a = 0
				arg_21_1.mask_.color = var_24_12
			end

			local var_24_13 = "6046ui_story"

			if arg_21_1.actors_["6046ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6046ui_story"))) then
				local var_24_14 = Object.Instantiate(Asset.Load("Char/" .. "6046ui_story"), arg_21_1.stage_.transform)

				var_24_14.name = var_24_13
				var_24_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_13] = var_24_14

				local var_24_15 = var_24_14:GetComponentInChildren(typeof(CharacterEffect))

				var_24_15.enabled = true

				local var_24_16 = GameObjectTools.GetOrAddComponent(var_24_14, typeof(DynamicBoneHelper))

				if var_24_16 then
					var_24_16:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_15.transform, false)

				arg_21_1.var_[var_24_13 .. "Animator"] = var_24_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_13 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_13 .. "LipSync"] = var_24_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_17 = arg_21_1.actors_["6046ui_story"].transform

			if 3.8 < arg_21_1.time_ and arg_21_1.time_ <= 3.8 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046ui_story = var_24_17.localPosition
			end

			local var_24_18 = 0.001

			if 3.8 <= arg_21_1.time_ and arg_21_1.time_ < 3.8 + var_24_18 then
				var_24_17.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_21_1.time_ - 3.8) / var_24_18)
				var_24_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_17.position).x, (manager.ui.mainCamera.transform.position - var_24_17.position).y, (manager.ui.mainCamera.transform.position - var_24_17.position).z)
				var_24_17.localEulerAngles.z = 0
				var_24_17.localEulerAngles.x = 0
				var_24_17.localEulerAngles = var_24_17.localEulerAngles
			end

			if arg_21_1.time_ >= 3.8 + var_24_18 and arg_21_1.time_ < 3.8 + var_24_18 + arg_24_0 then
				var_24_17.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_24_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_17.position).x, (manager.ui.mainCamera.transform.position - var_24_17.position).y, (manager.ui.mainCamera.transform.position - var_24_17.position).z)
				var_24_17.localEulerAngles.z = 0
				var_24_17.localEulerAngles.x = 0
				var_24_17.localEulerAngles = var_24_17.localEulerAngles
			end

			local var_24_19 = arg_21_1.actors_["6046ui_story"]

			if 3.8 < arg_21_1.time_ and arg_21_1.time_ <= 3.8 + arg_24_0 and not isNil(var_24_19) and arg_21_1.var_.characterEffect6046ui_story == nil then
				arg_21_1.var_.characterEffect6046ui_story = var_24_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_20 = 0.200000002980232

			if 3.8 <= arg_21_1.time_ and arg_21_1.time_ < 3.8 + var_24_20 and not isNil(var_24_19) then
				if arg_21_1.var_.characterEffect6046ui_story and not isNil(var_24_19) then
					arg_21_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 3.8 + var_24_20 and arg_21_1.time_ < 3.8 + var_24_20 + arg_24_0 and not isNil(var_24_19) and arg_21_1.var_.characterEffect6046ui_story then
				arg_21_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			if 3.8 < arg_21_1.time_ and arg_21_1.time_ <= 3.8 + arg_24_0 then
				arg_21_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 3.8 < arg_21_1.time_ and arg_21_1.time_ <= 3.8 + arg_24_0 then
				arg_21_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_22 = arg_21_1.actors_["1066ui_story"].transform

			if 1.96599999815226 < arg_21_1.time_ and arg_21_1.time_ <= 1.96599999815226 + arg_24_0 then
				arg_21_1.var_.moveOldPos1066ui_story = var_24_22.localPosition
			end

			local var_24_23 = 0.001

			if 1.96599999815226 <= arg_21_1.time_ and arg_21_1.time_ < 1.96599999815226 + var_24_23 then
				var_24_22.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 1.96599999815226) / var_24_23)
				var_24_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_22.position).x, (manager.ui.mainCamera.transform.position - var_24_22.position).y, (manager.ui.mainCamera.transform.position - var_24_22.position).z)
				var_24_22.localEulerAngles.z = 0
				var_24_22.localEulerAngles.x = 0
				var_24_22.localEulerAngles = var_24_22.localEulerAngles
			end

			if arg_21_1.time_ >= 1.96599999815226 + var_24_23 and arg_21_1.time_ < 1.96599999815226 + var_24_23 + arg_24_0 then
				var_24_22.localPosition = Vector3.New(0, 100, 0)
				var_24_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_22.position).x, (manager.ui.mainCamera.transform.position - var_24_22.position).y, (manager.ui.mainCamera.transform.position - var_24_22.position).z)
				var_24_22.localEulerAngles.z = 0
				var_24_22.localEulerAngles.x = 0
				var_24_22.localEulerAngles = var_24_22.localEulerAngles
			end

			local var_24_24 = arg_21_1.actors_["1066ui_story"]

			if 1.96599999815226 < arg_21_1.time_ and arg_21_1.time_ <= 1.96599999815226 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1066ui_story == nil then
				arg_21_1.var_.characterEffect1066ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.034000001847744

			if 1.96599999815226 <= arg_21_1.time_ and arg_21_1.time_ < 1.96599999815226 + var_24_25 and not isNil(var_24_24) then
				if arg_21_1.var_.characterEffect1066ui_story and not isNil(var_24_24) then
					arg_21_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 1.96599999815226) / var_24_25)
				end
			end

			if arg_21_1.time_ >= 1.96599999815226 + var_24_25 and arg_21_1.time_ < 1.96599999815226 + var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1066ui_story then
				arg_21_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_26 = 4.00000000298023
			local var_24_27 = 0.325

			if 4.00000000298023 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_28 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_28:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_29 = arg_21_1:GetWordFromCfg(412131005)
				local var_24_30 = arg_21_1:FormatText(var_24_29.content)

				arg_21_1.text_.text = var_24_30

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_32 = 13 <= 0 and var_24_27 or var_24_27 * (utf8.len(var_24_30) / 13)

				if (13 <= 0 and var_24_27 or var_24_27 * (utf8.len(var_24_30) / 13)) > 0 and var_24_27 < var_24_32 then
					arg_21_1.talkMaxDuration = var_24_32
					var_24_26 = var_24_26 + 0.3

					if var_24_32 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_32 + var_24_26
					end
				end

				arg_21_1.text_.text = var_24_30
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131005", "story_v_out_412131.awb") ~= 0 then
					local var_24_33 = manager.audio:GetVoiceLength("story_v_out_412131", "412131005", "story_v_out_412131.awb") / 1000

					if var_24_33 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_33 + var_24_26
					end

					if var_24_29.prefab_name ~= "" and arg_21_1.actors_[var_24_29.prefab_name] ~= nil then
						local var_24_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_29.prefab_name].transform, "story_v_out_412131", "412131005", "story_v_out_412131.awb")

						arg_21_1:RecordAudio("412131005", var_24_34)
						arg_21_1:RecordAudio("412131005", var_24_34)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412131", "412131005", "story_v_out_412131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412131", "412131005", "story_v_out_412131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_35 = var_24_26 + 0.3
			local var_24_36 = math.max(var_24_27, arg_21_1.talkMaxDuration)

			if var_24_26 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_36 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_36

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_36 and arg_21_1.time_ < var_24_35 + var_24_36 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play412131006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 412131006
		arg_27_1.duration_ = 5.3

		local var_27_0 = {
			zh = 4.6,
			ja = 5.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play412131007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["6045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6045ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "6045ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "6045ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["6045ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["6045ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["6045ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["6045ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["6045ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos6045ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos6045ui_story, Vector3.New(0.7, -0.5, -6.3), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["6045ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect6045ui_story == nil then
				arg_27_1.var_.characterEffect6045ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect6045ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect6045ui_story then
				arg_27_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_8 = arg_27_1.actors_["6046ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect6046ui_story == nil then
				arg_27_1.var_.characterEffect6046ui_story = var_30_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_9 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_9 and not isNil(var_30_8) then
				if arg_27_1.var_.characterEffect6046ui_story and not isNil(var_30_8) then
					arg_27_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_27_1.var_.characterEffect6046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_9)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_9 and arg_27_1.time_ < 0 + var_30_9 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect6046ui_story then
				arg_27_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_27_1.var_.characterEffect6046ui_story.fillRatio = 0.5
			end

			local var_30_10 = 0
			local var_30_11 = 0.425

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_12 = arg_27_1:GetWordFromCfg(412131006)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 17 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 17)

				if (17 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 17)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131006", "story_v_out_412131.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_412131", "412131006", "story_v_out_412131.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_412131", "412131006", "story_v_out_412131.awb")

						arg_27_1:RecordAudio("412131006", var_30_17)
						arg_27_1:RecordAudio("412131006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_412131", "412131006", "story_v_out_412131.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_412131", "412131006", "story_v_out_412131.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play412131007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 412131007
		arg_31_1.duration_ = 8.17

		local var_31_0 = {
			zh = 8.166,
			ja = 3.6
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play412131008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos6046ui_story = arg_31_1.actors_["6046ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["6046ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos6046ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["6046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).z)
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles = arg_31_1.actors_["6046ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["6046ui_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_31_1.actors_["6046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6046ui_story"].transform.position).z)
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["6046ui_story"].transform.localEulerAngles = arg_31_1.actors_["6046ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["6046ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect6046ui_story == nil then
				arg_31_1.var_.characterEffect6046ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect6046ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect6046ui_story then
				arg_31_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_4 = arg_31_1.actors_["6045ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect6045ui_story == nil then
				arg_31_1.var_.characterEffect6045ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_5 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_4) then
				if arg_31_1.var_.characterEffect6045ui_story and not isNil(var_34_4) then
					arg_31_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_31_1.var_.characterEffect6045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_5)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect6045ui_story then
				arg_31_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_31_1.var_.characterEffect6045ui_story.fillRatio = 0.5
			end

			local var_34_6 = 0
			local var_34_7 = 0.675

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(412131007)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 27 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 27)

				if (27 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 27)) > 0 and var_34_7 < var_34_11 then
					arg_31_1.talkMaxDuration = var_34_11

					if var_34_11 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131007", "story_v_out_412131.awb") ~= 0 then
					local var_34_12 = manager.audio:GetVoiceLength("story_v_out_412131", "412131007", "story_v_out_412131.awb") / 1000

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end

					if var_34_8.prefab_name ~= "" and arg_31_1.actors_[var_34_8.prefab_name] ~= nil then
						local var_34_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_8.prefab_name].transform, "story_v_out_412131", "412131007", "story_v_out_412131.awb")

						arg_31_1:RecordAudio("412131007", var_34_13)
						arg_31_1:RecordAudio("412131007", var_34_13)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_412131", "412131007", "story_v_out_412131.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_412131", "412131007", "story_v_out_412131.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play412131008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412131008
		arg_35_1.duration_ = 8.07

		local var_35_0 = {
			zh = 8.066,
			ja = 6.9
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412131009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.85

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(412131008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 34 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 34)

				if (34 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 34)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131008", "story_v_out_412131.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131008", "story_v_out_412131.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_412131", "412131008", "story_v_out_412131.awb")

						arg_35_1:RecordAudio("412131008", var_38_6)
						arg_35_1:RecordAudio("412131008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_412131", "412131008", "story_v_out_412131.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_412131", "412131008", "story_v_out_412131.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play412131009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412131009
		arg_39_1.duration_ = 2.47

		local var_39_0 = {
			zh = 2.466,
			ja = 2.133
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play412131010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["6046ui_story"]) and arg_39_1.var_.characterEffect6046ui_story == nil then
				arg_39_1.var_.characterEffect6046ui_story = arg_39_1.actors_["6046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["6046ui_story"]) then
				if arg_39_1.var_.characterEffect6046ui_story and not isNil(arg_39_1.actors_["6046ui_story"]) then
					arg_39_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_39_1.var_.characterEffect6046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["6046ui_story"]) and arg_39_1.var_.characterEffect6046ui_story then
				arg_39_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_39_1.var_.characterEffect6046ui_story.fillRatio = 0.5
			end

			local var_42_1 = arg_39_1.actors_["6045ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect6045ui_story == nil then
				arg_39_1.var_.characterEffect6045ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect6045ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect6045ui_story then
				arg_39_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			local var_42_4 = 0
			local var_42_5 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(412131009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 8 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 8)

				if (8 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 8)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131009", "story_v_out_412131.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131009", "story_v_out_412131.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_412131", "412131009", "story_v_out_412131.awb")

						arg_39_1:RecordAudio("412131009", var_42_11)
						arg_39_1:RecordAudio("412131009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_412131", "412131009", "story_v_out_412131.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_412131", "412131009", "story_v_out_412131.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play412131010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412131010
		arg_43_1.duration_ = 14.37

		local var_43_0 = {
			zh = 14.366,
			ja = 12.966
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play412131011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["6046ui_story"]) and arg_43_1.var_.characterEffect6046ui_story == nil then
				arg_43_1.var_.characterEffect6046ui_story = arg_43_1.actors_["6046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["6046ui_story"]) then
				if arg_43_1.var_.characterEffect6046ui_story and not isNil(arg_43_1.actors_["6046ui_story"]) then
					arg_43_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["6046ui_story"]) and arg_43_1.var_.characterEffect6046ui_story then
				arg_43_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["6045ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect6045ui_story == nil then
				arg_43_1.var_.characterEffect6045ui_story = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect6045ui_story and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_43_1.var_.characterEffect6045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect6045ui_story then
				arg_43_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_43_1.var_.characterEffect6045ui_story.fillRatio = 0.5
			end

			local var_46_4 = 0
			local var_46_5 = 1.275

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(412131010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 51 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 51)

				if (51 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 51)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131010", "story_v_out_412131.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131010", "story_v_out_412131.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_412131", "412131010", "story_v_out_412131.awb")

						arg_43_1:RecordAudio("412131010", var_46_11)
						arg_43_1:RecordAudio("412131010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412131", "412131010", "story_v_out_412131.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412131", "412131010", "story_v_out_412131.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play412131011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 412131011
		arg_47_1.duration_ = 12.47

		local var_47_0 = {
			zh = 12.466,
			ja = 10.666
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
				arg_47_0:Play412131012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["6045ui_story"]) and arg_47_1.var_.characterEffect6045ui_story == nil then
				arg_47_1.var_.characterEffect6045ui_story = arg_47_1.actors_["6045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["6045ui_story"]) then
				if arg_47_1.var_.characterEffect6045ui_story and not isNil(arg_47_1.actors_["6045ui_story"]) then
					arg_47_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["6045ui_story"]) and arg_47_1.var_.characterEffect6045ui_story then
				arg_47_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_2 = arg_47_1.actors_["6046ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect6046ui_story == nil then
				arg_47_1.var_.characterEffect6046ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect6046ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_47_1.var_.characterEffect6046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect6046ui_story then
				arg_47_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_47_1.var_.characterEffect6046ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 1.05

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(412131011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 42 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 42)

				if (42 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 42)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131011", "story_v_out_412131.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131011", "story_v_out_412131.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_412131", "412131011", "story_v_out_412131.awb")

						arg_47_1:RecordAudio("412131011", var_50_11)
						arg_47_1:RecordAudio("412131011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_412131", "412131011", "story_v_out_412131.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_412131", "412131011", "story_v_out_412131.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play412131012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 412131012
		arg_51_1.duration_ = 10.13

		local var_51_0 = {
			zh = 6.6,
			ja = 10.133
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play412131013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["6046ui_story"]) and arg_51_1.var_.characterEffect6046ui_story == nil then
				arg_51_1.var_.characterEffect6046ui_story = arg_51_1.actors_["6046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["6046ui_story"]) then
				if arg_51_1.var_.characterEffect6046ui_story and not isNil(arg_51_1.actors_["6046ui_story"]) then
					arg_51_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["6046ui_story"]) and arg_51_1.var_.characterEffect6046ui_story then
				arg_51_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_2 = arg_51_1.actors_["6045ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect6045ui_story == nil then
				arg_51_1.var_.characterEffect6045ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect6045ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_51_1.var_.characterEffect6045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect6045ui_story then
				arg_51_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_51_1.var_.characterEffect6045ui_story.fillRatio = 0.5
			end

			local var_54_4 = 0
			local var_54_5 = 0.6

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(412131012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 24 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 24)

				if (24 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 24)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131012", "story_v_out_412131.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131012", "story_v_out_412131.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_412131", "412131012", "story_v_out_412131.awb")

						arg_51_1:RecordAudio("412131012", var_54_11)
						arg_51_1:RecordAudio("412131012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_412131", "412131012", "story_v_out_412131.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_412131", "412131012", "story_v_out_412131.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play412131013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 412131013
		arg_55_1.duration_ = 2.97

		local var_55_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_55_0:Play412131014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["6045ui_story"]) and arg_55_1.var_.characterEffect6045ui_story == nil then
				arg_55_1.var_.characterEffect6045ui_story = arg_55_1.actors_["6045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["6045ui_story"]) then
				if arg_55_1.var_.characterEffect6045ui_story and not isNil(arg_55_1.actors_["6045ui_story"]) then
					arg_55_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["6045ui_story"]) and arg_55_1.var_.characterEffect6045ui_story then
				arg_55_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_2 = arg_55_1.actors_["6046ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect6046ui_story == nil then
				arg_55_1.var_.characterEffect6046ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect6046ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_55_1.var_.characterEffect6046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect6046ui_story then
				arg_55_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_55_1.var_.characterEffect6046ui_story.fillRatio = 0.5
			end

			local var_58_4 = 0
			local var_58_5 = 0.075

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(412131013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 3 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 3)

				if (3 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 3)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131013", "story_v_out_412131.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131013", "story_v_out_412131.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_412131", "412131013", "story_v_out_412131.awb")

						arg_55_1:RecordAudio("412131013", var_58_11)
						arg_55_1:RecordAudio("412131013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_412131", "412131013", "story_v_out_412131.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_412131", "412131013", "story_v_out_412131.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play412131014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 412131014
		arg_59_1.duration_ = 8.43

		local var_59_0 = {
			zh = 7.6,
			ja = 8.433
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
				arg_59_0:Play412131015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if arg_59_1.bgs_.F03_2 == nil then
				local var_62_0 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03_2")
				var_62_0.name = "F03_2"
				var_62_0.transform.parent = arg_59_1.stage_.transform
				var_62_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_.F03_2 = var_62_0
			end

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				local var_62_1 = arg_59_1.bgs_.F03_2

				arg_59_1.bgs_.F03_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_2 = var_62_1:GetComponent("SpriteRenderer")

				if var_62_2 and var_62_2.sprite then
					local var_62_3 = 2 * (var_62_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_1.transform.localScale = Vector3.New(var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "F03_2" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_4 = 4

			if 4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			if arg_59_1.time_ >= var_62_4 + 0.3 and arg_59_1.time_ < var_62_4 + 0.3 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_5 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_6 = 2

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_6 then
				local var_62_7 = Color.New(0, 0, 0)

				var_62_7.a = Mathf.Lerp(0, 1, (arg_59_1.time_ - var_62_5) / var_62_6)
				arg_59_1.mask_.color = var_62_7
			end

			if arg_59_1.time_ >= var_62_5 + var_62_6 and arg_59_1.time_ < var_62_5 + var_62_6 + arg_62_0 then
				local var_62_8 = Color.New(0, 0, 0)

				var_62_8.a = 1
				arg_59_1.mask_.color = var_62_8
			end

			local var_62_9 = 2

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_10 = 2

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_10 then
				local var_62_11 = Color.New(0, 0, 0)

				var_62_11.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_9) / var_62_10)
				arg_59_1.mask_.color = var_62_11
			end

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 then
				local var_62_12 = Color.New(0, 0, 0)

				arg_59_1.mask_.enabled = false
				var_62_12.a = 0
				arg_59_1.mask_.color = var_62_12
			end

			local var_62_13 = arg_59_1.actors_["6045ui_story"].transform

			if 1.96599999815226 < arg_59_1.time_ and arg_59_1.time_ <= 1.96599999815226 + arg_62_0 then
				arg_59_1.var_.moveOldPos6045ui_story = var_62_13.localPosition
			end

			local var_62_14 = 0.001

			if 1.96599999815226 <= arg_59_1.time_ and arg_59_1.time_ < 1.96599999815226 + var_62_14 then
				var_62_13.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos6045ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 1.96599999815226) / var_62_14)
				var_62_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_13.position).x, (manager.ui.mainCamera.transform.position - var_62_13.position).y, (manager.ui.mainCamera.transform.position - var_62_13.position).z)
				var_62_13.localEulerAngles.z = 0
				var_62_13.localEulerAngles.x = 0
				var_62_13.localEulerAngles = var_62_13.localEulerAngles
			end

			if arg_59_1.time_ >= 1.96599999815226 + var_62_14 and arg_59_1.time_ < 1.96599999815226 + var_62_14 + arg_62_0 then
				var_62_13.localPosition = Vector3.New(0, 100, 0)
				var_62_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_13.position).x, (manager.ui.mainCamera.transform.position - var_62_13.position).y, (manager.ui.mainCamera.transform.position - var_62_13.position).z)
				var_62_13.localEulerAngles.z = 0
				var_62_13.localEulerAngles.x = 0
				var_62_13.localEulerAngles = var_62_13.localEulerAngles
			end

			local var_62_15 = arg_59_1.actors_["6045ui_story"]

			if 1.96599999815226 < arg_59_1.time_ and arg_59_1.time_ <= 1.96599999815226 + arg_62_0 and not isNil(var_62_15) and arg_59_1.var_.characterEffect6045ui_story == nil then
				arg_59_1.var_.characterEffect6045ui_story = var_62_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_16 = 0.034000001847744

			if 1.96599999815226 <= arg_59_1.time_ and arg_59_1.time_ < 1.96599999815226 + var_62_16 and not isNil(var_62_15) then
				if arg_59_1.var_.characterEffect6045ui_story and not isNil(var_62_15) then
					arg_59_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_59_1.var_.characterEffect6045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 1.96599999815226) / var_62_16)
				end
			end

			if arg_59_1.time_ >= 1.96599999815226 + var_62_16 and arg_59_1.time_ < 1.96599999815226 + var_62_16 + arg_62_0 and not isNil(var_62_15) and arg_59_1.var_.characterEffect6045ui_story then
				arg_59_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_59_1.var_.characterEffect6045ui_story.fillRatio = 0.5
			end

			local var_62_17 = arg_59_1.actors_["6046ui_story"].transform

			if 1.96599999815226 < arg_59_1.time_ and arg_59_1.time_ <= 1.96599999815226 + arg_62_0 then
				arg_59_1.var_.moveOldPos6046ui_story = var_62_17.localPosition
			end

			local var_62_18 = 0.001

			if 1.96599999815226 <= arg_59_1.time_ and arg_59_1.time_ < 1.96599999815226 + var_62_18 then
				var_62_17.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos6046ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 1.96599999815226) / var_62_18)
				var_62_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_17.position).x, (manager.ui.mainCamera.transform.position - var_62_17.position).y, (manager.ui.mainCamera.transform.position - var_62_17.position).z)
				var_62_17.localEulerAngles.z = 0
				var_62_17.localEulerAngles.x = 0
				var_62_17.localEulerAngles = var_62_17.localEulerAngles
			end

			if arg_59_1.time_ >= 1.96599999815226 + var_62_18 and arg_59_1.time_ < 1.96599999815226 + var_62_18 + arg_62_0 then
				var_62_17.localPosition = Vector3.New(0, 100, 0)
				var_62_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_17.position).x, (manager.ui.mainCamera.transform.position - var_62_17.position).y, (manager.ui.mainCamera.transform.position - var_62_17.position).z)
				var_62_17.localEulerAngles.z = 0
				var_62_17.localEulerAngles.x = 0
				var_62_17.localEulerAngles = var_62_17.localEulerAngles
			end

			local var_62_19 = arg_59_1.actors_["6046ui_story"]

			if 1.96599999815226 < arg_59_1.time_ and arg_59_1.time_ <= 1.96599999815226 + arg_62_0 and not isNil(var_62_19) and arg_59_1.var_.characterEffect6046ui_story == nil then
				arg_59_1.var_.characterEffect6046ui_story = var_62_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_20 = 0.034000001847744

			if 1.96599999815226 <= arg_59_1.time_ and arg_59_1.time_ < 1.96599999815226 + var_62_20 and not isNil(var_62_19) then
				if arg_59_1.var_.characterEffect6046ui_story and not isNil(var_62_19) then
					arg_59_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_59_1.var_.characterEffect6046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 1.96599999815226) / var_62_20)
				end
			end

			if arg_59_1.time_ >= 1.96599999815226 + var_62_20 and arg_59_1.time_ < 1.96599999815226 + var_62_20 + arg_62_0 and not isNil(var_62_19) and arg_59_1.var_.characterEffect6046ui_story then
				arg_59_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_59_1.var_.characterEffect6046ui_story.fillRatio = 0.5
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_21 = 4
			local var_62_22 = 0.375

			if 4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_23 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_23:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[303].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_24 = arg_59_1:GetWordFromCfg(412131014)
				local var_62_25 = arg_59_1:FormatText(var_62_24.content)

				arg_59_1.text_.text = var_62_25

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_27 = 15 <= 0 and var_62_22 or var_62_22 * (utf8.len(var_62_25) / 15)

				if (15 <= 0 and var_62_22 or var_62_22 * (utf8.len(var_62_25) / 15)) > 0 and var_62_22 < var_62_27 then
					arg_59_1.talkMaxDuration = var_62_27
					var_62_21 = var_62_21 + 0.3

					if var_62_27 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_27 + var_62_21
					end
				end

				arg_59_1.text_.text = var_62_25
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131014", "story_v_out_412131.awb") ~= 0 then
					local var_62_28 = manager.audio:GetVoiceLength("story_v_out_412131", "412131014", "story_v_out_412131.awb") / 1000

					if var_62_28 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_21
					end

					if var_62_24.prefab_name ~= "" and arg_59_1.actors_[var_62_24.prefab_name] ~= nil then
						local var_62_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_24.prefab_name].transform, "story_v_out_412131", "412131014", "story_v_out_412131.awb")

						arg_59_1:RecordAudio("412131014", var_62_29)
						arg_59_1:RecordAudio("412131014", var_62_29)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_412131", "412131014", "story_v_out_412131.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_412131", "412131014", "story_v_out_412131.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_30 = var_62_21 + 0.3
			local var_62_31 = math.max(var_62_22, arg_59_1.talkMaxDuration)

			if var_62_21 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_31 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_30) / var_62_31

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_30 + var_62_31 and arg_59_1.time_ < var_62_30 + var_62_31 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play412131015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412131015
		arg_65_1.duration_ = 19.13

		local var_65_0 = {
			zh = 19.133,
			ja = 13.666
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
				arg_65_0:Play412131016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 2

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[304].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(412131015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 79 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 79)

				if (79 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 79)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131015", "story_v_out_412131.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131015", "story_v_out_412131.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_412131", "412131015", "story_v_out_412131.awb")

						arg_65_1:RecordAudio("412131015", var_68_6)
						arg_65_1:RecordAudio("412131015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412131", "412131015", "story_v_out_412131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412131", "412131015", "story_v_out_412131.awb")
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
	Play412131016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412131016
		arg_69_1.duration_ = 10.23

		local var_69_0 = {
			zh = 10.233,
			ja = 7.133
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
				arg_69_0:Play412131017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.175

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[303].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(412131016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 47 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 47)

				if (47 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 47)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131016", "story_v_out_412131.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131016", "story_v_out_412131.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_412131", "412131016", "story_v_out_412131.awb")

						arg_69_1:RecordAudio("412131016", var_72_6)
						arg_69_1:RecordAudio("412131016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412131", "412131016", "story_v_out_412131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412131", "412131016", "story_v_out_412131.awb")
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
	Play412131017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412131017
		arg_73_1.duration_ = 8.83

		local var_73_0 = {
			zh = 4.9,
			ja = 8.833
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
				arg_73_0:Play412131018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[304].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(412131017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)

				if (23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131017", "story_v_out_412131.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131017", "story_v_out_412131.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_412131", "412131017", "story_v_out_412131.awb")

						arg_73_1:RecordAudio("412131017", var_76_6)
						arg_73_1:RecordAudio("412131017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412131", "412131017", "story_v_out_412131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412131", "412131017", "story_v_out_412131.awb")
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
	Play412131018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412131018
		arg_77_1.duration_ = 7.5

		local var_77_0 = {
			zh = 4.033,
			ja = 7.5
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
				arg_77_0:Play412131019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[303].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(412131018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 20 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 20)

				if (20 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 20)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131018", "story_v_out_412131.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131018", "story_v_out_412131.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_412131", "412131018", "story_v_out_412131.awb")

						arg_77_1:RecordAudio("412131018", var_80_6)
						arg_77_1:RecordAudio("412131018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412131", "412131018", "story_v_out_412131.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412131", "412131018", "story_v_out_412131.awb")
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
	Play412131019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412131019
		arg_81_1.duration_ = 17.37

		local var_81_0 = {
			zh = 16.166,
			ja = 17.366
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
				arg_81_0:Play412131020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[304].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(412131019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 69 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 69)

				if (69 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 69)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131019", "story_v_out_412131.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131019", "story_v_out_412131.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_412131", "412131019", "story_v_out_412131.awb")

						arg_81_1:RecordAudio("412131019", var_84_6)
						arg_81_1:RecordAudio("412131019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412131", "412131019", "story_v_out_412131.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412131", "412131019", "story_v_out_412131.awb")
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
	Play412131020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412131020
		arg_85_1.duration_ = 3.7

		local var_85_0 = {
			zh = 1.833,
			ja = 3.7
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
				arg_85_0:Play412131021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.15

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[303].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(412131020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 6 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 6)

				if (6 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 6)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131020", "story_v_out_412131.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131020", "story_v_out_412131.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_412131", "412131020", "story_v_out_412131.awb")

						arg_85_1:RecordAudio("412131020", var_88_6)
						arg_85_1:RecordAudio("412131020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412131", "412131020", "story_v_out_412131.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412131", "412131020", "story_v_out_412131.awb")
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
	Play412131021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412131021
		arg_89_1.duration_ = 5.5

		local var_89_0 = {
			zh = 5.5,
			ja = 4.2
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
				arg_89_0:Play412131022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[303].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(412131021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 16 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 16)

				if (16 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 16)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131021", "story_v_out_412131.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131021", "story_v_out_412131.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_412131", "412131021", "story_v_out_412131.awb")

						arg_89_1:RecordAudio("412131021", var_92_6)
						arg_89_1:RecordAudio("412131021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_412131", "412131021", "story_v_out_412131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_412131", "412131021", "story_v_out_412131.awb")
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
	Play412131022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412131022
		arg_93_1.duration_ = 7.13

		local var_93_0 = {
			zh = 7.133,
			ja = 6.833
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
				arg_93_0:Play412131023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.I09f == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09f")
				var_96_0.name = "I09f"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.I09f = var_96_0
			end

			if 1.9 < arg_93_1.time_ and arg_93_1.time_ <= 1.9 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.I09f

				arg_93_1.bgs_.I09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "I09f" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 4

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_4 + 0.3 and arg_93_1.time_ < var_96_4 + 0.3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_5 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_6 = 2

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 then
				local var_96_7 = Color.New(0, 0, 0)

				var_96_7.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_5) / var_96_6)
				arg_93_1.mask_.color = var_96_7
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 then
				local var_96_8 = Color.New(0, 0, 0)

				var_96_8.a = 1
				arg_93_1.mask_.color = var_96_8
			end

			local var_96_9 = 2

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_10 = 2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 then
				local var_96_11 = Color.New(0, 0, 0)

				var_96_11.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_9) / var_96_10)
				arg_93_1.mask_.color = var_96_11
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 then
				local var_96_12 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_12.a = 0
				arg_93_1.mask_.color = var_96_12
			end

			local var_96_13 = "1197ui_story"

			if arg_93_1.actors_["1197ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1197ui_story"))) then
				local var_96_14 = Object.Instantiate(Asset.Load("Char/" .. "1197ui_story"), arg_93_1.stage_.transform)

				var_96_14.name = var_96_13
				var_96_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_[var_96_13] = var_96_14

				local var_96_15 = var_96_14:GetComponentInChildren(typeof(CharacterEffect))

				var_96_15.enabled = true

				local var_96_16 = GameObjectTools.GetOrAddComponent(var_96_14, typeof(DynamicBoneHelper))

				if var_96_16 then
					var_96_16:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_15.transform, false)

				arg_93_1.var_[var_96_13 .. "Animator"] = var_96_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_[var_96_13 .. "Animator"].applyRootMotion = true
				arg_93_1.var_[var_96_13 .. "LipSync"] = var_96_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_17 = arg_93_1.actors_["1197ui_story"].transform

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1.var_.moveOldPos1197ui_story = var_96_17.localPosition
			end

			local var_96_18 = 0.001

			if 3.8 <= arg_93_1.time_ and arg_93_1.time_ < 3.8 + var_96_18 then
				var_96_17.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1197ui_story, Vector3.New(-0.7, -0.545, -6.3), (arg_93_1.time_ - 3.8) / var_96_18)
				var_96_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_17.position).x, (manager.ui.mainCamera.transform.position - var_96_17.position).y, (manager.ui.mainCamera.transform.position - var_96_17.position).z)
				var_96_17.localEulerAngles.z = 0
				var_96_17.localEulerAngles.x = 0
				var_96_17.localEulerAngles = var_96_17.localEulerAngles
			end

			if arg_93_1.time_ >= 3.8 + var_96_18 and arg_93_1.time_ < 3.8 + var_96_18 + arg_96_0 then
				var_96_17.localPosition = Vector3.New(-0.7, -0.545, -6.3)
				var_96_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_17.position).x, (manager.ui.mainCamera.transform.position - var_96_17.position).y, (manager.ui.mainCamera.transform.position - var_96_17.position).z)
				var_96_17.localEulerAngles.z = 0
				var_96_17.localEulerAngles.x = 0
				var_96_17.localEulerAngles = var_96_17.localEulerAngles
			end

			local var_96_19 = arg_93_1.actors_["1197ui_story"]

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 and not isNil(var_96_19) and arg_93_1.var_.characterEffect1197ui_story == nil then
				arg_93_1.var_.characterEffect1197ui_story = var_96_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_20 = 0.200000002980232

			if 3.8 <= arg_93_1.time_ and arg_93_1.time_ < 3.8 + var_96_20 and not isNil(var_96_19) then
				if arg_93_1.var_.characterEffect1197ui_story and not isNil(var_96_19) then
					arg_93_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 3.8 + var_96_20 and arg_93_1.time_ < 3.8 + var_96_20 + arg_96_0 and not isNil(var_96_19) and arg_93_1.var_.characterEffect1197ui_story then
				arg_93_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_22 = 3.9
			local var_96_23 = 0.325

			if 3.9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_22 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_24 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_24:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_25 = arg_93_1:GetWordFromCfg(412131022)
				local var_96_26 = arg_93_1:FormatText(var_96_25.content)

				arg_93_1.text_.text = var_96_26

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_28 = 13 <= 0 and var_96_23 or var_96_23 * (utf8.len(var_96_26) / 13)

				if (13 <= 0 and var_96_23 or var_96_23 * (utf8.len(var_96_26) / 13)) > 0 and var_96_23 < var_96_28 then
					arg_93_1.talkMaxDuration = var_96_28
					var_96_22 = var_96_22 + 0.3

					if var_96_28 + var_96_22 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_28 + var_96_22
					end
				end

				arg_93_1.text_.text = var_96_26
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131022", "story_v_out_412131.awb") ~= 0 then
					local var_96_29 = manager.audio:GetVoiceLength("story_v_out_412131", "412131022", "story_v_out_412131.awb") / 1000

					if var_96_29 + var_96_22 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_29 + var_96_22
					end

					if var_96_25.prefab_name ~= "" and arg_93_1.actors_[var_96_25.prefab_name] ~= nil then
						local var_96_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_25.prefab_name].transform, "story_v_out_412131", "412131022", "story_v_out_412131.awb")

						arg_93_1:RecordAudio("412131022", var_96_30)
						arg_93_1:RecordAudio("412131022", var_96_30)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_412131", "412131022", "story_v_out_412131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_412131", "412131022", "story_v_out_412131.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_31 = var_96_22 + 0.3
			local var_96_32 = math.max(var_96_23, arg_93_1.talkMaxDuration)

			if var_96_22 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_31 + var_96_32 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_31) / var_96_32

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_31 + var_96_32 and arg_93_1.time_ < var_96_31 + var_96_32 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play412131023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412131023
		arg_99_1.duration_ = 9.73

		local var_99_0 = {
			zh = 7.466,
			ja = 9.733
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
				arg_99_0:Play412131024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_102_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_99_1.stage_.transform)

				var_102_0.name = "10076ui_story"
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10076ui_story"] = var_102_0

				local var_102_1 = var_102_0:GetComponentInChildren(typeof(CharacterEffect))

				var_102_1.enabled = true

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_1.transform, false)

				arg_99_1.var_["10076ui_story" .. "Animator"] = var_102_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_99_1.var_["10076ui_story" .. "LipSync"] = var_102_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_3 = arg_99_1.actors_["10076ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10076ui_story = var_102_3.localPosition
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_99_1.time_ - 0) / var_102_4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(1, -0.35, -4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			local var_102_5 = arg_99_1.actors_["10076ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect10076ui_story == nil then
				arg_99_1.var_.characterEffect10076ui_story = var_102_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.characterEffect10076ui_story and not isNil(var_102_5) then
					arg_99_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect10076ui_story then
				arg_99_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action4_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_8 = arg_99_1.actors_["1197ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.characterEffect1197ui_story == nil then
				arg_99_1.var_.characterEffect1197ui_story = var_102_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_9 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_9 and not isNil(var_102_8) then
				if arg_99_1.var_.characterEffect1197ui_story and not isNil(var_102_8) then
					arg_99_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_9)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_9 and arg_99_1.time_ < 0 + var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.characterEffect1197ui_story then
				arg_99_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_102_10 = 0
			local var_102_11 = 0.875

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_12 = arg_99_1:GetWordFromCfg(412131023)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.text_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 35 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 35)

				if (35 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 35)) > 0 and var_102_11 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_13
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131023", "story_v_out_412131.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_412131", "412131023", "story_v_out_412131.awb") / 1000

					if var_102_16 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_10
					end

					if var_102_12.prefab_name ~= "" and arg_99_1.actors_[var_102_12.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_12.prefab_name].transform, "story_v_out_412131", "412131023", "story_v_out_412131.awb")

						arg_99_1:RecordAudio("412131023", var_102_17)
						arg_99_1:RecordAudio("412131023", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_412131", "412131023", "story_v_out_412131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_412131", "412131023", "story_v_out_412131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_18 and arg_99_1.time_ < var_102_10 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play412131024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412131024
		arg_103_1.duration_ = 9.9

		local var_103_0 = {
			zh = 8.966,
			ja = 9.9
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
				arg_103_0:Play412131025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1197ui_story"]) and arg_103_1.var_.characterEffect1197ui_story == nil then
				arg_103_1.var_.characterEffect1197ui_story = arg_103_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1197ui_story"]) then
				if arg_103_1.var_.characterEffect1197ui_story and not isNil(arg_103_1.actors_["1197ui_story"]) then
					arg_103_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1197ui_story"]) and arg_103_1.var_.characterEffect1197ui_story then
				arg_103_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_2")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_106_2 = arg_103_1.actors_["10076ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect10076ui_story == nil then
				arg_103_1.var_.characterEffect10076ui_story = var_106_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.characterEffect10076ui_story and not isNil(var_106_2) then
					arg_103_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_3)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect10076ui_story then
				arg_103_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_106_4 = 0
			local var_106_5 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(412131024)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 25 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 25)

				if (25 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 25)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131024", "story_v_out_412131.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131024", "story_v_out_412131.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_412131", "412131024", "story_v_out_412131.awb")

						arg_103_1:RecordAudio("412131024", var_106_11)
						arg_103_1:RecordAudio("412131024", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_412131", "412131024", "story_v_out_412131.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_412131", "412131024", "story_v_out_412131.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play412131025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412131025
		arg_107_1.duration_ = 9

		local var_107_0 = {
			zh = 4,
			ja = 9
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play412131026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if arg_107_1.actors_["10077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10077ui_story"))) then
				local var_110_0 = Object.Instantiate(Asset.Load("Char/" .. "10077ui_story"), arg_107_1.stage_.transform)

				var_110_0.name = "10077ui_story"
				var_110_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["10077ui_story"] = var_110_0

				local var_110_1 = var_110_0:GetComponentInChildren(typeof(CharacterEffect))

				var_110_1.enabled = true

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end

				arg_107_1:ShowWeapon(var_110_1.transform, false)

				arg_107_1.var_["10077ui_story" .. "Animator"] = var_110_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_107_1.var_["10077ui_story" .. "Animator"].applyRootMotion = true
				arg_107_1.var_["10077ui_story" .. "LipSync"] = var_110_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_110_3 = arg_107_1.actors_["10077ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10077ui_story = var_110_3.localPosition
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_3.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_107_1.time_ - 0) / var_110_4)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_3.localPosition = Vector3.New(0, 0, -5)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			local var_110_5 = arg_107_1.actors_["10077ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect10077ui_story == nil then
				arg_107_1.var_.characterEffect10077ui_story = var_110_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 and not isNil(var_110_5) then
				if arg_107_1.var_.characterEffect10077ui_story and not isNil(var_110_5) then
					arg_107_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect10077ui_story then
				arg_107_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_8 = arg_107_1.actors_["1197ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1197ui_story = var_110_8.localPosition
			end

			local var_110_9 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 then
				var_110_8.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_9)
				var_110_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_8.position).x, (manager.ui.mainCamera.transform.position - var_110_8.position).y, (manager.ui.mainCamera.transform.position - var_110_8.position).z)
				var_110_8.localEulerAngles.z = 0
				var_110_8.localEulerAngles.x = 0
				var_110_8.localEulerAngles = var_110_8.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 then
				var_110_8.localPosition = Vector3.New(0, 100, 0)
				var_110_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_8.position).x, (manager.ui.mainCamera.transform.position - var_110_8.position).y, (manager.ui.mainCamera.transform.position - var_110_8.position).z)
				var_110_8.localEulerAngles.z = 0
				var_110_8.localEulerAngles.x = 0
				var_110_8.localEulerAngles = var_110_8.localEulerAngles
			end

			local var_110_10 = arg_107_1.actors_["1197ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_10) and arg_107_1.var_.characterEffect1197ui_story == nil then
				arg_107_1.var_.characterEffect1197ui_story = var_110_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_11 and not isNil(var_110_10) then
				if arg_107_1.var_.characterEffect1197ui_story and not isNil(var_110_10) then
					arg_107_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_11)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_11 and arg_107_1.time_ < 0 + var_110_11 + arg_110_0 and not isNil(var_110_10) and arg_107_1.var_.characterEffect1197ui_story then
				arg_107_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_110_12 = arg_107_1.actors_["10076ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10076ui_story = var_110_12.localPosition
			end

			local var_110_13 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_13 then
				var_110_12.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_13)
				var_110_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_12.position).x, (manager.ui.mainCamera.transform.position - var_110_12.position).y, (manager.ui.mainCamera.transform.position - var_110_12.position).z)
				var_110_12.localEulerAngles.z = 0
				var_110_12.localEulerAngles.x = 0
				var_110_12.localEulerAngles = var_110_12.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_13 and arg_107_1.time_ < 0 + var_110_13 + arg_110_0 then
				var_110_12.localPosition = Vector3.New(0, 100, 0)
				var_110_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_12.position).x, (manager.ui.mainCamera.transform.position - var_110_12.position).y, (manager.ui.mainCamera.transform.position - var_110_12.position).z)
				var_110_12.localEulerAngles.z = 0
				var_110_12.localEulerAngles.x = 0
				var_110_12.localEulerAngles = var_110_12.localEulerAngles
			end

			local var_110_14 = arg_107_1.actors_["10076ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect10076ui_story == nil then
				arg_107_1.var_.characterEffect10076ui_story = var_110_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_15 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_15 and not isNil(var_110_14) then
				if arg_107_1.var_.characterEffect10076ui_story and not isNil(var_110_14) then
					arg_107_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_15)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_15 and arg_107_1.time_ < 0 + var_110_15 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect10076ui_story then
				arg_107_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_110_16 = 0
			local var_110_17 = 0.6

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(412131025)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_21 = 24 <= 0 and var_110_17 or var_110_17 * (utf8.len(var_110_19) / 24)

				if (24 <= 0 and var_110_17 or var_110_17 * (utf8.len(var_110_19) / 24)) > 0 and var_110_17 < var_110_21 then
					arg_107_1.talkMaxDuration = var_110_21

					if var_110_21 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_16
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131025", "story_v_out_412131.awb") ~= 0 then
					local var_110_22 = manager.audio:GetVoiceLength("story_v_out_412131", "412131025", "story_v_out_412131.awb") / 1000

					if var_110_22 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_16
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_412131", "412131025", "story_v_out_412131.awb")

						arg_107_1:RecordAudio("412131025", var_110_23)
						arg_107_1:RecordAudio("412131025", var_110_23)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412131", "412131025", "story_v_out_412131.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412131", "412131025", "story_v_out_412131.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_24 = math.max(var_110_17, arg_107_1.talkMaxDuration)

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_24 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_16) / var_110_24

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_16 + var_110_24 and arg_107_1.time_ < var_110_16 + var_110_24 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play412131026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412131026
		arg_111_1.duration_ = 10.77

		local var_111_0 = {
			zh = 10.333,
			ja = 10.766
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
				arg_111_0:Play412131027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.125

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(412131026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 45 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 45)

				if (45 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 45)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131026", "story_v_out_412131.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_412131", "412131026", "story_v_out_412131.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_412131", "412131026", "story_v_out_412131.awb")

						arg_111_1:RecordAudio("412131026", var_114_6)
						arg_111_1:RecordAudio("412131026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_412131", "412131026", "story_v_out_412131.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_412131", "412131026", "story_v_out_412131.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412131027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412131027
		arg_115_1.duration_ = 7.73

		local var_115_0 = {
			zh = 5.433,
			ja = 7.733
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play412131028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_118_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_115_1.stage_.transform)

				var_118_0.name = "10078ui_story"
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["10078ui_story"] = var_118_0

				local var_118_1 = var_118_0:GetComponentInChildren(typeof(CharacterEffect))

				var_118_1.enabled = true

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_1.transform, false)

				arg_115_1.var_["10078ui_story" .. "Animator"] = var_118_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_115_1.var_["10078ui_story" .. "LipSync"] = var_118_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_3 = arg_115_1.actors_["10078ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10078ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, -0.5, -6.3)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = arg_115_1.actors_["10078ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10078ui_story == nil then
				arg_115_1.var_.characterEffect10078ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_6 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.characterEffect10078ui_story and not isNil(var_118_5) then
					arg_115_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10078ui_story then
				arg_115_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_8 = arg_115_1.actors_["10077ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10077ui_story = var_118_8.localPosition
			end

			local var_118_9 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 then
				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_9)
				var_118_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_8.position).x, (manager.ui.mainCamera.transform.position - var_118_8.position).y, (manager.ui.mainCamera.transform.position - var_118_8.position).z)
				var_118_8.localEulerAngles.z = 0
				var_118_8.localEulerAngles.x = 0
				var_118_8.localEulerAngles = var_118_8.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(0, 100, 0)
				var_118_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_8.position).x, (manager.ui.mainCamera.transform.position - var_118_8.position).y, (manager.ui.mainCamera.transform.position - var_118_8.position).z)
				var_118_8.localEulerAngles.z = 0
				var_118_8.localEulerAngles.x = 0
				var_118_8.localEulerAngles = var_118_8.localEulerAngles
			end

			local var_118_10 = arg_115_1.actors_["10077ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10077ui_story == nil then
				arg_115_1.var_.characterEffect10077ui_story = var_118_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_11 and not isNil(var_118_10) then
				if arg_115_1.var_.characterEffect10077ui_story and not isNil(var_118_10) then
					arg_115_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_11)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_11 and arg_115_1.time_ < 0 + var_118_11 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10077ui_story then
				arg_115_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_118_12 = 0
			local var_118_13 = 0.475

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_14 = arg_115_1:GetWordFromCfg(412131027)
				local var_118_15 = arg_115_1:FormatText(var_118_14.content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 19 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 19)

				if (19 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 19)) > 0 and var_118_13 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17

					if var_118_17 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131027", "story_v_out_412131.awb") ~= 0 then
					local var_118_18 = manager.audio:GetVoiceLength("story_v_out_412131", "412131027", "story_v_out_412131.awb") / 1000

					if var_118_18 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_12
					end

					if var_118_14.prefab_name ~= "" and arg_115_1.actors_[var_118_14.prefab_name] ~= nil then
						local var_118_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_14.prefab_name].transform, "story_v_out_412131", "412131027", "story_v_out_412131.awb")

						arg_115_1:RecordAudio("412131027", var_118_19)
						arg_115_1:RecordAudio("412131027", var_118_19)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412131", "412131027", "story_v_out_412131.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412131", "412131027", "story_v_out_412131.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_20 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_20 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_20

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_20 and arg_115_1.time_ < var_118_12 + var_118_20 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play412131028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412131028
		arg_119_1.duration_ = 2.4

		local var_119_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play412131029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1197ui_story = arg_119_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).z)
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles = arg_119_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_119_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1197ui_story"].transform.position).z)
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1197ui_story"].transform.localEulerAngles = arg_119_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1197ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1197ui_story == nil then
				arg_119_1.var_.characterEffect1197ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1197ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1197ui_story then
				arg_119_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_122_4 = arg_119_1.actors_["10078ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10078ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, 100, 0)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = arg_119_1.actors_["10078ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10078ui_story == nil then
				arg_119_1.var_.characterEffect10078ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 and not isNil(var_122_6) then
				if arg_119_1.var_.characterEffect10078ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_7)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10078ui_story then
				arg_119_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_122_8 = 0
			local var_122_9 = 0.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(412131028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 8 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 8)

				if (8 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 8)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131028", "story_v_out_412131.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131028", "story_v_out_412131.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_412131", "412131028", "story_v_out_412131.awb")

						arg_119_1:RecordAudio("412131028", var_122_15)
						arg_119_1:RecordAudio("412131028", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_412131", "412131028", "story_v_out_412131.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_412131", "412131028", "story_v_out_412131.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play412131029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412131029
		arg_123_1.duration_ = 6.17

		local var_123_0 = {
			zh = 5.666,
			ja = 6.166
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
				arg_123_0:Play412131030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10078ui_story = arg_123_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).z)
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles = arg_123_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_123_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10078ui_story"].transform.position).z)
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10078ui_story"].transform.localEulerAngles = arg_123_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["10078ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10078ui_story == nil then
				arg_123_1.var_.characterEffect10078ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect10078ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10078ui_story then
				arg_123_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = arg_123_1.actors_["1197ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1197ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(0, 100, 0)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["1197ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1197ui_story == nil then
				arg_123_1.var_.characterEffect1197ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 and not isNil(var_126_6) then
				if arg_123_1.var_.characterEffect1197ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_7)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1197ui_story then
				arg_123_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_126_8 = 0
			local var_126_9 = 0.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(412131029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 19 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 19)

				if (19 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 19)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131029", "story_v_out_412131.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131029", "story_v_out_412131.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_412131", "412131029", "story_v_out_412131.awb")

						arg_123_1:RecordAudio("412131029", var_126_15)
						arg_123_1:RecordAudio("412131029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412131", "412131029", "story_v_out_412131.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412131", "412131029", "story_v_out_412131.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play412131030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412131030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play412131031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10078ui_story = arg_127_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).z)
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles = arg_127_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10078ui_story"].transform.position).z)
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10078ui_story"].transform.localEulerAngles = arg_127_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["10078ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10078ui_story == nil then
				arg_127_1.var_.characterEffect10078ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10078ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_2)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10078ui_story then
				arg_127_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_130_3 = 0
			local var_130_4 = 0.65

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_5 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(412131030).content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 26 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_5) / 26)

				if (26 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_5) / 26)) > 0 and var_130_4 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_3
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_4, arg_127_1.talkMaxDuration)

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_3) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_3 + var_130_8 and arg_127_1.time_ < var_130_3 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play412131031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412131031
		arg_131_1.duration_ = 4.8

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_131_0:Play412131032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10078ui_story = arg_131_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).z)
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles = arg_131_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_131_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10078ui_story"].transform.position).z)
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10078ui_story"].transform.localEulerAngles = arg_131_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10078ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10078ui_story == nil then
				arg_131_1.var_.characterEffect10078ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10078ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10078ui_story then
				arg_131_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_2")
			end

			local var_134_4 = 0
			local var_134_5 = 0.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(412131031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 5 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 5)

				if (5 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 5)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131031", "story_v_out_412131.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131031", "story_v_out_412131.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_412131", "412131031", "story_v_out_412131.awb")

						arg_131_1:RecordAudio("412131031", var_134_11)
						arg_131_1:RecordAudio("412131031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412131", "412131031", "story_v_out_412131.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412131", "412131031", "story_v_out_412131.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play412131032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412131032
		arg_135_1.duration_ = 6.23

		local var_135_0 = {
			zh = 5.433,
			ja = 6.233
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play412131033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_138_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_135_1.stage_.transform)

				var_138_0.name = "10083ui_story"
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["10083ui_story"] = var_138_0

				local var_138_1 = var_138_0:GetComponentInChildren(typeof(CharacterEffect))

				var_138_1.enabled = true

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end

				arg_135_1:ShowWeapon(var_138_1.transform, false)

				arg_135_1.var_["10083ui_story" .. "Animator"] = var_138_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_135_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_135_1.var_["10083ui_story" .. "LipSync"] = var_138_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_138_3 = arg_135_1.actors_["10083ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10083ui_story = var_138_3.localPosition
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_135_1.time_ - 0) / var_138_4)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -2.6, -2.8)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			local var_138_5 = arg_135_1.actors_["10083ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect10083ui_story == nil then
				arg_135_1.var_.characterEffect10083ui_story = var_138_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.characterEffect10083ui_story and not isNil(var_138_5) then
					arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect10083ui_story then
				arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_8 = arg_135_1.actors_["10078ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10078ui_story = var_138_8.localPosition
			end

			local var_138_9 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 then
				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_9)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(0, 100, 0)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			local var_138_10 = arg_135_1.actors_["10078ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect10078ui_story == nil then
				arg_135_1.var_.characterEffect10078ui_story = var_138_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_11 and not isNil(var_138_10) then
				if arg_135_1.var_.characterEffect10078ui_story and not isNil(var_138_10) then
					arg_135_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_11)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_11 and arg_135_1.time_ < 0 + var_138_11 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect10078ui_story then
				arg_135_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_138_12 = 0
			local var_138_13 = 0.6

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(412131032)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 24 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 24)

				if (24 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 24)) > 0 and var_138_13 < var_138_17 then
					arg_135_1.talkMaxDuration = var_138_17

					if var_138_17 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131032", "story_v_out_412131.awb") ~= 0 then
					local var_138_18 = manager.audio:GetVoiceLength("story_v_out_412131", "412131032", "story_v_out_412131.awb") / 1000

					if var_138_18 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_12
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_out_412131", "412131032", "story_v_out_412131.awb")

						arg_135_1:RecordAudio("412131032", var_138_19)
						arg_135_1:RecordAudio("412131032", var_138_19)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412131", "412131032", "story_v_out_412131.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412131", "412131032", "story_v_out_412131.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_20 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_20 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_20

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_20 and arg_135_1.time_ < var_138_12 + var_138_20 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play412131033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412131033
		arg_139_1.duration_ = 14.47

		local var_139_0 = {
			zh = 10.233,
			ja = 14.466
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
				arg_139_0:Play412131034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10078ui_story = arg_139_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).z)
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles = arg_139_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_139_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10078ui_story"].transform.position).z)
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10078ui_story"].transform.localEulerAngles = arg_139_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10078ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10078ui_story == nil then
				arg_139_1.var_.characterEffect10078ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10078ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10078ui_story then
				arg_139_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["10083ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10083ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0, 100, 0)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["10083ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect10083ui_story == nil then
				arg_139_1.var_.characterEffect10083ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect10083ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect10083ui_story then
				arg_139_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_142_8 = 0
			local var_142_9 = 0.95

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(412131033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 38 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 38)

				if (38 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 38)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131033", "story_v_out_412131.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131033", "story_v_out_412131.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_412131", "412131033", "story_v_out_412131.awb")

						arg_139_1:RecordAudio("412131033", var_142_15)
						arg_139_1:RecordAudio("412131033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412131", "412131033", "story_v_out_412131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412131", "412131033", "story_v_out_412131.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play412131034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 412131034
		arg_143_1.duration_ = 4.4

		local var_143_0 = {
			zh = 4.4,
			ja = 2
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play412131035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1197ui_story = arg_143_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).z)
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles = arg_143_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_143_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1197ui_story"].transform.position).z)
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1197ui_story"].transform.localEulerAngles = arg_143_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1197ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1197ui_story == nil then
				arg_143_1.var_.characterEffect1197ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1197ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1197ui_story then
				arg_143_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["10078ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10078ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, 100, 0)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = arg_143_1.actors_["10078ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10078ui_story == nil then
				arg_143_1.var_.characterEffect10078ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect10078ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10078ui_story then
				arg_143_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_146_8 = 0
			local var_146_9 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(412131034)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 12 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 12)

				if (12 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 12)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131034", "story_v_out_412131.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131034", "story_v_out_412131.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_412131", "412131034", "story_v_out_412131.awb")

						arg_143_1:RecordAudio("412131034", var_146_15)
						arg_143_1:RecordAudio("412131034", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_412131", "412131034", "story_v_out_412131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_412131", "412131034", "story_v_out_412131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play412131035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 412131035
		arg_147_1.duration_ = 11.3

		local var_147_0 = {
			zh = 9.466,
			ja = 11.3
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play412131036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10078ui_story = arg_147_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).z)
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles = arg_147_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_147_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10078ui_story"].transform.position).z)
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10078ui_story"].transform.localEulerAngles = arg_147_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["10078ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10078ui_story == nil then
				arg_147_1.var_.characterEffect10078ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect10078ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10078ui_story then
				arg_147_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = arg_147_1.actors_["1197ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1197ui_story == nil then
				arg_147_1.var_.characterEffect1197ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_5 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 and not isNil(var_150_4) then
				if arg_147_1.var_.characterEffect1197ui_story and not isNil(var_150_4) then
					arg_147_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_5)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1197ui_story then
				arg_147_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_150_6 = arg_147_1.actors_["1197ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1197ui_story = var_150_6.localPosition
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_6.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_7)
				var_150_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_6.position).x, (manager.ui.mainCamera.transform.position - var_150_6.position).y, (manager.ui.mainCamera.transform.position - var_150_6.position).z)
				var_150_6.localEulerAngles.z = 0
				var_150_6.localEulerAngles.x = 0
				var_150_6.localEulerAngles = var_150_6.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_6.localPosition = Vector3.New(0, 100, 0)
				var_150_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_6.position).x, (manager.ui.mainCamera.transform.position - var_150_6.position).y, (manager.ui.mainCamera.transform.position - var_150_6.position).z)
				var_150_6.localEulerAngles.z = 0
				var_150_6.localEulerAngles.x = 0
				var_150_6.localEulerAngles = var_150_6.localEulerAngles
			end

			local var_150_8 = 0
			local var_150_9 = 0.7

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(412131035)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 28 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 28)

				if (28 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 28)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131035", "story_v_out_412131.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131035", "story_v_out_412131.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_412131", "412131035", "story_v_out_412131.awb")

						arg_147_1:RecordAudio("412131035", var_150_15)
						arg_147_1:RecordAudio("412131035", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_412131", "412131035", "story_v_out_412131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_412131", "412131035", "story_v_out_412131.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play412131036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 412131036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play412131037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10078ui_story = arg_151_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).z)
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles = arg_151_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10078ui_story"].transform.position).z)
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10078ui_story"].transform.localEulerAngles = arg_151_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10078ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10078ui_story == nil then
				arg_151_1.var_.characterEffect10078ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10078ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10078ui_story then
				arg_151_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_154_3 = 0
			local var_154_4 = 0.7

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(412131036).content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 28 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 28)

				if (28 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 28)) > 0 and var_154_4 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_8 and arg_151_1.time_ < var_154_3 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play412131037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 412131037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play412131038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.2

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(412131037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 48 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 48)

				if (48 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 48)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play412131038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 412131038
		arg_159_1.duration_ = 7.27

		local var_159_0 = {
			zh = 6.466,
			ja = 7.266
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play412131039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1197ui_story = arg_159_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).z)
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles = arg_159_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_159_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1197ui_story"].transform.position).z)
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1197ui_story"].transform.localEulerAngles = arg_159_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1197ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1197ui_story == nil then
				arg_159_1.var_.characterEffect1197ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1197ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1197ui_story then
				arg_159_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.525

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(412131038)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 21 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 21)

				if (21 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 21)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131038", "story_v_out_412131.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131038", "story_v_out_412131.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_412131", "412131038", "story_v_out_412131.awb")

						arg_159_1:RecordAudio("412131038", var_162_11)
						arg_159_1:RecordAudio("412131038", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_412131", "412131038", "story_v_out_412131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_412131", "412131038", "story_v_out_412131.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play412131039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 412131039
		arg_163_1.duration_ = 5.03

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 5.033
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play412131040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10083ui_story = arg_163_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).z)
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles = arg_163_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_163_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10083ui_story"].transform.position).z)
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10083ui_story"].transform.localEulerAngles = arg_163_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["10083ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10083ui_story == nil then
				arg_163_1.var_.characterEffect10083ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect10083ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10083ui_story then
				arg_163_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_4 = arg_163_1.actors_["1197ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1197ui_story = var_166_4.localPosition
			end

			local var_166_5 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 then
				var_166_4.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_5)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 then
				var_166_4.localPosition = Vector3.New(0, 100, 0)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			local var_166_6 = arg_163_1.actors_["1197ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1197ui_story == nil then
				arg_163_1.var_.characterEffect1197ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_7 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 and not isNil(var_166_6) then
				if arg_163_1.var_.characterEffect1197ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_7)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1197ui_story then
				arg_163_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_166_8 = 0
			local var_166_9 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(412131039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 8 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 8)

				if (8 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 8)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131039", "story_v_out_412131.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131039", "story_v_out_412131.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_412131", "412131039", "story_v_out_412131.awb")

						arg_163_1:RecordAudio("412131039", var_166_15)
						arg_163_1:RecordAudio("412131039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_412131", "412131039", "story_v_out_412131.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_412131", "412131039", "story_v_out_412131.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play412131040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 412131040
		arg_167_1.duration_ = 6.5

		local var_167_0 = {
			zh = 2.766,
			ja = 6.5
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
				arg_167_0:Play412131041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10076ui_story = arg_167_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).z)
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles = arg_167_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_167_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10076ui_story"].transform.position).z)
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10076ui_story"].transform.localEulerAngles = arg_167_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["10076ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10076ui_story == nil then
				arg_167_1.var_.characterEffect10076ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect10076ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10076ui_story then
				arg_167_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = arg_167_1.actors_["10083ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10083ui_story = var_170_4.localPosition
			end

			local var_170_5 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				var_170_4.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_5)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				var_170_4.localPosition = Vector3.New(0, 100, 0)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			local var_170_6 = arg_167_1.actors_["10083ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10083ui_story == nil then
				arg_167_1.var_.characterEffect10083ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 and not isNil(var_170_6) then
				if arg_167_1.var_.characterEffect10083ui_story and not isNil(var_170_6) then
					arg_167_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_7)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10083ui_story then
				arg_167_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_170_8 = 0
			local var_170_9 = 0.3

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(412131040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 12 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 12)

				if (12 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 12)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131040", "story_v_out_412131.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131040", "story_v_out_412131.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_412131", "412131040", "story_v_out_412131.awb")

						arg_167_1:RecordAudio("412131040", var_170_15)
						arg_167_1:RecordAudio("412131040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_412131", "412131040", "story_v_out_412131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_412131", "412131040", "story_v_out_412131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play412131041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 412131041
		arg_171_1.duration_ = 5.47

		local var_171_0 = {
			zh = 5.466,
			ja = 4.4
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play412131042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10077ui_story = arg_171_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).z)
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles = arg_171_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_171_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10077ui_story"].transform.position).z)
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10077ui_story"].transform.localEulerAngles = arg_171_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10077ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10077ui_story == nil then
				arg_171_1.var_.characterEffect10077ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10077ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10077ui_story then
				arg_171_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action4_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_4 = arg_171_1.actors_["10076ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10076ui_story = var_174_4.localPosition
			end

			local var_174_5 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 then
				var_174_4.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_5)
				var_174_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_4.position).x, (manager.ui.mainCamera.transform.position - var_174_4.position).y, (manager.ui.mainCamera.transform.position - var_174_4.position).z)
				var_174_4.localEulerAngles.z = 0
				var_174_4.localEulerAngles.x = 0
				var_174_4.localEulerAngles = var_174_4.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 then
				var_174_4.localPosition = Vector3.New(0, 100, 0)
				var_174_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_4.position).x, (manager.ui.mainCamera.transform.position - var_174_4.position).y, (manager.ui.mainCamera.transform.position - var_174_4.position).z)
				var_174_4.localEulerAngles.z = 0
				var_174_4.localEulerAngles.x = 0
				var_174_4.localEulerAngles = var_174_4.localEulerAngles
			end

			local var_174_6 = arg_171_1.actors_["10076ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10076ui_story == nil then
				arg_171_1.var_.characterEffect10076ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_7 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 and not isNil(var_174_6) then
				if arg_171_1.var_.characterEffect10076ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10076ui_story then
				arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_174_8 = 0
			local var_174_9 = 0.75

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(412131041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 30 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 30)

				if (30 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 30)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131041", "story_v_out_412131.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131041", "story_v_out_412131.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_412131", "412131041", "story_v_out_412131.awb")

						arg_171_1:RecordAudio("412131041", var_174_15)
						arg_171_1:RecordAudio("412131041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_412131", "412131041", "story_v_out_412131.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_412131", "412131041", "story_v_out_412131.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play412131042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 412131042
		arg_175_1.duration_ = 4.3

		local var_175_0 = {
			zh = 2.633,
			ja = 4.3
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
				arg_175_0:Play412131043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10076ui_story = arg_175_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).z)
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles = arg_175_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_175_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10076ui_story"].transform.position).z)
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10076ui_story"].transform.localEulerAngles = arg_175_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["10076ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10076ui_story == nil then
				arg_175_1.var_.characterEffect10076ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10076ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10076ui_story then
				arg_175_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = arg_175_1.actors_["10077ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10077ui_story = var_178_4.localPosition
			end

			local var_178_5 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 then
				var_178_4.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_5)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 then
				var_178_4.localPosition = Vector3.New(0, 100, 0)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			local var_178_6 = arg_175_1.actors_["10077ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10077ui_story == nil then
				arg_175_1.var_.characterEffect10077ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_7 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 and not isNil(var_178_6) then
				if arg_175_1.var_.characterEffect10077ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_7)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10077ui_story then
				arg_175_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_178_8 = 0
			local var_178_9 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(412131042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 13 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 13)

				if (13 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 13)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131042", "story_v_out_412131.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_412131", "412131042", "story_v_out_412131.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_412131", "412131042", "story_v_out_412131.awb")

						arg_175_1:RecordAudio("412131042", var_178_15)
						arg_175_1:RecordAudio("412131042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_412131", "412131042", "story_v_out_412131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_412131", "412131042", "story_v_out_412131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play412131043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 412131043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play412131044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10076ui_story = arg_179_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).z)
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles = arg_179_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).z)
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles = arg_179_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["10076ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10076ui_story == nil then
				arg_179_1.var_.characterEffect10076ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10076ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_2)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10076ui_story then
				arg_179_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_182_3 = 0
			local var_182_4 = 0.8

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(412131043).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 32 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 32)

				if (32 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 32)) > 0 and var_182_4 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_8 and arg_179_1.time_ < var_182_3 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play412131044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 412131044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play412131045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.425

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(412131044).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 57 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 57)

				if (57 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 57)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play412131045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 412131045
		arg_187_1.duration_ = 7.37

		local var_187_0 = {
			zh = 4,
			ja = 7.366
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play412131046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1197ui_story = arg_187_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).z)
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles = arg_187_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_187_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1197ui_story"].transform.position).z)
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1197ui_story"].transform.localEulerAngles = arg_187_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1197ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1197ui_story == nil then
				arg_187_1.var_.characterEffect1197ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1197ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1197ui_story then
				arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.425

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(412131045)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 17 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 17)

				if (17 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 17)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131045", "story_v_out_412131.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_412131", "412131045", "story_v_out_412131.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_412131", "412131045", "story_v_out_412131.awb")

						arg_187_1:RecordAudio("412131045", var_190_11)
						arg_187_1:RecordAudio("412131045", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_412131", "412131045", "story_v_out_412131.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_412131", "412131045", "story_v_out_412131.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play412131046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 412131046
		arg_191_1.duration_ = 7

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play412131047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.bgs_.STwhite == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_194_0.name = "STwhite"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.STwhite = var_194_0
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.STwhite

				arg_191_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "STwhite" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 2

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_4 + 0.3 and arg_191_1.time_ < var_194_4 + 0.3 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_5 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_6 = 2

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 then
				local var_194_7 = Color.New(1, 1, 1)

				var_194_7.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_5) / var_194_6)
				arg_191_1.mask_.color = var_194_7
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 then
				local var_194_8 = Color.New(1, 1, 1)

				arg_191_1.mask_.enabled = false
				var_194_8.a = 0
				arg_191_1.mask_.color = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1197ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1197ui_story = var_194_9.localPosition
			end

			local var_194_10 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_10 then
				var_194_9.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_10)
				var_194_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_9.position).x, (manager.ui.mainCamera.transform.position - var_194_9.position).y, (manager.ui.mainCamera.transform.position - var_194_9.position).z)
				var_194_9.localEulerAngles.z = 0
				var_194_9.localEulerAngles.x = 0
				var_194_9.localEulerAngles = var_194_9.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_10 and arg_191_1.time_ < 0 + var_194_10 + arg_194_0 then
				var_194_9.localPosition = Vector3.New(0, 100, 0)
				var_194_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_9.position).x, (manager.ui.mainCamera.transform.position - var_194_9.position).y, (manager.ui.mainCamera.transform.position - var_194_9.position).z)
				var_194_9.localEulerAngles.z = 0
				var_194_9.localEulerAngles.x = 0
				var_194_9.localEulerAngles = var_194_9.localEulerAngles
			end

			local var_194_11 = arg_191_1.actors_["1197ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect1197ui_story == nil then
				arg_191_1.var_.characterEffect1197ui_story = var_194_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_12 = 0.034000001847744

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_12 and not isNil(var_194_11) then
				if arg_191_1.var_.characterEffect1197ui_story and not isNil(var_194_11) then
					arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_12)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_12 and arg_191_1.time_ < 0 + var_194_12 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect1197ui_story then
				arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_13 = 2
			local var_194_14 = 1.125

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_15 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_15:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_16 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(412131046).content)

				arg_191_1.text_.text = var_194_16

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_18 = 45 <= 0 and var_194_14 or var_194_14 * (utf8.len(var_194_16) / 45)

				if (45 <= 0 and var_194_14 or var_194_14 * (utf8.len(var_194_16) / 45)) > 0 and var_194_14 < var_194_18 then
					arg_191_1.talkMaxDuration = var_194_18
					var_194_13 = var_194_13 + 0.3

					if var_194_18 + var_194_13 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_13
					end
				end

				arg_191_1.text_.text = var_194_16
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_19 = var_194_13 + 0.3
			local var_194_20 = math.max(var_194_14, arg_191_1.talkMaxDuration)

			if var_194_13 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_19 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_19) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_19 + var_194_20 and arg_191_1.time_ < var_194_19 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play412131047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 412131047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play412131048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.525

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(412131047).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 21 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 21)

				if (21 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 21)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play412131048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 412131048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play412131049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.925

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(412131048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 76 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 76)

				if (76 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 76)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play412131049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 412131049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play412131050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.875

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(412131049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 35 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 35)

				if (35 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 35)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play412131050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 412131050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play412131051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.65

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(412131050).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)

				if (26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play412131051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 412131051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play412131052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.325

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(412131051).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 13 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 13)

				if (13 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 13)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play412131052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 412131052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
			arg_217_1.auto_ = false
		end

		function arg_217_1.playNext_(arg_219_0)
			arg_217_1.onStoryFinished_()
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(412131052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)

				if (10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/I09f",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_412131.awb"
	}
}
