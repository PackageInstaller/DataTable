return {
	Play113031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113031001
		arg_1_1.duration_ = 4.07

		local var_1_0 = {
			ja = 3.3,
			ko = 3.966,
			zh = 4.066,
			en = 3.4
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
				arg_1_0:Play113031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_4_0.name = "F01a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01a

				arg_1_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01a" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_10", "se_story_10_energy_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(113031001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 6 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 6)

				if (6 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 6)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031001", "story_v_out_113031.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_113031", "113031001", "story_v_out_113031.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_113031", "113031001", "story_v_out_113031.awb")

						arg_1_1:RecordAudio("113031001", var_4_23)
						arg_1_1:RecordAudio("113031001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113031", "113031001", "story_v_out_113031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113031", "113031001", "story_v_out_113031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113031002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_9_0:Play113031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1038ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1038ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1038ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1038ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1038ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1038ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_5 = arg_9_1.actors_["1038ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1038ui_story == nil then
				arg_9_1.var_.characterEffect1038ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1038ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1038ui_story then
				arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(113031002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 9 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 9)

				if (9 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 9)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031002", "story_v_out_113031.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_113031", "113031002", "story_v_out_113031.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_113031", "113031002", "story_v_out_113031.awb")

						arg_9_1:RecordAudio("113031002", var_12_15)
						arg_9_1:RecordAudio("113031002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113031", "113031002", "story_v_out_113031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113031", "113031002", "story_v_out_113031.awb")
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
				actorName = "1038ui_story",
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
	Play113031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1038ui_story = arg_13_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).z)
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles = arg_13_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1038ui_story"].transform.position).z)
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1038ui_story"].transform.localEulerAngles = arg_13_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_16_1 = 0
			local var_16_2 = 1.025

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(113031003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)

				if (41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)) > 0 and var_16_2 < var_16_5 then
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

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play113031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113031004
		arg_17_1.duration_ = 5.7

		local var_17_0 = {
			ja = 5.7,
			ko = 4.666,
			zh = 2.766,
			en = 3.2
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
				arg_17_0:Play113031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(113031004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 15)

				if (15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 15)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031004", "story_v_out_113031.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_113031", "113031004", "story_v_out_113031.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_113031", "113031004", "story_v_out_113031.awb")

						arg_17_1:RecordAudio("113031004", var_20_6)
						arg_17_1:RecordAudio("113031004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113031", "113031004", "story_v_out_113031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113031", "113031004", "story_v_out_113031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play113031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113031005
		arg_21_1.duration_ = 7

		local var_21_0 = {
			ja = 4.666,
			ko = 5.266,
			zh = 4.933,
			en = 7
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
				arg_21_0:Play113031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1038ui_story = arg_21_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).z)
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles = arg_21_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_21_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).z)
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles = arg_21_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_1 = arg_21_1.actors_["1038ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1038ui_story == nil then
				arg_21_1.var_.characterEffect1038ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1038ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1038ui_story then
				arg_21_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(113031005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 18 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 18)

				if (18 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 18)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031005", "story_v_out_113031.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031005", "story_v_out_113031.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_113031", "113031005", "story_v_out_113031.awb")

						arg_21_1:RecordAudio("113031005", var_24_11)
						arg_21_1:RecordAudio("113031005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113031", "113031005", "story_v_out_113031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113031", "113031005", "story_v_out_113031.awb")
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play113031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play113031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1038ui_story = arg_25_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).z)
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles = arg_25_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1038ui_story"].transform.position).z)
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1038ui_story"].transform.localEulerAngles = arg_25_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_10", "se_story_10_skill", "")
			end

			local var_28_2 = 0
			local var_28_3 = 0.775

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(113031006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 31)

				if (31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 31)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play113031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113031007
		arg_29_1.duration_ = 1.97

		local var_29_0 = {
			ja = 1.966,
			ko = 0.999999999999,
			zh = 1.833,
			en = 1.833
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
				arg_29_0:Play113031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.shakeOldPos1041ui_light = manager.ui.mainCamera.transform.localPosition
			end

			local var_32_0 = 0.6

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				local var_32_1, var_32_2 = math.modf((arg_29_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_32_2 * 0.13, var_32_2 * 0.13, var_32_2 * 0.13) + arg_29_1.var_.shakeOldPos1041ui_light
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				manager.ui.mainCamera.transform.localPosition = arg_29_1.var_.shakeOldPos1041ui_light
			end

			local var_32_3 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_3 + 0.6 and arg_29_1.time_ < var_32_3 + 0.6 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_4 = 0
			local var_32_5 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_6 = arg_29_1:GetWordFromCfg(113031007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 6 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 6)

				if (6 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 6)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031007", "story_v_out_113031.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031007", "story_v_out_113031.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_113031", "113031007", "story_v_out_113031.awb")

						arg_29_1:RecordAudio("113031007", var_32_11)
						arg_29_1:RecordAudio("113031007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113031", "113031007", "story_v_out_113031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113031", "113031007", "story_v_out_113031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113031008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("stop", "music", "se_story_10", "se_story_10_energy_loop", "")

				local var_36_2 = manager.audio:GetAudioName("se_story_10", "se_story_10_energy_loop")

				if "" ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_2 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_2

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_2
						arg_33_1.bgmTxt2_.text = var_36_2
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword", "")
			end

			local var_36_4 = 0
			local var_36_5 = 1.025

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(113031008).content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 41 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 41)

				if (41 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 41)) > 0 and var_36_5 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_9 and arg_33_1.time_ < var_36_4 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 113031009
		arg_38_1.duration_ = 5.23

		local var_38_0 = {
			ja = 4.566,
			ko = 5.233,
			zh = 5.066,
			en = 4.1
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play113031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.475

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:GetWordFromCfg(113031009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 19 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 19)

				if (19 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 19)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031009", "story_v_out_113031.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_113031", "113031009", "story_v_out_113031.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_113031", "113031009", "story_v_out_113031.awb")

						arg_38_1:RecordAudio("113031009", var_41_6)
						arg_38_1:RecordAudio("113031009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_113031", "113031009", "story_v_out_113031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_113031", "113031009", "story_v_out_113031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play113031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 113031010
		arg_42_1.duration_ = 4.57

		local var_42_0 = {
			ja = 4.3,
			ko = 4.566,
			zh = 4.166,
			en = 2.466
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play113031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1038ui_story = arg_42_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).z)
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles = arg_42_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_42_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1038ui_story"].transform.position).z)
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1038ui_story"].transform.localEulerAngles = arg_42_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["1038ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1038ui_story == nil then
				arg_42_1.var_.characterEffect1038ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 and not isNil(var_45_1) then
				if arg_42_1.var_.characterEffect1038ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1038ui_story then
				arg_42_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			local var_45_4 = 0
			local var_45_5 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(113031010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 20 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 20)

				if (20 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 20)) > 0 and var_45_5 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031010", "story_v_out_113031.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031010", "story_v_out_113031.awb") / 1000

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end

					if var_45_6.prefab_name ~= "" and arg_42_1.actors_[var_45_6.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_6.prefab_name].transform, "story_v_out_113031", "113031010", "story_v_out_113031.awb")

						arg_42_1:RecordAudio("113031010", var_45_11)
						arg_42_1:RecordAudio("113031010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_113031", "113031010", "story_v_out_113031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_113031", "113031010", "story_v_out_113031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_12 and arg_42_1.time_ < var_45_4 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play113031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 113031011
		arg_46_1.duration_ = 2.1

		local var_46_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play113031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1038ui_story"]) and arg_46_1.var_.characterEffect1038ui_story == nil then
				arg_46_1.var_.characterEffect1038ui_story = arg_46_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1038ui_story"]) then
				if arg_46_1.var_.characterEffect1038ui_story and not isNil(arg_46_1.actors_["1038ui_story"]) then
					arg_46_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1038ui_story"]) and arg_46_1.var_.characterEffect1038ui_story then
				arg_46_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_49_1 = "1041ui_story"

			if arg_46_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_49_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_46_1.stage_.transform)

				var_49_2.name = var_49_1
				var_49_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_[var_49_1] = var_49_2

				local var_49_3 = var_49_2:GetComponentInChildren(typeof(CharacterEffect))

				var_49_3.enabled = true

				local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_2, typeof(DynamicBoneHelper))

				if var_49_4 then
					var_49_4:EnableDynamicBone(false)
				end

				arg_46_1:ShowWeapon(var_49_3.transform, false)

				arg_46_1.var_[var_49_1 .. "Animator"] = var_49_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_46_1.var_[var_49_1 .. "Animator"].applyRootMotion = true
				arg_46_1.var_[var_49_1 .. "LipSync"] = var_49_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_49_5 = arg_46_1.actors_["1041ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1041ui_story = var_49_5.localPosition
			end

			local var_49_6 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_6 then
				var_49_5.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_46_1.time_ - 0) / var_49_6)
				var_49_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_5.position).x, (manager.ui.mainCamera.transform.position - var_49_5.position).y, (manager.ui.mainCamera.transform.position - var_49_5.position).z)
				var_49_5.localEulerAngles.z = 0
				var_49_5.localEulerAngles.x = 0
				var_49_5.localEulerAngles = var_49_5.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_6 and arg_46_1.time_ < 0 + var_49_6 + arg_49_0 then
				var_49_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_49_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_5.position).x, (manager.ui.mainCamera.transform.position - var_49_5.position).y, (manager.ui.mainCamera.transform.position - var_49_5.position).z)
				var_49_5.localEulerAngles.z = 0
				var_49_5.localEulerAngles.x = 0
				var_49_5.localEulerAngles = var_49_5.localEulerAngles
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_49_7 = arg_46_1.actors_["1041ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect1041ui_story == nil then
				arg_46_1.var_.characterEffect1041ui_story = var_49_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_8 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_8 and not isNil(var_49_7) then
				if arg_46_1.var_.characterEffect1041ui_story and not isNil(var_49_7) then
					arg_46_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_8 and arg_46_1.time_ < 0 + var_49_8 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect1041ui_story then
				arg_46_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_49_10 = 0
			local var_49_11 = 0.2

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_12 = arg_46_1:GetWordFromCfg(113031011)
				local var_49_13 = arg_46_1:FormatText(var_49_12.content)

				arg_46_1.text_.text = var_49_13

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_15 = 8 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 8)

				if (8 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 8)) > 0 and var_49_11 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_10
					end
				end

				arg_46_1.text_.text = var_49_13
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031011", "story_v_out_113031.awb") ~= 0 then
					local var_49_16 = manager.audio:GetVoiceLength("story_v_out_113031", "113031011", "story_v_out_113031.awb") / 1000

					if var_49_16 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_10
					end

					if var_49_12.prefab_name ~= "" and arg_46_1.actors_[var_49_12.prefab_name] ~= nil then
						local var_49_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_12.prefab_name].transform, "story_v_out_113031", "113031011", "story_v_out_113031.awb")

						arg_46_1:RecordAudio("113031011", var_49_17)
						arg_46_1:RecordAudio("113031011", var_49_17)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_113031", "113031011", "story_v_out_113031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_113031", "113031011", "story_v_out_113031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_11, arg_46_1.talkMaxDuration)

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_10) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_10 + var_49_18 and arg_46_1.time_ < var_49_10 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play113031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 113031012
		arg_50_1.duration_ = 1.57

		local var_50_0 = {
			ja = 1.466,
			ko = 1.566,
			zh = 1.266,
			en = 1.1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play113031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1041ui_story"]) and arg_50_1.var_.characterEffect1041ui_story == nil then
				arg_50_1.var_.characterEffect1041ui_story = arg_50_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1041ui_story"]) then
				if arg_50_1.var_.characterEffect1041ui_story and not isNil(arg_50_1.actors_["1041ui_story"]) then
					arg_50_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1041ui_story"]) and arg_50_1.var_.characterEffect1041ui_story then
				arg_50_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_53_1 = arg_50_1.actors_["1041ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1041ui_story = var_53_1.localPosition
			end

			local var_53_2 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 then
				var_53_1.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_2)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 then
				var_53_1.localPosition = Vector3.New(0, 100, 0)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles
			end

			local var_53_3 = arg_50_1.actors_["1038ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1038ui_story = var_53_3.localPosition
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_3.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_4)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_3.localPosition = Vector3.New(0, 100, 0)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles
			end

			local var_53_5 = 0
			local var_53_6 = 0.2

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_7 = arg_50_1:GetWordFromCfg(113031012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 5 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 5)

				if (5 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 5)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031012", "story_v_out_113031.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_113031", "113031012", "story_v_out_113031.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_113031", "113031012", "story_v_out_113031.awb")

						arg_50_1:RecordAudio("113031012", var_53_12)
						arg_50_1:RecordAudio("113031012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_113031", "113031012", "story_v_out_113031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_113031", "113031012", "story_v_out_113031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play113031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 113031013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play113031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.8

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(113031013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 32 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 32)

				if (32 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 32)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play113031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113031014
		arg_58_1.duration_ = 5.53

		local var_58_0 = {
			ja = 4.3,
			ko = 5.533,
			zh = 3.233,
			en = 2.933
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play113031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.4

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(113031014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 16 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 16)

				if (16 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 16)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031014", "story_v_out_113031.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_113031", "113031014", "story_v_out_113031.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_113031", "113031014", "story_v_out_113031.awb")

						arg_58_1:RecordAudio("113031014", var_61_6)
						arg_58_1:RecordAudio("113031014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113031", "113031014", "story_v_out_113031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113031", "113031014", "story_v_out_113031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play113031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 113031015
		arg_62_1.duration_ = 7.67

		local var_62_0 = {
			ja = 7.666,
			ko = 5.533,
			zh = 5.8,
			en = 6.5
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play113031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_65_0 = arg_62_1.actors_["1038ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1038ui_story == nil then
				arg_62_1.var_.characterEffect1038ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_1 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 and not isNil(var_65_0) then
				if arg_62_1.var_.characterEffect1038ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1038ui_story then
				arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_65_3 = arg_62_1.actors_["1038ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1038ui_story = var_65_3.localPosition
			end

			local var_65_4 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_3.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_62_1.time_ - 0) / var_65_4)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			local var_65_5 = 0
			local var_65_6 = 0.65

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_7 = arg_62_1:GetWordFromCfg(113031015)
				local var_65_8 = arg_62_1:FormatText(var_65_7.content)

				arg_62_1.text_.text = var_65_8

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 26 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 26)

				if (26 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 26)) > 0 and var_65_6 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_8
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031015", "story_v_out_113031.awb") ~= 0 then
					local var_65_11 = manager.audio:GetVoiceLength("story_v_out_113031", "113031015", "story_v_out_113031.awb") / 1000

					if var_65_11 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_5
					end

					if var_65_7.prefab_name ~= "" and arg_62_1.actors_[var_65_7.prefab_name] ~= nil then
						local var_65_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_7.prefab_name].transform, "story_v_out_113031", "113031015", "story_v_out_113031.awb")

						arg_62_1:RecordAudio("113031015", var_65_12)
						arg_62_1:RecordAudio("113031015", var_65_12)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_113031", "113031015", "story_v_out_113031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_113031", "113031015", "story_v_out_113031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_13 = math.max(var_65_6, arg_62_1.talkMaxDuration)

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_13 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_5) / var_65_13

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_5 + var_65_13 and arg_62_1.time_ < var_65_5 + var_65_13 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play113031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 113031016
		arg_66_1.duration_ = 14.9

		local var_66_0 = {
			ja = 14.9,
			ko = 10.4,
			zh = 10.9,
			en = 13.733
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
				arg_66_0:Play113031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_0 = 0
			local var_69_1 = 1.25

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(113031016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 46 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 46)

				if (46 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 46)) > 0 and var_69_1 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031016", "story_v_out_113031.awb") ~= 0 then
					local var_69_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031016", "story_v_out_113031.awb") / 1000

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end

					if var_69_2.prefab_name ~= "" and arg_66_1.actors_[var_69_2.prefab_name] ~= nil then
						local var_69_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_2.prefab_name].transform, "story_v_out_113031", "113031016", "story_v_out_113031.awb")

						arg_66_1:RecordAudio("113031016", var_69_7)
						arg_66_1:RecordAudio("113031016", var_69_7)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_113031", "113031016", "story_v_out_113031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_113031", "113031016", "story_v_out_113031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play113031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 113031017
		arg_70_1.duration_ = 10.53

		local var_70_0 = {
			ja = 5.4,
			ko = 10.533,
			zh = 7.9,
			en = 8.466
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play113031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1038ui_story"]) and arg_70_1.var_.characterEffect1038ui_story == nil then
				arg_70_1.var_.characterEffect1038ui_story = arg_70_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1038ui_story"]) then
				if arg_70_1.var_.characterEffect1038ui_story and not isNil(arg_70_1.actors_["1038ui_story"]) then
					arg_70_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1038ui_story"]) and arg_70_1.var_.characterEffect1038ui_story then
				arg_70_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_1 = arg_70_1.actors_["1041ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1041ui_story == nil then
				arg_70_1.var_.characterEffect1041ui_story = var_73_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 and not isNil(var_73_1) then
				if arg_70_1.var_.characterEffect1041ui_story and not isNil(var_73_1) then
					arg_70_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1041ui_story then
				arg_70_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1041ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1041ui_story = var_73_4.localPosition
			end

			local var_73_5 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				var_73_4.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_70_1.time_ - 0) / var_73_5)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				var_73_4.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			local var_73_6 = 0
			local var_73_7 = 1.05

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(113031017)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 42 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 42)

				if (42 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 42)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031017", "story_v_out_113031.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_113031", "113031017", "story_v_out_113031.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_113031", "113031017", "story_v_out_113031.awb")

						arg_70_1:RecordAudio("113031017", var_73_13)
						arg_70_1:RecordAudio("113031017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_113031", "113031017", "story_v_out_113031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_113031", "113031017", "story_v_out_113031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play113031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 113031018
		arg_74_1.duration_ = 7.8

		local var_74_0 = {
			ja = 7.8,
			ko = 7.7,
			zh = 6.133,
			en = 5.4
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play113031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_0 = 0
			local var_77_1 = 0.725

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(113031018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 29 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 29)

				if (29 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 29)) > 0 and var_77_1 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031018", "story_v_out_113031.awb") ~= 0 then
					local var_77_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031018", "story_v_out_113031.awb") / 1000

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end

					if var_77_2.prefab_name ~= "" and arg_74_1.actors_[var_77_2.prefab_name] ~= nil then
						local var_77_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_2.prefab_name].transform, "story_v_out_113031", "113031018", "story_v_out_113031.awb")

						arg_74_1:RecordAudio("113031018", var_77_7)
						arg_74_1:RecordAudio("113031018", var_77_7)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_113031", "113031018", "story_v_out_113031.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_113031", "113031018", "story_v_out_113031.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play113031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 113031019
		arg_78_1.duration_ = 4.6

		local var_78_0 = {
			ja = 4.066,
			ko = 2.966,
			zh = 2.866,
			en = 4.6
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
				arg_78_0:Play113031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action2_1")
			end

			local var_81_0 = 0
			local var_81_1 = 0.3

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(113031019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 12 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 12)

				if (12 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 12)) > 0 and var_81_1 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031019", "story_v_out_113031.awb") ~= 0 then
					local var_81_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031019", "story_v_out_113031.awb") / 1000

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end

					if var_81_2.prefab_name ~= "" and arg_78_1.actors_[var_81_2.prefab_name] ~= nil then
						local var_81_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_2.prefab_name].transform, "story_v_out_113031", "113031019", "story_v_out_113031.awb")

						arg_78_1:RecordAudio("113031019", var_81_7)
						arg_78_1:RecordAudio("113031019", var_81_7)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_113031", "113031019", "story_v_out_113031.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_113031", "113031019", "story_v_out_113031.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play113031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 113031020
		arg_82_1.duration_ = 2.63

		local var_82_0 = {
			ja = 2.633,
			ko = 1,
			zh = 1,
			en = 0.999999999999
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
				arg_82_0:Play113031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1041ui_story"]) and arg_82_1.var_.characterEffect1041ui_story == nil then
				arg_82_1.var_.characterEffect1041ui_story = arg_82_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1041ui_story"]) then
				if arg_82_1.var_.characterEffect1041ui_story and not isNil(arg_82_1.actors_["1041ui_story"]) then
					arg_82_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1041ui_story"]) and arg_82_1.var_.characterEffect1041ui_story then
				arg_82_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_85_1 = arg_82_1.actors_["1038ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1038ui_story == nil then
				arg_82_1.var_.characterEffect1038ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect1038ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1038ui_story then
				arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_85_4 = 0
			local var_85_5 = 0.175

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(113031020)
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

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031020", "story_v_out_113031.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031020", "story_v_out_113031.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_113031", "113031020", "story_v_out_113031.awb")

						arg_82_1:RecordAudio("113031020", var_85_11)
						arg_82_1:RecordAudio("113031020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_113031", "113031020", "story_v_out_113031.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_113031", "113031020", "story_v_out_113031.awb")
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
	Play113031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 113031021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play113031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1038ui_story = arg_86_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).z)
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles = arg_86_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1038ui_story"].transform.position).z)
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1038ui_story"].transform.localEulerAngles = arg_86_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1041ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1041ui_story = var_89_1.localPosition
			end

			local var_89_2 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_2)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			local var_89_3 = 0
			local var_89_4 = 1.4

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(113031021).content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 56 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 56)

				if (56 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 56)) > 0 and var_89_4 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_8 and arg_86_1.time_ < var_89_3 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play113031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 113031022
		arg_90_1.duration_ = 14.3

		local var_90_0 = {
			ja = 12.3,
			ko = 11.533,
			zh = 14.3,
			en = 14.166
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
				arg_90_0:Play113031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if arg_90_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_93_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_90_1.stage_.transform)

				var_93_0.name = "1042ui_story"
				var_93_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["1042ui_story"] = var_93_0

				local var_93_1 = var_93_0:GetComponentInChildren(typeof(CharacterEffect))

				var_93_1.enabled = true

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end

				arg_90_1:ShowWeapon(var_93_1.transform, false)

				arg_90_1.var_["1042ui_story" .. "Animator"] = var_93_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_90_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_90_1.var_["1042ui_story" .. "LipSync"] = var_93_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_93_3 = arg_90_1.actors_["1042ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1042ui_story = var_93_3.localPosition
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_3.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_90_1.time_ - 0) / var_93_4)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_93_5 = arg_90_1.actors_["1042ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1042ui_story == nil then
				arg_90_1.var_.characterEffect1042ui_story = var_93_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_6 and not isNil(var_93_5) then
				if arg_90_1.var_.characterEffect1042ui_story and not isNil(var_93_5) then
					arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_6 and arg_90_1.time_ < 0 + var_93_6 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1042ui_story then
				arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_93_8 = 0
			local var_93_9 = 1.35

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(113031022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 54 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 54)

				if (54 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 54)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031022", "story_v_out_113031.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_113031", "113031022", "story_v_out_113031.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_113031", "113031022", "story_v_out_113031.awb")

						arg_90_1:RecordAudio("113031022", var_93_15)
						arg_90_1:RecordAudio("113031022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_113031", "113031022", "story_v_out_113031.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_113031", "113031022", "story_v_out_113031.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play113031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 113031023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play113031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) and arg_94_1.var_.characterEffect1042ui_story == nil then
				arg_94_1.var_.characterEffect1042ui_story = arg_94_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) then
				if arg_94_1.var_.characterEffect1042ui_story and not isNil(arg_94_1.actors_["1042ui_story"]) then
					arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) and arg_94_1.var_.characterEffect1042ui_story then
				arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_97_1 = 0
			local var_97_2 = 0.225

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(113031023).content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 9 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 9)

				if (9 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 9)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_6 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_6 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_6

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_6 and arg_94_1.time_ < var_97_1 + var_97_6 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play113031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 113031024
		arg_98_1.duration_ = 5.93

		local var_98_0 = {
			ja = 5.766,
			ko = 5.6,
			zh = 4.9,
			en = 5.933
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
				arg_98_0:Play113031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_101_0 = arg_98_1.actors_["1041ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1041ui_story == nil then
				arg_98_1.var_.characterEffect1041ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_1 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 and not isNil(var_101_0) then
				if arg_98_1.var_.characterEffect1041ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1041ui_story then
				arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_101_3 = arg_98_1.actors_["1041ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1041ui_story = var_101_3.localPosition
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_3.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_98_1.time_ - 0) / var_101_4)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			local var_101_5 = 0
			local var_101_6 = 0.525

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:GetWordFromCfg(113031024)
				local var_101_8 = arg_98_1:FormatText(var_101_7.content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 20 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_8) / 20)

				if (20 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_8) / 20)) > 0 and var_101_6 < var_101_10 then
					arg_98_1.talkMaxDuration = var_101_10

					if var_101_10 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031024", "story_v_out_113031.awb") ~= 0 then
					local var_101_11 = manager.audio:GetVoiceLength("story_v_out_113031", "113031024", "story_v_out_113031.awb") / 1000

					if var_101_11 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_11 + var_101_5
					end

					if var_101_7.prefab_name ~= "" and arg_98_1.actors_[var_101_7.prefab_name] ~= nil then
						local var_101_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_7.prefab_name].transform, "story_v_out_113031", "113031024", "story_v_out_113031.awb")

						arg_98_1:RecordAudio("113031024", var_101_12)
						arg_98_1:RecordAudio("113031024", var_101_12)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_113031", "113031024", "story_v_out_113031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_113031", "113031024", "story_v_out_113031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_13 and arg_98_1.time_ < var_101_5 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play113031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 113031025
		arg_102_1.duration_ = 9.9

		local var_102_0 = {
			ja = 6.9,
			ko = 4.666,
			zh = 9,
			en = 9.9
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
				arg_102_0:Play113031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1042ui_story = arg_102_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).z)
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles = arg_102_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_102_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1042ui_story"].transform.position).z)
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1042ui_story"].transform.localEulerAngles = arg_102_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_105_1 = arg_102_1.actors_["1042ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1042ui_story == nil then
				arg_102_1.var_.characterEffect1042ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1042ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1042ui_story then
				arg_102_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1041ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1041ui_story == nil then
				arg_102_1.var_.characterEffect1041ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_5 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 and not isNil(var_105_4) then
				if arg_102_1.var_.characterEffect1041ui_story and not isNil(var_105_4) then
					arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_5)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1041ui_story then
				arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_105_6 = 0
			local var_105_7 = 0.925

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(113031025)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 37 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 37)

				if (37 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 37)) > 0 and var_105_7 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031025", "story_v_out_113031.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_113031", "113031025", "story_v_out_113031.awb") / 1000

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end

					if var_105_8.prefab_name ~= "" and arg_102_1.actors_[var_105_8.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_8.prefab_name].transform, "story_v_out_113031", "113031025", "story_v_out_113031.awb")

						arg_102_1:RecordAudio("113031025", var_105_13)
						arg_102_1:RecordAudio("113031025", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_113031", "113031025", "story_v_out_113031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_113031", "113031025", "story_v_out_113031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play113031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 113031026
		arg_106_1.duration_ = 2.5

		local var_106_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 2.3,
			en = 2.5
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
				arg_106_0:Play113031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_109_0 = 0
			local var_109_1 = 0.175

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(113031026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 7 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 7)

				if (7 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 7)) > 0 and var_109_1 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031026", "story_v_out_113031.awb") ~= 0 then
					local var_109_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031026", "story_v_out_113031.awb") / 1000

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end

					if var_109_2.prefab_name ~= "" and arg_106_1.actors_[var_109_2.prefab_name] ~= nil then
						local var_109_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_2.prefab_name].transform, "story_v_out_113031", "113031026", "story_v_out_113031.awb")

						arg_106_1:RecordAudio("113031026", var_109_7)
						arg_106_1:RecordAudio("113031026", var_109_7)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_113031", "113031026", "story_v_out_113031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_113031", "113031026", "story_v_out_113031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play113031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 113031027
		arg_110_1.duration_ = 3.83

		local var_110_0 = {
			ja = 2.1,
			ko = 3.833,
			zh = 3.366,
			en = 3.2
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
				arg_110_0:Play113031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1038ui_story = arg_110_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).z)
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles = arg_110_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.9)
				arg_110_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).z)
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles = arg_110_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_113_1 = arg_110_1.actors_["1038ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1038ui_story == nil then
				arg_110_1.var_.characterEffect1038ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1038ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1038ui_story then
				arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1041ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1041ui_story = var_113_4.localPosition
			end

			local var_113_5 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 then
				var_113_4.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_5)
				var_113_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_4.position).x, (manager.ui.mainCamera.transform.position - var_113_4.position).y, (manager.ui.mainCamera.transform.position - var_113_4.position).z)
				var_113_4.localEulerAngles.z = 0
				var_113_4.localEulerAngles.x = 0
				var_113_4.localEulerAngles = var_113_4.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 then
				var_113_4.localPosition = Vector3.New(0, 100, 0)
				var_113_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_4.position).x, (manager.ui.mainCamera.transform.position - var_113_4.position).y, (manager.ui.mainCamera.transform.position - var_113_4.position).z)
				var_113_4.localEulerAngles.z = 0
				var_113_4.localEulerAngles.x = 0
				var_113_4.localEulerAngles = var_113_4.localEulerAngles
			end

			local var_113_6 = arg_110_1.actors_["1042ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1042ui_story == nil then
				arg_110_1.var_.characterEffect1042ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 and not isNil(var_113_6) then
				if arg_110_1.var_.characterEffect1042ui_story and not isNil(var_113_6) then
					arg_110_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_7)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1042ui_story then
				arg_110_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_113_8 = 0
			local var_113_9 = 0.35

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:GetWordFromCfg(113031027)
				local var_113_11 = arg_110_1:FormatText(var_113_10.content)

				arg_110_1.text_.text = var_113_11

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 14 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 14)

				if (14 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 14)) > 0 and var_113_9 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_11
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031027", "story_v_out_113031.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_113031", "113031027", "story_v_out_113031.awb") / 1000

					if var_113_14 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_8
					end

					if var_113_10.prefab_name ~= "" and arg_110_1.actors_[var_113_10.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_10.prefab_name].transform, "story_v_out_113031", "113031027", "story_v_out_113031.awb")

						arg_110_1:RecordAudio("113031027", var_113_15)
						arg_110_1:RecordAudio("113031027", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_113031", "113031027", "story_v_out_113031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_113031", "113031027", "story_v_out_113031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_16 and arg_110_1.time_ < var_113_8 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play113031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 113031028
		arg_114_1.duration_ = 15.43

		local var_114_0 = {
			ja = 6.6,
			ko = 14.133,
			zh = 12.6,
			en = 15.433
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
				arg_114_0:Play113031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1038ui_story"]) and arg_114_1.var_.characterEffect1038ui_story == nil then
				arg_114_1.var_.characterEffect1038ui_story = arg_114_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1038ui_story"]) then
				if arg_114_1.var_.characterEffect1038ui_story and not isNil(arg_114_1.actors_["1038ui_story"]) then
					arg_114_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1038ui_story"]) and arg_114_1.var_.characterEffect1038ui_story then
				arg_114_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_117_1 = arg_114_1.actors_["1042ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1042ui_story == nil then
				arg_114_1.var_.characterEffect1042ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect1042ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1042ui_story then
				arg_114_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_117_4 = 0
			local var_117_5 = 1.3

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(113031028)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 52 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 52)

				if (52 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 52)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031028", "story_v_out_113031.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031028", "story_v_out_113031.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_113031", "113031028", "story_v_out_113031.awb")

						arg_114_1:RecordAudio("113031028", var_117_11)
						arg_114_1:RecordAudio("113031028", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_113031", "113031028", "story_v_out_113031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_113031", "113031028", "story_v_out_113031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play113031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 113031029
		arg_118_1.duration_ = 20.7

		local var_118_0 = {
			ja = 13.3,
			ko = 12.233,
			zh = 14.566,
			en = 20.7
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play113031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_121_0 = 0
			local var_121_1 = 1.375

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(113031029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 55 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_3) / 55)

				if (55 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_3) / 55)) > 0 and var_121_1 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031029", "story_v_out_113031.awb") ~= 0 then
					local var_121_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031029", "story_v_out_113031.awb") / 1000

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end

					if var_121_2.prefab_name ~= "" and arg_118_1.actors_[var_121_2.prefab_name] ~= nil then
						local var_121_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_2.prefab_name].transform, "story_v_out_113031", "113031029", "story_v_out_113031.awb")

						arg_118_1:RecordAudio("113031029", var_121_7)
						arg_118_1:RecordAudio("113031029", var_121_7)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_113031", "113031029", "story_v_out_113031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_113031", "113031029", "story_v_out_113031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_8 and arg_118_1.time_ < var_121_0 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play113031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 113031030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play113031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1042ui_story"]) and arg_122_1.var_.characterEffect1042ui_story == nil then
				arg_122_1.var_.characterEffect1042ui_story = arg_122_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1042ui_story"]) then
				if arg_122_1.var_.characterEffect1042ui_story and not isNil(arg_122_1.actors_["1042ui_story"]) then
					arg_122_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1042ui_story"]) and arg_122_1.var_.characterEffect1042ui_story then
				arg_122_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 1.175

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(113031030).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 47 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 47)

				if (47 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 47)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play113031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 113031031
		arg_126_1.duration_ = 8.7

		local var_126_0 = {
			ja = 5.333,
			ko = 7.9,
			zh = 5.4,
			en = 8.7
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
				arg_126_0:Play113031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1042ui_story = arg_126_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_129_0 = 0.5

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).z)
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles = arg_126_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_126_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1042ui_story"].transform.position).z)
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1042ui_story"].transform.localEulerAngles = arg_126_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_129_1 = "1084ui_story"

			if arg_126_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_126_1.stage_.transform)

				var_129_2.name = var_129_1
				var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_[var_129_1] = var_129_2

				local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

				var_129_3.enabled = true

				local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

				if var_129_4 then
					var_129_4:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_3.transform, false)

				arg_126_1.var_[var_129_1 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_[var_129_1 .. "Animator"].applyRootMotion = true
				arg_126_1.var_[var_129_1 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_5 = arg_126_1.actors_["1084ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_5.localPosition
			end

			local var_129_6 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 then
				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_126_1.time_ - 0) / var_129_6)
				var_129_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_5.position).x, (manager.ui.mainCamera.transform.position - var_129_5.position).y, (manager.ui.mainCamera.transform.position - var_129_5.position).z)
				var_129_5.localEulerAngles.z = 0
				var_129_5.localEulerAngles.x = 0
				var_129_5.localEulerAngles = var_129_5.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_129_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_5.position).x, (manager.ui.mainCamera.transform.position - var_129_5.position).y, (manager.ui.mainCamera.transform.position - var_129_5.position).z)
				var_129_5.localEulerAngles.z = 0
				var_129_5.localEulerAngles.x = 0
				var_129_5.localEulerAngles = var_129_5.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_129_7 = arg_126_1.actors_["1084ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_7) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_8 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_8 and not isNil(var_129_7) then
				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_7) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_8 and arg_126_1.time_ < 0 + var_129_8 + arg_129_0 and not isNil(var_129_7) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_10 = arg_126_1.actors_["1038ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1038ui_story = var_129_10.localPosition
			end

			local var_129_11 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_11 then
				var_129_10.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_11)
				var_129_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_10.position).x, (manager.ui.mainCamera.transform.position - var_129_10.position).y, (manager.ui.mainCamera.transform.position - var_129_10.position).z)
				var_129_10.localEulerAngles.z = 0
				var_129_10.localEulerAngles.x = 0
				var_129_10.localEulerAngles = var_129_10.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_11 and arg_126_1.time_ < 0 + var_129_11 + arg_129_0 then
				var_129_10.localPosition = Vector3.New(0, 100, 0)
				var_129_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_10.position).x, (manager.ui.mainCamera.transform.position - var_129_10.position).y, (manager.ui.mainCamera.transform.position - var_129_10.position).z)
				var_129_10.localEulerAngles.z = 0
				var_129_10.localEulerAngles.x = 0
				var_129_10.localEulerAngles = var_129_10.localEulerAngles
			end

			local var_129_12 = 0
			local var_129_13 = 1

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_14 = arg_126_1:GetWordFromCfg(113031031)
				local var_129_15 = arg_126_1:FormatText(var_129_14.content)

				arg_126_1.text_.text = var_129_15

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 42 <= 0 and var_129_13 or var_129_13 * (utf8.len(var_129_15) / 42)

				if (42 <= 0 and var_129_13 or var_129_13 * (utf8.len(var_129_15) / 42)) > 0 and var_129_13 < var_129_17 then
					arg_126_1.talkMaxDuration = var_129_17

					if var_129_17 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_17 + var_129_12
					end
				end

				arg_126_1.text_.text = var_129_15
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031031", "story_v_out_113031.awb") ~= 0 then
					local var_129_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031031", "story_v_out_113031.awb") / 1000

					if var_129_18 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_18 + var_129_12
					end

					if var_129_14.prefab_name ~= "" and arg_126_1.actors_[var_129_14.prefab_name] ~= nil then
						local var_129_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_14.prefab_name].transform, "story_v_out_113031", "113031031", "story_v_out_113031.awb")

						arg_126_1:RecordAudio("113031031", var_129_19)
						arg_126_1:RecordAudio("113031031", var_129_19)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_113031", "113031031", "story_v_out_113031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_113031", "113031031", "story_v_out_113031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_20 = math.max(var_129_13, arg_126_1.talkMaxDuration)

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_20 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_12) / var_129_20

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_12 + var_129_20 and arg_126_1.time_ < var_129_12 + var_129_20 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play113031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 113031032
		arg_130_1.duration_ = 9.1

		local var_130_0 = {
			ja = 7.633,
			ko = 6.133,
			zh = 5.766,
			en = 9.1
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
				arg_130_0:Play113031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_133_0 = 0
			local var_133_1 = 0.65

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(113031032)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 26 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 26)

				if (26 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 26)) > 0 and var_133_1 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031032", "story_v_out_113031.awb") ~= 0 then
					local var_133_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031032", "story_v_out_113031.awb") / 1000

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end

					if var_133_2.prefab_name ~= "" and arg_130_1.actors_[var_133_2.prefab_name] ~= nil then
						local var_133_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_2.prefab_name].transform, "story_v_out_113031", "113031032", "story_v_out_113031.awb")

						arg_130_1:RecordAudio("113031032", var_133_7)
						arg_130_1:RecordAudio("113031032", var_133_7)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_113031", "113031032", "story_v_out_113031.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_113031", "113031032", "story_v_out_113031.awb")
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
	Play113031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 113031033
		arg_134_1.duration_ = 14.47

		local var_134_0 = {
			ja = 14.466,
			ko = 5,
			zh = 6.7,
			en = 8.733
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
				arg_134_0:Play113031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = arg_134_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) then
				if arg_134_1.var_.characterEffect1084ui_story and not isNil(arg_134_1.actors_["1084ui_story"]) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_137_1 = arg_134_1.actors_["1042ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1042ui_story == nil then
				arg_134_1.var_.characterEffect1042ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1042ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1042ui_story then
				arg_134_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action423")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_137_4 = 0
			local var_137_5 = 0.725

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(113031033)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 29 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 29)

				if (29 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 29)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031033", "story_v_out_113031.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031033", "story_v_out_113031.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_113031", "113031033", "story_v_out_113031.awb")

						arg_134_1:RecordAudio("113031033", var_137_11)
						arg_134_1:RecordAudio("113031033", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_113031", "113031033", "story_v_out_113031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_113031", "113031033", "story_v_out_113031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play113031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 113031034
		arg_138_1.duration_ = 9.23

		local var_138_0 = {
			ja = 5.766,
			ko = 8.233,
			zh = 8.833,
			en = 9.233
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
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play113031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_141_0 = arg_138_1.actors_["1084ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_1 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 and not isNil(var_141_0) then
				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_141_3 = arg_138_1.actors_["1042ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1042ui_story == nil then
				arg_138_1.var_.characterEffect1042ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect1042ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_4)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1042ui_story then
				arg_138_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_141_5 = 0
			local var_141_6 = 0.85

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(113031034)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 30 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 30)

				if (30 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 30)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031034", "story_v_out_113031.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_113031", "113031034", "story_v_out_113031.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_113031", "113031034", "story_v_out_113031.awb")

						arg_138_1:RecordAudio("113031034", var_141_12)
						arg_138_1:RecordAudio("113031034", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_113031", "113031034", "story_v_out_113031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_113031", "113031034", "story_v_out_113031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play113031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 113031035
		arg_142_1.duration_ = 6.07

		local var_142_0 = {
			ja = 5,
			ko = 4.266,
			zh = 5.666,
			en = 6.066
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
				arg_142_0:Play113031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1042ui_story"]) and arg_142_1.var_.characterEffect1042ui_story == nil then
				arg_142_1.var_.characterEffect1042ui_story = arg_142_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1042ui_story"]) then
				if arg_142_1.var_.characterEffect1042ui_story and not isNil(arg_142_1.actors_["1042ui_story"]) then
					arg_142_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1042ui_story"]) and arg_142_1.var_.characterEffect1042ui_story then
				arg_142_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action434")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_145_2 = arg_142_1.actors_["1084ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_145_4 = 0
			local var_145_5 = 0.375

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(113031035)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 15 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 15)

				if (15 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 15)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031035", "story_v_out_113031.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031035", "story_v_out_113031.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_113031", "113031035", "story_v_out_113031.awb")

						arg_142_1:RecordAudio("113031035", var_145_11)
						arg_142_1:RecordAudio("113031035", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_113031", "113031035", "story_v_out_113031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_113031", "113031035", "story_v_out_113031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play113031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 113031036
		arg_146_1.duration_ = 2.47

		local var_146_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 2.166,
			en = 2.1
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play113031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_149_0 = arg_146_1.actors_["1084ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_0.localPosition
			end

			local var_149_1 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 then
				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_1)
				var_149_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_0.position).x, (manager.ui.mainCamera.transform.position - var_149_0.position).y, (manager.ui.mainCamera.transform.position - var_149_0.position).z)
				var_149_0.localEulerAngles.z = 0
				var_149_0.localEulerAngles.x = 0
				var_149_0.localEulerAngles = var_149_0.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)
				var_149_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_0.position).x, (manager.ui.mainCamera.transform.position - var_149_0.position).y, (manager.ui.mainCamera.transform.position - var_149_0.position).z)
				var_149_0.localEulerAngles.z = 0
				var_149_0.localEulerAngles.x = 0
				var_149_0.localEulerAngles = var_149_0.localEulerAngles
			end

			local var_149_2 = arg_146_1.actors_["1042ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1042ui_story = var_149_2.localPosition
			end

			local var_149_3 = 0.5

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 then
				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_146_1.time_ - 0) / var_149_3)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, -1.06, -6.2)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			local var_149_4 = 0
			local var_149_5 = 0.15

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(113031036)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 6 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 6)

				if (6 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 6)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031036", "story_v_out_113031.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031036", "story_v_out_113031.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_113031", "113031036", "story_v_out_113031.awb")

						arg_146_1:RecordAudio("113031036", var_149_11)
						arg_146_1:RecordAudio("113031036", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_113031", "113031036", "story_v_out_113031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_113031", "113031036", "story_v_out_113031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play113031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 113031037
		arg_150_1.duration_ = 2.37

		local var_150_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 2.366,
			en = 2.166
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
				arg_150_0:Play113031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1042ui_story = arg_150_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).z)
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles = arg_150_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1042ui_story"].transform.position).z)
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1042ui_story"].transform.localEulerAngles = arg_150_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1084ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_1.localPosition
			end

			local var_153_2 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 then
				var_153_1.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_2)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 then
				var_153_1.localPosition = Vector3.New(0, 100, 0)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			local var_153_3 = "6045_story"

			if arg_150_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_153_4 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_150_1.stage_.transform)

				var_153_4.name = var_153_3
				var_153_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_[var_153_3] = var_153_4

				local var_153_5 = var_153_4:GetComponentInChildren(typeof(CharacterEffect))

				var_153_5.enabled = true

				local var_153_6 = GameObjectTools.GetOrAddComponent(var_153_4, typeof(DynamicBoneHelper))

				if var_153_6 then
					var_153_6:EnableDynamicBone(false)
				end

				arg_150_1:ShowWeapon(var_153_5.transform, false)

				arg_150_1.var_[var_153_3 .. "Animator"] = var_153_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_150_1.var_[var_153_3 .. "Animator"].applyRootMotion = true
				arg_150_1.var_[var_153_3 .. "LipSync"] = var_153_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_153_7 = arg_150_1.actors_["6045_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos6045_story = var_153_7.localPosition

				local var_153_8 = GameObjectTools.GetOrAddComponent(var_153_7.gameObject, typeof(DynamicBoneHelper))

				if var_153_8 then
					var_153_8:EnableDynamicBone(false)
				end
			end

			local var_153_9 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_9 then
				var_153_7.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_150_1.time_ - 0) / var_153_9)
				var_153_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_7.position).x, (manager.ui.mainCamera.transform.position - var_153_7.position).y, (manager.ui.mainCamera.transform.position - var_153_7.position).z)
				var_153_7.localEulerAngles.z = 0
				var_153_7.localEulerAngles.x = 0
				var_153_7.localEulerAngles = var_153_7.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_9 and arg_150_1.time_ < 0 + var_153_9 + arg_153_0 then
				var_153_7.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_153_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_7.position).x, (manager.ui.mainCamera.transform.position - var_153_7.position).y, (manager.ui.mainCamera.transform.position - var_153_7.position).z)
				var_153_7.localEulerAngles.z = 0
				var_153_7.localEulerAngles.x = 0
				var_153_7.localEulerAngles = var_153_7.localEulerAngles

				local var_153_10 = GameObjectTools.GetOrAddComponent(var_153_7.gameObject, typeof(DynamicBoneHelper))

				if var_153_10 then
					var_153_10:EnableDynamicBone(true)
				end
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_153_11 = arg_150_1.actors_["6045_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect6045_story == nil then
				arg_150_1.var_.characterEffect6045_story = var_153_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_12 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_12 and not isNil(var_153_11) then
				if arg_150_1.var_.characterEffect6045_story and not isNil(var_153_11) then
					arg_150_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_12 and arg_150_1.time_ < 0 + var_153_12 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect6045_story then
				arg_150_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_153_14 = 0
			local var_153_15 = 0.2

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_16 = arg_150_1:GetWordFromCfg(113031037)
				local var_153_17 = arg_150_1:FormatText(var_153_16.content)

				arg_150_1.text_.text = var_153_17

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_19 = 8 <= 0 and var_153_15 or var_153_15 * (utf8.len(var_153_17) / 8)

				if (8 <= 0 and var_153_15 or var_153_15 * (utf8.len(var_153_17) / 8)) > 0 and var_153_15 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_14
					end
				end

				arg_150_1.text_.text = var_153_17
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031037", "story_v_out_113031.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031037", "story_v_out_113031.awb") / 1000

					if var_153_20 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_14
					end

					if var_153_16.prefab_name ~= "" and arg_150_1.actors_[var_153_16.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_16.prefab_name].transform, "story_v_out_113031", "113031037", "story_v_out_113031.awb")

						arg_150_1:RecordAudio("113031037", var_153_21)
						arg_150_1:RecordAudio("113031037", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_113031", "113031037", "story_v_out_113031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_113031", "113031037", "story_v_out_113031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_15, arg_150_1.talkMaxDuration)

			if var_153_14 <= arg_150_1.time_ and arg_150_1.time_ < var_153_14 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_14) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_14 + var_153_22 and arg_150_1.time_ < var_153_14 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play113031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 113031038
		arg_154_1.duration_ = 2.57

		local var_154_0 = {
			ja = 2.566,
			ko = 2.166,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play113031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if arg_154_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_157_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_154_1.stage_.transform)

				var_157_0.name = "6046_story"
				var_157_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["6046_story"] = var_157_0

				local var_157_1 = var_157_0:GetComponentInChildren(typeof(CharacterEffect))

				var_157_1.enabled = true

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end

				arg_154_1:ShowWeapon(var_157_1.transform, false)

				arg_154_1.var_["6046_story" .. "Animator"] = var_157_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_154_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_154_1.var_["6046_story" .. "LipSync"] = var_157_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_157_3 = arg_154_1.actors_["6045_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect6045_story == nil then
				arg_154_1.var_.characterEffect6045_story = var_157_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 and not isNil(var_157_3) then
				if arg_154_1.var_.characterEffect6045_story and not isNil(var_157_3) then
					arg_154_1.var_.characterEffect6045_story.fillFlat = true
					arg_154_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_4)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect6045_story then
				arg_154_1.var_.characterEffect6045_story.fillFlat = true
				arg_154_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_157_5 = arg_154_1.actors_["6046_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos6046_story = var_157_5.localPosition

				local var_157_6 = GameObjectTools.GetOrAddComponent(var_157_5.gameObject, typeof(DynamicBoneHelper))

				if var_157_6 then
					var_157_6:EnableDynamicBone(false)
				end
			end

			local var_157_7 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				var_157_5.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_154_1.time_ - 0) / var_157_7)
				var_157_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_5.position).x, (manager.ui.mainCamera.transform.position - var_157_5.position).y, (manager.ui.mainCamera.transform.position - var_157_5.position).z)
				var_157_5.localEulerAngles.z = 0
				var_157_5.localEulerAngles.x = 0
				var_157_5.localEulerAngles = var_157_5.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				var_157_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_157_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_5.position).x, (manager.ui.mainCamera.transform.position - var_157_5.position).y, (manager.ui.mainCamera.transform.position - var_157_5.position).z)
				var_157_5.localEulerAngles.z = 0
				var_157_5.localEulerAngles.x = 0
				var_157_5.localEulerAngles = var_157_5.localEulerAngles

				local var_157_8 = GameObjectTools.GetOrAddComponent(var_157_5.gameObject, typeof(DynamicBoneHelper))

				if var_157_8 then
					var_157_8:EnableDynamicBone(true)
				end
			end

			local var_157_9 = arg_154_1.actors_["6046_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect6046_story == nil then
				arg_154_1.var_.characterEffect6046_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_10 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_10 and not isNil(var_157_9) then
				if arg_154_1.var_.characterEffect6046_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_10 and arg_154_1.time_ < 0 + var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect6046_story then
				arg_154_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_157_12 = 0
			local var_157_13 = 0.2

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_14 = arg_154_1:GetWordFromCfg(113031038)
				local var_157_15 = arg_154_1:FormatText(var_157_14.content)

				arg_154_1.text_.text = var_157_15

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 8 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 8)

				if (8 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 8)) > 0 and var_157_13 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_15
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031038", "story_v_out_113031.awb") ~= 0 then
					local var_157_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031038", "story_v_out_113031.awb") / 1000

					if var_157_18 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_18 + var_157_12
					end

					if var_157_14.prefab_name ~= "" and arg_154_1.actors_[var_157_14.prefab_name] ~= nil then
						local var_157_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_14.prefab_name].transform, "story_v_out_113031", "113031038", "story_v_out_113031.awb")

						arg_154_1:RecordAudio("113031038", var_157_19)
						arg_154_1:RecordAudio("113031038", var_157_19)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_113031", "113031038", "story_v_out_113031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_113031", "113031038", "story_v_out_113031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_20 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_20 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_20

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_20 and arg_154_1.time_ < var_157_12 + var_157_20 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play113031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 113031039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play113031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if arg_158_1.actors_["6046_tpose"] == nil and not isNil((Asset.Load("Char/" .. "6046_tpose"))) then
				local var_161_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_tpose"), arg_158_1.stage_.transform)

				var_161_0.name = "6046_tpose"
				var_161_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["6046_tpose"] = var_161_0

				local var_161_1 = var_161_0:GetComponentInChildren(typeof(CharacterEffect))

				var_161_1.enabled = true

				local var_161_2 = GameObjectTools.GetOrAddComponent(var_161_0, typeof(DynamicBoneHelper))

				if var_161_2 then
					var_161_2:EnableDynamicBone(false)
				end

				arg_158_1:ShowWeapon(var_161_1.transform, false)

				arg_158_1.var_["6046_tpose" .. "Animator"] = var_161_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_158_1.var_["6046_tpose" .. "Animator"].applyRootMotion = true
				arg_158_1.var_["6046_tpose" .. "LipSync"] = var_161_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_161_3 = arg_158_1.actors_["6046_tpose"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect6046_tpose == nil then
				arg_158_1.var_.characterEffect6046_tpose = var_161_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_4 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 and not isNil(var_161_3) then
				if arg_158_1.var_.characterEffect6046_tpose and not isNil(var_161_3) then
					arg_158_1.var_.characterEffect6046_tpose.fillFlat = true
					arg_158_1.var_.characterEffect6046_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_4)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect6046_tpose then
				arg_158_1.var_.characterEffect6046_tpose.fillFlat = true
				arg_158_1.var_.characterEffect6046_tpose.fillRatio = 0.5
			end

			local var_161_5 = 0
			local var_161_6 = 0.5

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_7 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(113031039).content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 20 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 20)

				if (20 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 20)) > 0 and var_161_6 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_5
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_6, arg_158_1.talkMaxDuration)

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_5) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_5 + var_161_10 and arg_158_1.time_ < var_161_5 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play113031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 113031040
		arg_162_1.duration_ = 6.53

		local var_162_0 = {
			ja = 6.533,
			ko = 4.833,
			zh = 5.6,
			en = 5.5
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
				arg_162_0:Play113031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos6045_story = arg_162_1.actors_["6045_story"].transform.localPosition

				local var_165_0 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_0 then
					var_165_0:EnableDynamicBone(false)
				end
			end

			local var_165_1 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_1)
				arg_162_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).z)
				arg_162_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["6045_story"].transform.localEulerAngles = arg_162_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["6045_story"].transform.position).z)
				arg_162_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["6045_story"].transform.localEulerAngles = arg_162_1.actors_["6045_story"].transform.localEulerAngles

				local var_165_2 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(true)
				end
			end

			local var_165_3 = arg_162_1.actors_["6046_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos6046_story = var_165_3.localPosition

				local var_165_4 = GameObjectTools.GetOrAddComponent(var_165_3.gameObject, typeof(DynamicBoneHelper))

				if var_165_4 then
					var_165_4:EnableDynamicBone(false)
				end
			end

			local var_165_5 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_5 then
				var_165_3.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_5)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_5 and arg_162_1.time_ < 0 + var_165_5 + arg_165_0 then
				var_165_3.localPosition = Vector3.New(0, 100, 0)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles

				local var_165_6 = GameObjectTools.GetOrAddComponent(var_165_3.gameObject, typeof(DynamicBoneHelper))

				if var_165_6 then
					var_165_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_165_7 = arg_162_1.actors_["1042ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect1042ui_story == nil then
				arg_162_1.var_.characterEffect1042ui_story = var_165_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_8 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_8 and not isNil(var_165_7) then
				if arg_162_1.var_.characterEffect1042ui_story and not isNil(var_165_7) then
					arg_162_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_8 and arg_162_1.time_ < 0 + var_165_8 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect1042ui_story then
				arg_162_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_165_10 = arg_162_1.actors_["1042ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1042ui_story = var_165_10.localPosition
			end

			local var_165_11 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_11 then
				var_165_10.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_162_1.time_ - 0) / var_165_11)
				var_165_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_10.position).x, (manager.ui.mainCamera.transform.position - var_165_10.position).y, (manager.ui.mainCamera.transform.position - var_165_10.position).z)
				var_165_10.localEulerAngles.z = 0
				var_165_10.localEulerAngles.x = 0
				var_165_10.localEulerAngles = var_165_10.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_11 and arg_162_1.time_ < 0 + var_165_11 + arg_165_0 then
				var_165_10.localPosition = Vector3.New(0, -1.06, -6.2)
				var_165_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_10.position).x, (manager.ui.mainCamera.transform.position - var_165_10.position).y, (manager.ui.mainCamera.transform.position - var_165_10.position).z)
				var_165_10.localEulerAngles.z = 0
				var_165_10.localEulerAngles.x = 0
				var_165_10.localEulerAngles = var_165_10.localEulerAngles
			end

			local var_165_12 = 0
			local var_165_13 = 0.6

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_14 = arg_162_1:GetWordFromCfg(113031040)
				local var_165_15 = arg_162_1:FormatText(var_165_14.content)

				arg_162_1.text_.text = var_165_15

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_17 = 24 <= 0 and var_165_13 or var_165_13 * (utf8.len(var_165_15) / 24)

				if (24 <= 0 and var_165_13 or var_165_13 * (utf8.len(var_165_15) / 24)) > 0 and var_165_13 < var_165_17 then
					arg_162_1.talkMaxDuration = var_165_17

					if var_165_17 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_12
					end
				end

				arg_162_1.text_.text = var_165_15
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031040", "story_v_out_113031.awb") ~= 0 then
					local var_165_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031040", "story_v_out_113031.awb") / 1000

					if var_165_18 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_18 + var_165_12
					end

					if var_165_14.prefab_name ~= "" and arg_162_1.actors_[var_165_14.prefab_name] ~= nil then
						local var_165_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_14.prefab_name].transform, "story_v_out_113031", "113031040", "story_v_out_113031.awb")

						arg_162_1:RecordAudio("113031040", var_165_19)
						arg_162_1:RecordAudio("113031040", var_165_19)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_113031", "113031040", "story_v_out_113031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_113031", "113031040", "story_v_out_113031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_20 = math.max(var_165_13, arg_162_1.talkMaxDuration)

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_20 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_12) / var_165_20

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_12 + var_165_20 and arg_162_1.time_ < var_165_12 + var_165_20 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play113031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 113031041
		arg_166_1.duration_ = 6.07

		local var_166_0 = {
			ja = 6.066,
			ko = 5.4,
			zh = 6.033,
			en = 5.266
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play113031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1042ui_story = arg_166_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).z)
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles = arg_166_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1042ui_story"].transform.position).z)
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1042ui_story"].transform.localEulerAngles = arg_166_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["6046_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos6046_story = var_169_1.localPosition

				local var_169_2 = GameObjectTools.GetOrAddComponent(var_169_1.gameObject, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(false)
				end
			end

			local var_169_3 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 then
				var_169_1.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_166_1.time_ - 0) / var_169_3)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 then
				var_169_1.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles

				local var_169_4 = GameObjectTools.GetOrAddComponent(var_169_1.gameObject, typeof(DynamicBoneHelper))

				if var_169_4 then
					var_169_4:EnableDynamicBone(true)
				end
			end

			local var_169_5 = arg_166_1.actors_["6045_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos6045_story = var_169_5.localPosition

				local var_169_6 = GameObjectTools.GetOrAddComponent(var_169_5.gameObject, typeof(DynamicBoneHelper))

				if var_169_6 then
					var_169_6:EnableDynamicBone(false)
				end
			end

			local var_169_7 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_166_1.time_ - 0) / var_169_7)
				var_169_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_5.position).x, (manager.ui.mainCamera.transform.position - var_169_5.position).y, (manager.ui.mainCamera.transform.position - var_169_5.position).z)
				var_169_5.localEulerAngles.z = 0
				var_169_5.localEulerAngles.x = 0
				var_169_5.localEulerAngles = var_169_5.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_169_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_5.position).x, (manager.ui.mainCamera.transform.position - var_169_5.position).y, (manager.ui.mainCamera.transform.position - var_169_5.position).z)
				var_169_5.localEulerAngles.z = 0
				var_169_5.localEulerAngles.x = 0
				var_169_5.localEulerAngles = var_169_5.localEulerAngles

				local var_169_8 = GameObjectTools.GetOrAddComponent(var_169_5.gameObject, typeof(DynamicBoneHelper))

				if var_169_8 then
					var_169_8:EnableDynamicBone(true)
				end
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_169_9 = arg_166_1.actors_["6045_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect6045_story == nil then
				arg_166_1.var_.characterEffect6045_story = var_169_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_10 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_10 and not isNil(var_169_9) then
				if arg_166_1.var_.characterEffect6045_story and not isNil(var_169_9) then
					arg_166_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_10 and arg_166_1.time_ < 0 + var_169_10 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect6045_story then
				arg_166_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_169_12 = 0
			local var_169_13 = 0.45

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_14 = arg_166_1:GetWordFromCfg(113031041)
				local var_169_15 = arg_166_1:FormatText(var_169_14.content)

				arg_166_1.text_.text = var_169_15

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_17 = 18 <= 0 and var_169_13 or var_169_13 * (utf8.len(var_169_15) / 18)

				if (18 <= 0 and var_169_13 or var_169_13 * (utf8.len(var_169_15) / 18)) > 0 and var_169_13 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17

					if var_169_17 + var_169_12 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_12
					end
				end

				arg_166_1.text_.text = var_169_15
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031041", "story_v_out_113031.awb") ~= 0 then
					local var_169_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031041", "story_v_out_113031.awb") / 1000

					if var_169_18 + var_169_12 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_12
					end

					if var_169_14.prefab_name ~= "" and arg_166_1.actors_[var_169_14.prefab_name] ~= nil then
						local var_169_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_14.prefab_name].transform, "story_v_out_113031", "113031041", "story_v_out_113031.awb")

						arg_166_1:RecordAudio("113031041", var_169_19)
						arg_166_1:RecordAudio("113031041", var_169_19)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_113031", "113031041", "story_v_out_113031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_113031", "113031041", "story_v_out_113031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_20 = math.max(var_169_13, arg_166_1.talkMaxDuration)

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_20 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_12) / var_169_20

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_12 + var_169_20 and arg_166_1.time_ < var_169_12 + var_169_20 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play113031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 113031042
		arg_170_1.duration_ = 4.37

		local var_170_0 = {
			ja = 3.2,
			ko = 3.3,
			zh = 4.366,
			en = 2.366
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
				arg_170_0:Play113031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["6045_story"]) and arg_170_1.var_.characterEffect6045_story == nil then
				arg_170_1.var_.characterEffect6045_story = arg_170_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["6045_story"]) then
				if arg_170_1.var_.characterEffect6045_story and not isNil(arg_170_1.actors_["6045_story"]) then
					arg_170_1.var_.characterEffect6045_story.fillFlat = true
					arg_170_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["6045_story"]) and arg_170_1.var_.characterEffect6045_story then
				arg_170_1.var_.characterEffect6045_story.fillFlat = true
				arg_170_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_173_1 = arg_170_1.actors_["6046_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect6046_story == nil then
				arg_170_1.var_.characterEffect6046_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect6046_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect6046_story then
				arg_170_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_173_4 = 0
			local var_173_5 = 0.425

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(113031042)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 17 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 17)

				if (17 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 17)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031042", "story_v_out_113031.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031042", "story_v_out_113031.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_113031", "113031042", "story_v_out_113031.awb")

						arg_170_1:RecordAudio("113031042", var_173_11)
						arg_170_1:RecordAudio("113031042", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_113031", "113031042", "story_v_out_113031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_113031", "113031042", "story_v_out_113031.awb")
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

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play113031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 113031043
		arg_174_1.duration_ = 18.87

		local var_174_0 = {
			ja = 18.866,
			ko = 10.8,
			zh = 11.266,
			en = 13.166
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
				arg_174_0:Play113031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos6045_story = arg_174_1.actors_["6045_story"].transform.localPosition

				local var_177_0 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_0 then
					var_177_0:EnableDynamicBone(false)
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_1)
				arg_174_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).z)
				arg_174_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["6045_story"].transform.localEulerAngles = arg_174_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["6045_story"].transform.position).z)
				arg_174_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["6045_story"].transform.localEulerAngles = arg_174_1.actors_["6045_story"].transform.localEulerAngles

				local var_177_2 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(true)
				end
			end

			local var_177_3 = arg_174_1.actors_["6046_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos6046_story = var_177_3.localPosition

				local var_177_4 = GameObjectTools.GetOrAddComponent(var_177_3.gameObject, typeof(DynamicBoneHelper))

				if var_177_4 then
					var_177_4:EnableDynamicBone(false)
				end
			end

			local var_177_5 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_5 then
				var_177_3.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_5)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_5 and arg_174_1.time_ < 0 + var_177_5 + arg_177_0 then
				var_177_3.localPosition = Vector3.New(0, 100, 0)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles

				local var_177_6 = GameObjectTools.GetOrAddComponent(var_177_3.gameObject, typeof(DynamicBoneHelper))

				if var_177_6 then
					var_177_6:EnableDynamicBone(true)
				end
			end

			local var_177_7 = arg_174_1.actors_["1041ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1041ui_story = var_177_7.localPosition
			end

			local var_177_8 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_8 then
				var_177_7.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_174_1.time_ - 0) / var_177_8)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_8 and arg_174_1.time_ < 0 + var_177_8 + arg_177_0 then
				var_177_7.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_177_9 = arg_174_1.actors_["1041ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1041ui_story == nil then
				arg_174_1.var_.characterEffect1041ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_10 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_10 and not isNil(var_177_9) then
				if arg_174_1.var_.characterEffect1041ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_10 and arg_174_1.time_ < 0 + var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1041ui_story then
				arg_174_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_177_12 = 0
			local var_177_13 = 1.375

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_14 = arg_174_1:GetWordFromCfg(113031043)
				local var_177_15 = arg_174_1:FormatText(var_177_14.content)

				arg_174_1.text_.text = var_177_15

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_17 = 55 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 55)

				if (55 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 55)) > 0 and var_177_13 < var_177_17 then
					arg_174_1.talkMaxDuration = var_177_17

					if var_177_17 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_12
					end
				end

				arg_174_1.text_.text = var_177_15
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031043", "story_v_out_113031.awb") ~= 0 then
					local var_177_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031043", "story_v_out_113031.awb") / 1000

					if var_177_18 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_12
					end

					if var_177_14.prefab_name ~= "" and arg_174_1.actors_[var_177_14.prefab_name] ~= nil then
						local var_177_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_14.prefab_name].transform, "story_v_out_113031", "113031043", "story_v_out_113031.awb")

						arg_174_1:RecordAudio("113031043", var_177_19)
						arg_174_1:RecordAudio("113031043", var_177_19)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_113031", "113031043", "story_v_out_113031.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_113031", "113031043", "story_v_out_113031.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_20 = math.max(var_177_13, arg_174_1.talkMaxDuration)

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_20 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_12) / var_177_20

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_12 + var_177_20 and arg_174_1.time_ < var_177_12 + var_177_20 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play113031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113031044
		arg_178_1.duration_ = 10.27

		local var_178_0 = {
			ja = 10.266,
			ko = 4.933,
			zh = 4.2,
			en = 6.3
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
				arg_178_0:Play113031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1041ui_story"]) and arg_178_1.var_.characterEffect1041ui_story == nil then
				arg_178_1.var_.characterEffect1041ui_story = arg_178_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1041ui_story"]) then
				if arg_178_1.var_.characterEffect1041ui_story and not isNil(arg_178_1.actors_["1041ui_story"]) then
					arg_178_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1041ui_story"]) and arg_178_1.var_.characterEffect1041ui_story then
				arg_178_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_181_1 = arg_178_1.actors_["1038ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1038ui_story = var_181_1.localPosition
			end

			local var_181_2 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 then
				var_181_1.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_178_1.time_ - 0) / var_181_2)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 then
				var_181_1.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_3 = arg_178_1.actors_["1038ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect1038ui_story == nil then
				arg_178_1.var_.characterEffect1038ui_story = var_181_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_4 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 and not isNil(var_181_3) then
				if arg_178_1.var_.characterEffect1038ui_story and not isNil(var_181_3) then
					arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect1038ui_story then
				arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_181_6 = 0
			local var_181_7 = 0.625

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(113031044)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 25 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 25)

				if (25 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 25)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031044", "story_v_out_113031.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_113031", "113031044", "story_v_out_113031.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_113031", "113031044", "story_v_out_113031.awb")

						arg_178_1:RecordAudio("113031044", var_181_13)
						arg_178_1:RecordAudio("113031044", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_113031", "113031044", "story_v_out_113031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_113031", "113031044", "story_v_out_113031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play113031045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113031045
		arg_182_1.duration_ = 9.27

		local var_182_0 = {
			ja = 9.266,
			ko = 7.5,
			zh = 7.766,
			en = 8.8
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
				arg_182_0:Play113031046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1038ui_story"]) and arg_182_1.var_.characterEffect1038ui_story == nil then
				arg_182_1.var_.characterEffect1038ui_story = arg_182_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1038ui_story"]) then
				if arg_182_1.var_.characterEffect1038ui_story and not isNil(arg_182_1.actors_["1038ui_story"]) then
					arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1038ui_story"]) and arg_182_1.var_.characterEffect1038ui_story then
				arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_185_1 = arg_182_1.actors_["1041ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1041ui_story == nil then
				arg_182_1.var_.characterEffect1041ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1041ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1041ui_story then
				arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_185_4 = 0
			local var_185_5 = 0.85

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(113031045)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 34 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 34)

				if (34 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 34)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031045", "story_v_out_113031.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031045", "story_v_out_113031.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_113031", "113031045", "story_v_out_113031.awb")

						arg_182_1:RecordAudio("113031045", var_185_11)
						arg_182_1:RecordAudio("113031045", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_113031", "113031045", "story_v_out_113031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_113031", "113031045", "story_v_out_113031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play113031046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113031046
		arg_186_1.duration_ = 6.7

		local var_186_0 = {
			ja = 6.7,
			ko = 5.766,
			zh = 5.1,
			en = 5.866
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
				arg_186_0:Play113031047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			local var_189_0 = 0
			local var_189_1 = 0.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(113031046)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 22 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 22)

				if (22 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 22)) > 0 and var_189_1 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031046", "story_v_out_113031.awb") ~= 0 then
					local var_189_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031046", "story_v_out_113031.awb") / 1000

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end

					if var_189_2.prefab_name ~= "" and arg_186_1.actors_[var_189_2.prefab_name] ~= nil then
						local var_189_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_2.prefab_name].transform, "story_v_out_113031", "113031046", "story_v_out_113031.awb")

						arg_186_1:RecordAudio("113031046", var_189_7)
						arg_186_1:RecordAudio("113031046", var_189_7)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_113031", "113031046", "story_v_out_113031.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_113031", "113031046", "story_v_out_113031.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play113031047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 113031047
		arg_190_1.duration_ = 5.53

		local var_190_0 = {
			ja = 5.533,
			ko = 3.833,
			zh = 4.6,
			en = 4.3
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play113031048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1041ui_story"]) and arg_190_1.var_.characterEffect1041ui_story == nil then
				arg_190_1.var_.characterEffect1041ui_story = arg_190_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1041ui_story"]) then
				if arg_190_1.var_.characterEffect1041ui_story and not isNil(arg_190_1.actors_["1041ui_story"]) then
					arg_190_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1041ui_story"]) and arg_190_1.var_.characterEffect1041ui_story then
				arg_190_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_193_1 = arg_190_1.actors_["1038ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1038ui_story == nil then
				arg_190_1.var_.characterEffect1038ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1038ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1038ui_story then
				arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_193_4 = 0
			local var_193_5 = 0.45

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(113031047)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 18 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 18)

				if (18 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 18)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031047", "story_v_out_113031.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031047", "story_v_out_113031.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_113031", "113031047", "story_v_out_113031.awb")

						arg_190_1:RecordAudio("113031047", var_193_11)
						arg_190_1:RecordAudio("113031047", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_113031", "113031047", "story_v_out_113031.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_113031", "113031047", "story_v_out_113031.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play113031048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 113031048
		arg_194_1.duration_ = 10.33

		local var_194_0 = {
			ja = 8.8,
			ko = 8.1,
			zh = 10.033,
			en = 10.333
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
				arg_194_0:Play113031049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1041ui_story"]) and arg_194_1.var_.characterEffect1041ui_story == nil then
				arg_194_1.var_.characterEffect1041ui_story = arg_194_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1041ui_story"]) then
				if arg_194_1.var_.characterEffect1041ui_story and not isNil(arg_194_1.actors_["1041ui_story"]) then
					arg_194_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1041ui_story"]) and arg_194_1.var_.characterEffect1041ui_story then
				arg_194_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_197_2 = arg_194_1.actors_["1038ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1038ui_story == nil then
				arg_194_1.var_.characterEffect1038ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.characterEffect1038ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_3)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1038ui_story then
				arg_194_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_197_4 = 0
			local var_197_5 = 1.225

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(113031048)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 49 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 49)

				if (49 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 49)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031048", "story_v_out_113031.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031048", "story_v_out_113031.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_out_113031", "113031048", "story_v_out_113031.awb")

						arg_194_1:RecordAudio("113031048", var_197_11)
						arg_194_1:RecordAudio("113031048", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_113031", "113031048", "story_v_out_113031.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_113031", "113031048", "story_v_out_113031.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play113031049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 113031049
		arg_198_1.duration_ = 7.5

		local var_198_0 = {
			ja = 7.5,
			ko = 5.3,
			zh = 5.666,
			en = 5.9
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
				arg_198_0:Play113031050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1041ui_story"]) and arg_198_1.var_.characterEffect1041ui_story == nil then
				arg_198_1.var_.characterEffect1041ui_story = arg_198_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1041ui_story"]) then
				if arg_198_1.var_.characterEffect1041ui_story and not isNil(arg_198_1.actors_["1041ui_story"]) then
					arg_198_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1041ui_story"]) and arg_198_1.var_.characterEffect1041ui_story then
				arg_198_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_201_1 = arg_198_1.actors_["1038ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1038ui_story == nil then
				arg_198_1.var_.characterEffect1038ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1038ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1038ui_story then
				arg_198_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action425")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_201_4 = 0
			local var_201_5 = 0.525

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(113031049)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 21 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 21)

				if (21 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 21)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031049", "story_v_out_113031.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031049", "story_v_out_113031.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_113031", "113031049", "story_v_out_113031.awb")

						arg_198_1:RecordAudio("113031049", var_201_11)
						arg_198_1:RecordAudio("113031049", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_113031", "113031049", "story_v_out_113031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_113031", "113031049", "story_v_out_113031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play113031050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 113031050
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play113031051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1038ui_story"]) and arg_202_1.var_.characterEffect1038ui_story == nil then
				arg_202_1.var_.characterEffect1038ui_story = arg_202_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1038ui_story"]) then
				if arg_202_1.var_.characterEffect1038ui_story and not isNil(arg_202_1.actors_["1038ui_story"]) then
					arg_202_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1038ui_story"]) and arg_202_1.var_.characterEffect1038ui_story then
				arg_202_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_205_1 = arg_202_1.actors_["1041ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1041ui_story == nil then
				arg_202_1.var_.characterEffect1041ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1041ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1041ui_story then
				arg_202_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_205_4 = 0
			local var_205_5 = 0.05

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(113031050)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 2 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 2)

				if (2 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 2)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031050", "story_v_out_113031.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031050", "story_v_out_113031.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_113031", "113031050", "story_v_out_113031.awb")

						arg_202_1:RecordAudio("113031050", var_205_11)
						arg_202_1:RecordAudio("113031050", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_113031", "113031050", "story_v_out_113031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_113031", "113031050", "story_v_out_113031.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play113031051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 113031051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play113031052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1041ui_story = arg_206_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).z)
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles = arg_206_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1041ui_story"].transform.position).z)
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1041ui_story"].transform.localEulerAngles = arg_206_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1038ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1038ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 then
				var_209_1.localPosition = Vector3.New(0, 100, 0)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			local var_209_3 = 0
			local var_209_4 = 0.45

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_3 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_5 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(113031051).content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 18 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 18)

				if (18 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 18)) > 0 and var_209_4 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_3 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_3
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_8 = math.max(var_209_4, arg_206_1.talkMaxDuration)

			if var_209_3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_3 + var_209_8 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_3) / var_209_8

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_3 + var_209_8 and arg_206_1.time_ < var_209_3 + var_209_8 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play113031052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 113031052
		arg_210_1.duration_ = 6.07

		local var_210_0 = {
			ja = 5.133,
			ko = 5.333,
			zh = 6.066,
			en = 5.766
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
				arg_210_0:Play113031053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = arg_210_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_213_1 = arg_210_1.actors_["1084ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_213_4 = 0
			local var_213_5 = 0.55

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(113031052)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 22 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 22)

				if (22 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 22)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031052", "story_v_out_113031.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031052", "story_v_out_113031.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_113031", "113031052", "story_v_out_113031.awb")

						arg_210_1:RecordAudio("113031052", var_213_11)
						arg_210_1:RecordAudio("113031052", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_113031", "113031052", "story_v_out_113031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_113031", "113031052", "story_v_out_113031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play113031053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 113031053
		arg_214_1.duration_ = 0.2

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"

			SetActive(arg_214_1.choicesGo_, true)

			for iter_215_0, iter_215_1 in ipairs(arg_214_1.choices_) do
				SetActive(iter_215_1.go, iter_215_0 <= 2)
			end

			arg_214_1.choices_[1].txt.text = arg_214_1:FormatText(StoryChoiceCfg[186].name)
			arg_214_1.choices_[2].txt.text = arg_214_1:FormatText(StoryChoiceCfg[187].name)
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play113031054(arg_214_1)
			end

			if arg_216_0 == 2 then
				arg_214_0:Play113031054(arg_214_1)
			end

			arg_214_1:RecordChoiceLog(113031053, 186, 187)
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = arg_214_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) then
				if arg_214_1.var_.characterEffect1084ui_story and not isNil(arg_214_1.actors_["1084ui_story"]) then
					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) and arg_214_1.var_.characterEffect1084ui_story then
				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play113031054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 113031054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play113031055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.45

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(113031054).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 18 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 18)

				if (18 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 18)) > 0 and var_221_0 < var_221_3 then
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
	Play113031055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 113031055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play113031056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(113031055).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 20)

				if (20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 20)) > 0 and var_225_0 < var_225_3 then
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
	Play113031056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 113031056
		arg_226_1.duration_ = 6.03

		local var_226_0 = {
			ja = 2.8,
			ko = 5.366,
			zh = 4.666,
			en = 6.033
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
				arg_226_0:Play113031057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = arg_226_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1042ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1042ui_story = var_229_1.localPosition
			end

			local var_229_2 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 then
				var_229_1.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_226_1.time_ - 0) / var_229_2)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 then
				var_229_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_229_3 = arg_226_1.actors_["1042ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect1042ui_story == nil then
				arg_226_1.var_.characterEffect1042ui_story = var_229_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_4 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 and not isNil(var_229_3) then
				if arg_226_1.var_.characterEffect1042ui_story and not isNil(var_229_3) then
					arg_226_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect1042ui_story then
				arg_226_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_229_6 = 0
			local var_229_7 = 0.55

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(113031056)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 22 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 22)

				if (22 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 22)) > 0 and var_229_7 < var_229_11 then
					arg_226_1.talkMaxDuration = var_229_11

					if var_229_11 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031056", "story_v_out_113031.awb") ~= 0 then
					local var_229_12 = manager.audio:GetVoiceLength("story_v_out_113031", "113031056", "story_v_out_113031.awb") / 1000

					if var_229_12 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_6
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_113031", "113031056", "story_v_out_113031.awb")

						arg_226_1:RecordAudio("113031056", var_229_13)
						arg_226_1:RecordAudio("113031056", var_229_13)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_113031", "113031056", "story_v_out_113031.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_113031", "113031056", "story_v_out_113031.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play113031057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 113031057
		arg_230_1.duration_ = 6.13

		local var_230_0 = {
			ja = 6.133,
			ko = 2.266,
			zh = 2.9,
			en = 2.366
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
				arg_230_0:Play113031058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_233_0 = 0
			local var_233_1 = 0.275

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_2 = arg_230_1:GetWordFromCfg(113031057)
				local var_233_3 = arg_230_1:FormatText(var_233_2.content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 11 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 11)

				if (11 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 11)) > 0 and var_233_1 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031057", "story_v_out_113031.awb") ~= 0 then
					local var_233_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031057", "story_v_out_113031.awb") / 1000

					if var_233_6 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_0
					end

					if var_233_2.prefab_name ~= "" and arg_230_1.actors_[var_233_2.prefab_name] ~= nil then
						local var_233_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_2.prefab_name].transform, "story_v_out_113031", "113031057", "story_v_out_113031.awb")

						arg_230_1:RecordAudio("113031057", var_233_7)
						arg_230_1:RecordAudio("113031057", var_233_7)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_113031", "113031057", "story_v_out_113031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_113031", "113031057", "story_v_out_113031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play113031058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 113031058
		arg_234_1.duration_ = 6.33

		local var_234_0 = {
			ja = 6.166,
			ko = 5.6,
			zh = 4.866,
			en = 6.333
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
				arg_234_0:Play113031059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1042ui_story"]) and arg_234_1.var_.characterEffect1042ui_story == nil then
				arg_234_1.var_.characterEffect1042ui_story = arg_234_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1042ui_story"]) then
				if arg_234_1.var_.characterEffect1042ui_story and not isNil(arg_234_1.actors_["1042ui_story"]) then
					arg_234_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1042ui_story"]) and arg_234_1.var_.characterEffect1042ui_story then
				arg_234_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_237_1 = arg_234_1.actors_["1041ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1041ui_story = var_237_1.localPosition
			end

			local var_237_2 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 then
				var_237_1.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_234_1.time_ - 0) / var_237_2)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 then
				var_237_1.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_237_3 = arg_234_1.actors_["1041ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1041ui_story == nil then
				arg_234_1.var_.characterEffect1041ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect1041ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1041ui_story then
				arg_234_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_237_6 = 0
			local var_237_7 = 0.725

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(113031058)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 29 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 29)

				if (29 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 29)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031058", "story_v_out_113031.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_113031", "113031058", "story_v_out_113031.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_113031", "113031058", "story_v_out_113031.awb")

						arg_234_1:RecordAudio("113031058", var_237_13)
						arg_234_1:RecordAudio("113031058", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_113031", "113031058", "story_v_out_113031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_113031", "113031058", "story_v_out_113031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play113031059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 113031059
		arg_238_1.duration_ = 2.03

		local var_238_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
			arg_238_1.auto_ = false
		end

		function arg_238_1.playNext_(arg_240_0)
			arg_238_1.onStoryFinished_()
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_241_0 = 0
			local var_241_1 = 0.175

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_2 = arg_238_1:GetWordFromCfg(113031059)
				local var_241_3 = arg_238_1:FormatText(var_241_2.content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 7 <= 0 and var_241_1 or var_241_1 * (utf8.len(var_241_3) / 7)

				if (7 <= 0 and var_241_1 or var_241_1 * (utf8.len(var_241_3) / 7)) > 0 and var_241_1 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031059", "story_v_out_113031.awb") ~= 0 then
					local var_241_6 = manager.audio:GetVoiceLength("story_v_out_113031", "113031059", "story_v_out_113031.awb") / 1000

					if var_241_6 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_0
					end

					if var_241_2.prefab_name ~= "" and arg_238_1.actors_[var_241_2.prefab_name] ~= nil then
						local var_241_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_2.prefab_name].transform, "story_v_out_113031", "113031059", "story_v_out_113031.awb")

						arg_238_1:RecordAudio("113031059", var_241_7)
						arg_238_1:RecordAudio("113031059", var_241_7)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_113031", "113031059", "story_v_out_113031.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_113031", "113031059", "story_v_out_113031.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_8 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_8 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_8

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_8 and arg_238_1.time_ < var_241_0 + var_241_8 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_113031.awb"
	}
}
