return {
	Play120141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120141001
		arg_1_1.duration_ = 9.47

		local var_1_0 = {
			zh = 9.033,
			ja = 9.466
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
				arg_1_0:Play120141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J04f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J04f")
				var_4_0.name = "J04f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J04f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J04f

				arg_1_1.bgs_.J04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J04f" then
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

			local var_4_8 = "1071ui_story"

			if arg_1_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1071ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1071ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.05, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1071ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1071ui_story == nil then
				arg_1_1.var_.characterEffect1071ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1071ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1071ui_story then
				arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
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

			if 0.566666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.566666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_24 = 0.625

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(120141001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 25 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 25)

				if (25 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 25)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141001", "story_v_out_120141.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_120141", "120141001", "story_v_out_120141.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_120141", "120141001", "story_v_out_120141.awb")

						arg_1_1:RecordAudio("120141001", var_4_31)
						arg_1_1:RecordAudio("120141001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120141", "120141001", "story_v_out_120141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120141", "120141001", "story_v_out_120141.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120141002
		arg_9_1.duration_ = 5.6

		local var_9_0 = {
			zh = 5.233,
			ja = 5.6
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
				arg_9_0:Play120141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_0 = 0
			local var_12_1 = 0.575

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(120141002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 23 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 23)

				if (23 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 23)) > 0 and var_12_1 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141002", "story_v_out_120141.awb") ~= 0 then
					local var_12_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141002", "story_v_out_120141.awb") / 1000

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end

					if var_12_2.prefab_name ~= "" and arg_9_1.actors_[var_12_2.prefab_name] ~= nil then
						local var_12_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_2.prefab_name].transform, "story_v_out_120141", "120141002", "story_v_out_120141.awb")

						arg_9_1:RecordAudio("120141002", var_12_7)
						arg_9_1:RecordAudio("120141002", var_12_7)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120141", "120141002", "story_v_out_120141.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120141", "120141002", "story_v_out_120141.awb")
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
	Play120141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) and arg_13_1.var_.characterEffect1071ui_story == nil then
				arg_13_1.var_.characterEffect1071ui_story = arg_13_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) then
				if arg_13_1.var_.characterEffect1071ui_story and not isNil(arg_13_1.actors_["1071ui_story"]) then
					arg_13_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1071ui_story"]) and arg_13_1.var_.characterEffect1071ui_story then
				arg_13_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.825

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(120141003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 33 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 33)

				if (33 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 33)) > 0 and var_16_2 < var_16_5 then
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
	Play120141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120141004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1071ui_story = arg_17_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).z)
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles = arg_17_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).z)
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles = arg_17_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_20_1 = 0
			local var_20_2 = 0.55

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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(120141004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 22 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 22)

				if (22 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 22)) > 0 and var_20_2 < var_20_5 then
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

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play120141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120141005
		arg_21_1.duration_ = 6.23

		local var_21_0 = {
			zh = 6.233,
			ja = 4.533
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
				arg_21_0:Play120141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1075ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1075ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1075ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1075ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1075ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1075ui_story == nil then
				arg_21_1.var_.characterEffect1075ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1075ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1075ui_story then
				arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_24_6 = arg_21_1.actors_["1075ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1075ui_story = var_24_6.localPosition
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_6.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_21_1.time_ - 0) / var_24_7)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_6.localPosition = Vector3.New(0, -1.055, -6.16)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles
			end

			local var_24_8 = 0
			local var_24_9 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(120141005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 31 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 31)

				if (31 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 31)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141005", "story_v_out_120141.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_120141", "120141005", "story_v_out_120141.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_120141", "120141005", "story_v_out_120141.awb")

						arg_21_1:RecordAudio("120141005", var_24_15)
						arg_21_1:RecordAudio("120141005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120141", "120141005", "story_v_out_120141.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120141", "120141005", "story_v_out_120141.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play120141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120141006
		arg_25_1.duration_ = 11.03

		local var_25_0 = {
			zh = 4.833,
			ja = 11.033
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
				arg_25_0:Play120141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "10044ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10044ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["10044ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["10044ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["10044ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["10044ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10044ui_story == nil then
				arg_25_1.var_.characterEffect10044ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect10044ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10044ui_story then
				arg_25_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_28_6 = arg_25_1.actors_["10044ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10044ui_story = var_28_6.localPosition
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_6.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_25_1.time_ - 0) / var_28_7)
				var_28_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_6.position).x, (manager.ui.mainCamera.transform.position - var_28_6.position).y, (manager.ui.mainCamera.transform.position - var_28_6.position).z)
				var_28_6.localEulerAngles.z = 0
				var_28_6.localEulerAngles.x = 0
				var_28_6.localEulerAngles = var_28_6.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_6.localPosition = Vector3.New(0, -0.72, -6.3)
				var_28_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_6.position).x, (manager.ui.mainCamera.transform.position - var_28_6.position).y, (manager.ui.mainCamera.transform.position - var_28_6.position).z)
				var_28_6.localEulerAngles.z = 0
				var_28_6.localEulerAngles.x = 0
				var_28_6.localEulerAngles = var_28_6.localEulerAngles
			end

			local var_28_8 = arg_25_1.actors_["1075ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1075ui_story = var_28_8.localPosition
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_9)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0, 100, 0)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_28_10 = 0
			local var_28_11 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:GetWordFromCfg(120141006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 13 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 13)

				if (13 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 13)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141006", "story_v_out_120141.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_120141", "120141006", "story_v_out_120141.awb") / 1000

					if var_28_16 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_10
					end

					if var_28_12.prefab_name ~= "" and arg_25_1.actors_[var_28_12.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_12.prefab_name].transform, "story_v_out_120141", "120141006", "story_v_out_120141.awb")

						arg_25_1:RecordAudio("120141006", var_28_17)
						arg_25_1:RecordAudio("120141006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120141", "120141006", "story_v_out_120141.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120141", "120141006", "story_v_out_120141.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_18 and arg_25_1.time_ < var_28_10 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
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
	Play120141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120141007
		arg_29_1.duration_ = 6.2

		local var_29_0 = {
			zh = 4.933,
			ja = 6.2
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
				arg_29_0:Play120141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10044ui_story = arg_29_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).z)
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles = arg_29_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10044ui_story"].transform.position).z)
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10044ui_story"].transform.localEulerAngles = arg_29_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_32_1 = 0
			local var_32_2 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(120141007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 20 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 20)

				if (20 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 20)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141007", "story_v_out_120141.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_120141", "120141007", "story_v_out_120141.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_120141", "120141007", "story_v_out_120141.awb")

						arg_29_1:RecordAudio("120141007", var_32_8)
						arg_29_1:RecordAudio("120141007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120141", "120141007", "story_v_out_120141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120141", "120141007", "story_v_out_120141.awb")
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

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play120141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120141008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play120141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.925

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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(120141008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 37 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 37)

				if (37 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 37)) > 0 and var_36_0 < var_36_3 then
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
	Play120141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120141009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_0 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				local var_40_1 = Color.New(0.9245283, 0.4055395, 0.1700783)

				var_40_1.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.mask_.color = var_40_1
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				local var_40_2 = Color.New(0.9245283, 0.4055395, 0.1700783)

				arg_37_1.mask_.enabled = false
				var_40_2.a = 0
				arg_37_1.mask_.color = var_40_2
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_lingguang03", "")
			end

			local var_40_4 = manager.ui.mainCamera.transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_4.localPosition
			end

			local var_40_5 = 1

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 then
				local var_40_6, var_40_7 = math.modf((arg_37_1.time_ - 0) / 0.066)

				var_40_4.localPosition = Vector3.New(var_40_7 * 0.13, var_40_7 * 0.13, var_40_7 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 then
				var_40_4.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_8 = 0
			local var_40_9 = 0.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(120141009).content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 31 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_10) / 31)

				if (31 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_10) / 31)) > 0 and var_40_9 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_13 and arg_37_1.time_ < var_40_8 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120141010
		arg_41_1.duration_ = 1.1

		local var_41_0 = {
			zh = 1.066,
			ja = 1.1
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
				arg_41_0:Play120141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_44_0 = 0.6

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				local var_44_1, var_44_2 = math.modf((arg_41_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_44_2 * 0.13, var_44_2 * 0.13, var_44_2 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				manager.ui.mainCamera.transform.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_3 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_3 + 0.6 and arg_41_1.time_ < var_44_3 + 0.6 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_4 = 0
			local var_44_5 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_6 = arg_41_1:GetWordFromCfg(120141010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 3 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 3)

				if (3 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 3)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141010", "story_v_out_120141.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141010", "story_v_out_120141.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_120141", "120141010", "story_v_out_120141.awb")

						arg_41_1:RecordAudio("120141010", var_44_11)
						arg_41_1:RecordAudio("120141010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120141", "120141010", "story_v_out_120141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120141", "120141010", "story_v_out_120141.awb")
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

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120141011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10044ui_story = arg_45_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).z)
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles = arg_45_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10044ui_story"].transform.position).z)
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10044ui_story"].transform.localEulerAngles = arg_45_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_48_1 = 0
			local var_48_2 = 0.95

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(120141011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 38 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 38)

				if (38 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 38)) > 0 and var_48_2 < var_48_5 then
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

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play120141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120141012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play120141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_52_0 = 0.75

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				local var_52_1, var_52_2 = math.modf((arg_49_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_52_2 * 0.13, var_52_2 * 0.13, var_52_2 * 0.13) + arg_49_1.var_.shakeOldPos
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				manager.ui.mainCamera.transform.localPosition = arg_49_1.var_.shakeOldPos
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword03", "")
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_4 + 0.75 and arg_49_1.time_ < var_52_4 + 0.75 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_5 = 0
			local var_52_6 = 0.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(120141012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 3 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 3)

				if (3 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 3)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120141013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(120141013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 51)

				if (51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 51)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120141014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play120141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_lingguang04", "")
			end

			local var_60_1 = 0
			local var_60_2 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(120141014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 32 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 32)

				if (32 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 32)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play120141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120141015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.8

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

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(120141015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 32 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 32)

				if (32 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 32)) > 0 and var_64_0 < var_64_3 then
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
	Play120141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120141016
		arg_65_1.duration_ = 4.23

		local var_65_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_65_0:Play120141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10044ui_story = arg_65_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).z)
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles = arg_65_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, -0.72, -6.3)
				arg_65_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10044ui_story"].transform.position).z)
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10044ui_story"].transform.localEulerAngles = arg_65_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10044ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10044ui_story == nil then
				arg_65_1.var_.characterEffect10044ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10044ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10044ui_story then
				arg_65_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_68_4 = 0
			local var_68_5 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(120141016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)

				if (12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141016", "story_v_out_120141.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141016", "story_v_out_120141.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_120141", "120141016", "story_v_out_120141.awb")

						arg_65_1:RecordAudio("120141016", var_68_11)
						arg_65_1:RecordAudio("120141016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120141", "120141016", "story_v_out_120141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120141", "120141016", "story_v_out_120141.awb")
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

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play120141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120141017
		arg_69_1.duration_ = 4.48

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.STblack == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_72_0.name = "STblack"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.STblack = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.STblack

				arg_69_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = arg_69_1.actors_["10044ui_story"].transform

			if 1.966 < arg_69_1.time_ and arg_69_1.time_ <= 1.966 + arg_72_0 then
				arg_69_1.var_.moveOldPos10044ui_story = var_72_4.localPosition
			end

			local var_72_5 = 0.001

			if 1.966 <= arg_69_1.time_ and arg_69_1.time_ < 1.966 + var_72_5 then
				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 1.966) / var_72_5)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			if arg_69_1.time_ >= 1.966 + var_72_5 and arg_69_1.time_ < 1.966 + var_72_5 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0, 100, 0)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			local var_72_6 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_7 = 2

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = Color.New(0, 0, 0)

				var_72_8.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_6) / var_72_7)
				arg_69_1.mask_.color = var_72_8
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				local var_72_9 = Color.New(0, 0, 0)

				var_72_9.a = 1
				arg_69_1.mask_.color = var_72_9
			end

			local var_72_10 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_11 = 0.5

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 then
				local var_72_12 = Color.New(0, 0, 0)

				var_72_12.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_10) / var_72_11)
				arg_69_1.mask_.color = var_72_12
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 then
				local var_72_13 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_13.a = 0
				arg_69_1.mask_.color = var_72_13
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.fswbg_:SetActive(true)
				arg_69_1.dialog_:SetActive(false)

				arg_69_1.fswtw_.percent = 0
				arg_69_1.fswt_.text = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(120141017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.fswt_)

				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_69_1.fswtw_:SetDirty()

				arg_69_1.typewritterCharCountI18N = 0

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_14 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.var_.oldValueTypewriter = arg_69_1.fswtw_.percent

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_15 = 37
			local var_72_16 = 2.46666666666667
			local var_72_17, var_72_18 = arg_69_1:GetPercentByPara(arg_69_1:FormatText(arg_69_1:GetWordFromCfg(120141017).content), 1)

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				local var_72_19 = var_72_15 <= 0 and var_72_16 or var_72_16 * ((var_72_18 - arg_69_1.typewritterCharCountI18N) / var_72_15)

				if (var_72_15 <= 0 and var_72_16 or var_72_16 * ((var_72_18 - arg_69_1.typewritterCharCountI18N) / var_72_15)) > 0 and var_72_16 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_14
					end
				end
			end

			local var_72_20 = math.max(2.46666666666667, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_20 then
				arg_69_1.fswtw_.percent = Mathf.Lerp(arg_69_1.var_.oldValueTypewriter, var_72_17, (arg_69_1.time_ - var_72_14) / var_72_20)
				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_69_1.fswtw_:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_20 and arg_69_1.time_ < var_72_14 + var_72_20 + arg_72_0 then
				arg_69_1.fswtw_.percent = var_72_17

				arg_69_1.fswtw_:SetDirty()
				arg_69_1:ShowNextGo(true)

				arg_69_1.typewritterCharCountI18N = var_72_18
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_21 = arg_69_1.fswbg_.transform:Find("textbox/adapt/content") or arg_69_1.fswbg_.transform:Find("textbox/content")
				local var_72_22 = arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_72_23 = var_72_21:GetComponent("RectTransform")

				var_72_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_72_23.offsetMin = Vector2.New(0, 0)
				var_72_23.offsetMax = Vector2.New(0, 0)
			end

			local var_72_24 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_24 + 2.46666666666667 and arg_69_1.time_ < var_72_24 + 2.46666666666667 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play120141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120141018
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.fswbg_:SetActive(true)
				arg_73_1.dialog_:SetActive(false)

				arg_73_1.fswtw_.percent = 0
				arg_73_1.fswt_.text = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120141018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.fswt_)

				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_73_1.fswtw_:SetDirty()

				arg_73_1.typewritterCharCountI18N = 0

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.var_.oldValueTypewriter = arg_73_1.fswtw_.percent

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_1 = 2
			local var_76_2 = 0.133333333333333
			local var_76_3, var_76_4 = arg_73_1:GetPercentByPara(arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120141018).content), 1)

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				local var_76_5 = var_76_1 <= 0 and var_76_2 or var_76_2 * ((var_76_4 - arg_73_1.typewritterCharCountI18N) / var_76_1)

				if (var_76_1 <= 0 and var_76_2 or var_76_2 * ((var_76_4 - arg_73_1.typewritterCharCountI18N) / var_76_1)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_0
					end
				end
			end

			local var_76_6 = math.max(0.133333333333333, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_6 then
				arg_73_1.fswtw_.percent = Mathf.Lerp(arg_73_1.var_.oldValueTypewriter, var_76_3, (arg_73_1.time_ - var_76_0) / var_76_6)
				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_73_1.fswtw_:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_6 and arg_73_1.time_ < var_76_0 + var_76_6 + arg_76_0 then
				arg_73_1.fswtw_.percent = var_76_3

				arg_73_1.fswtw_:SetDirty()
				arg_73_1:ShowNextGo(true)

				arg_73_1.typewritterCharCountI18N = var_76_4
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_16", "se_story_16_droplet_loop02", "")
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120141019
		arg_77_1.duration_ = 7

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_0 = arg_77_1.bgs_.J04f

				arg_77_1.bgs_.J04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_1 = var_80_0:GetComponent("SpriteRenderer")

				if var_80_1 and var_80_1.sprite then
					local var_80_2 = 2 * (var_80_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_0.transform.localScale = Vector3.New(var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "J04f" then
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

			local var_80_4 = 2

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_4 then
				local var_80_5 = Color.New(0, 0, 0)

				var_80_5.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_3) / var_80_4)
				arg_77_1.mask_.color = var_80_5
			end

			if arg_77_1.time_ >= var_80_3 + var_80_4 and arg_77_1.time_ < var_80_3 + var_80_4 + arg_80_0 then
				local var_80_6 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_6.a = 0
				arg_77_1.mask_.color = var_80_6
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(false)
				arg_77_1.dialog_:SetActive(false)
				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_77_1:ShowNextGo(false)
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_7 = 2
			local var_80_8 = 0.725

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_9 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_9:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(120141019).content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_12 = 29 <= 0 and var_80_8 or var_80_8 * (utf8.len(var_80_10) / 29)

				if (29 <= 0 and var_80_8 or var_80_8 * (utf8.len(var_80_10) / 29)) > 0 and var_80_8 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12
					var_80_7 = var_80_7 + 0.3

					if var_80_12 + var_80_7 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_7
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = var_80_7 + 0.3
			local var_80_14 = math.max(var_80_8, arg_77_1.talkMaxDuration)

			if var_80_7 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_13 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_13) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_13 + var_80_14 and arg_77_1.time_ < var_80_13 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120141020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120141020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play120141021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.275

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

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(120141020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 51 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 51)

				if (51 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 51)) > 0 and var_86_0 < var_86_3 then
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
	Play120141021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120141021
		arg_87_1.duration_ = 2

		local var_87_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_87_0:Play120141022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1071ui_story = arg_87_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).z)
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles = arg_87_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_87_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1071ui_story"].transform.position).z)
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1071ui_story"].transform.localEulerAngles = arg_87_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_droplet_loop02", "")
			end

			local var_90_2 = arg_87_1.actors_["1071ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1071ui_story == nil then
				arg_87_1.var_.characterEffect1071ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.characterEffect1071ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1071ui_story then
				arg_87_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_90_5 = 0
			local var_90_6 = 0.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(120141021)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 4 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 4)

				if (4 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 4)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141021", "story_v_out_120141.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_120141", "120141021", "story_v_out_120141.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_120141", "120141021", "story_v_out_120141.awb")

						arg_87_1:RecordAudio("120141021", var_90_12)
						arg_87_1:RecordAudio("120141021", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_120141", "120141021", "story_v_out_120141.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_120141", "120141021", "story_v_out_120141.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play120141022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120141022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play120141023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1071ui_story = arg_91_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).z)
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles = arg_91_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1071ui_story"].transform.position).z)
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1071ui_story"].transform.localEulerAngles = arg_91_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_94_1 = 0
			local var_94_2 = 0.8

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(120141022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 32 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 32)

				if (32 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 32)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play120141023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 120141023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play120141024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1

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

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(120141023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 40 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 40)

				if (40 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 40)) > 0 and var_98_0 < var_98_3 then
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
	Play120141024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 120141024
		arg_99_1.duration_ = 4

		local var_99_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_99_0:Play120141025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10044ui_story = arg_99_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).z)
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles = arg_99_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, -0.72, -6.3)
				arg_99_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10044ui_story"].transform.position).z)
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10044ui_story"].transform.localEulerAngles = arg_99_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10044ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10044ui_story == nil then
				arg_99_1.var_.characterEffect10044ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10044ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10044ui_story then
				arg_99_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action6_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_102_4 = 0
			local var_102_5 = 0.35

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(120141024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 14 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 14)

				if (14 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 14)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141024", "story_v_out_120141.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141024", "story_v_out_120141.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_120141", "120141024", "story_v_out_120141.awb")

						arg_99_1:RecordAudio("120141024", var_102_11)
						arg_99_1:RecordAudio("120141024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_120141", "120141024", "story_v_out_120141.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_120141", "120141024", "story_v_out_120141.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play120141025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 120141025
		arg_103_1.duration_ = 9.27

		local var_103_0 = {
			zh = 9.266,
			ja = 8.9
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
				arg_103_0:Play120141026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_106_0 = 0
			local var_106_1 = 0.825

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(120141025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 33 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 33)

				if (33 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 33)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141025", "story_v_out_120141.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141025", "story_v_out_120141.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_out_120141", "120141025", "story_v_out_120141.awb")

						arg_103_1:RecordAudio("120141025", var_106_7)
						arg_103_1:RecordAudio("120141025", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_120141", "120141025", "story_v_out_120141.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_120141", "120141025", "story_v_out_120141.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play120141026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 120141026
		arg_107_1.duration_ = 2.63

		local var_107_0 = {
			zh = 2.633,
			ja = 2.466
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
				arg_107_0:Play120141027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_110_0 = 0
			local var_110_1 = 0.275

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(120141026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 11 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 11)

				if (11 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 11)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141026", "story_v_out_120141.awb") ~= 0 then
					local var_110_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141026", "story_v_out_120141.awb") / 1000

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end

					if var_110_2.prefab_name ~= "" and arg_107_1.actors_[var_110_2.prefab_name] ~= nil then
						local var_110_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_2.prefab_name].transform, "story_v_out_120141", "120141026", "story_v_out_120141.awb")

						arg_107_1:RecordAudio("120141026", var_110_7)
						arg_107_1:RecordAudio("120141026", var_110_7)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_120141", "120141026", "story_v_out_120141.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_120141", "120141026", "story_v_out_120141.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play120141027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 120141027
		arg_111_1.duration_ = 5.17

		local var_111_0 = {
			zh = 4.633,
			ja = 5.166
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
				arg_111_0:Play120141028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1075ui_story"]) and arg_111_1.var_.characterEffect1075ui_story == nil then
				arg_111_1.var_.characterEffect1075ui_story = arg_111_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1075ui_story"]) then
				if arg_111_1.var_.characterEffect1075ui_story and not isNil(arg_111_1.actors_["1075ui_story"]) then
					arg_111_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1075ui_story"]) and arg_111_1.var_.characterEffect1075ui_story then
				arg_111_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_114_2 = arg_111_1.actors_["10044ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect10044ui_story == nil then
				arg_111_1.var_.characterEffect10044ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect10044ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_3)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect10044ui_story then
				arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action7_1")
			end

			local var_114_4 = arg_111_1.actors_["10044ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10044ui_story = var_114_4.localPosition
			end

			local var_114_5 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_5)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0, 100, 0)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			local var_114_6 = arg_111_1.actors_["1075ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1075ui_story = var_114_6.localPosition
			end

			local var_114_7 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				var_114_6.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_111_1.time_ - 0) / var_114_7)
				var_114_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_6.position).x, (manager.ui.mainCamera.transform.position - var_114_6.position).y, (manager.ui.mainCamera.transform.position - var_114_6.position).z)
				var_114_6.localEulerAngles.z = 0
				var_114_6.localEulerAngles.x = 0
				var_114_6.localEulerAngles = var_114_6.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				var_114_6.localPosition = Vector3.New(0, -1.055, -6.16)
				var_114_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_6.position).x, (manager.ui.mainCamera.transform.position - var_114_6.position).y, (manager.ui.mainCamera.transform.position - var_114_6.position).z)
				var_114_6.localEulerAngles.z = 0
				var_114_6.localEulerAngles.x = 0
				var_114_6.localEulerAngles = var_114_6.localEulerAngles
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_114_8 = 0
			local var_114_9 = 0.175

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(120141027)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 7 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 7)

				if (7 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 7)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141027", "story_v_out_120141.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_120141", "120141027", "story_v_out_120141.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_120141", "120141027", "story_v_out_120141.awb")

						arg_111_1:RecordAudio("120141027", var_114_15)
						arg_111_1:RecordAudio("120141027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_120141", "120141027", "story_v_out_120141.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_120141", "120141027", "story_v_out_120141.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play120141028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 120141028
		arg_115_1.duration_ = 4

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play120141029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				local var_118_0 = arg_115_1.bgs_.STblack

				arg_115_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_1 = var_118_0:GetComponent("SpriteRenderer")

				if var_118_1 and var_118_1.sprite then
					local var_118_2 = 2 * (var_118_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_0.transform.localScale = Vector3.New(var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "STblack" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_3 = arg_115_1.actors_["1075ui_story"].transform

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				arg_115_1.var_.moveOldPos1075ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 2 <= arg_115_1.time_ and arg_115_1.time_ < 2 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 2) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 2 + var_118_4 and arg_115_1.time_ < 2 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, 100, 0)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = arg_115_1.actors_["10044ui_story"].transform

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				arg_115_1.var_.moveOldPos10044ui_story = var_118_5.localPosition
			end

			local var_118_6 = 0.001

			if 2 <= arg_115_1.time_ and arg_115_1.time_ < 2 + var_118_6 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 2) / var_118_6)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			if arg_115_1.time_ >= 2 + var_118_6 and arg_115_1.time_ < 2 + var_118_6 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, 100, 0)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			local var_118_7 = 1

			if 1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_8 = 1

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 then
				local var_118_9 = Color.New(1, 1, 1)

				var_118_9.a = Mathf.Lerp(0, 1, (arg_115_1.time_ - var_118_7) / var_118_8)
				arg_115_1.mask_.color = var_118_9
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 then
				local var_118_10 = Color.New(1, 1, 1)

				var_118_10.a = 1
				arg_115_1.mask_.color = var_118_10
			end

			local var_118_11 = 2

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_12 = 2

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_12 then
				local var_118_13 = Color.New(1, 1, 1)

				var_118_13.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_11) / var_118_12)
				arg_115_1.mask_.color = var_118_13
			end

			if arg_115_1.time_ >= var_118_11 + var_118_12 and arg_115_1.time_ < var_118_11 + var_118_12 + arg_118_0 then
				local var_118_14 = Color.New(1, 1, 1)

				arg_115_1.mask_.enabled = false
				var_118_14.a = 0
				arg_115_1.mask_.color = var_118_14
			end

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(true)
				arg_115_1.dialog_:SetActive(false)

				arg_115_1.fswtw_.percent = 0
				arg_115_1.fswt_.text = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(120141028).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.fswt_)

				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_115_1.fswtw_:SetDirty()

				arg_115_1.typewritterCharCountI18N = 0

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_15 = 2.01666666666667

			if 2.01666666666667 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_16 = 2
			local var_118_17 = 0.133333333333333
			local var_118_18, var_118_19 = arg_115_1:GetPercentByPara(arg_115_1:FormatText(arg_115_1:GetWordFromCfg(120141028).content), 1)

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_20 = var_118_16 <= 0 and var_118_17 or var_118_17 * ((var_118_19 - arg_115_1.typewritterCharCountI18N) / var_118_16)

				if (var_118_16 <= 0 and var_118_17 or var_118_17 * ((var_118_19 - arg_115_1.typewritterCharCountI18N) / var_118_16)) > 0 and var_118_17 < var_118_20 then
					arg_115_1.talkMaxDuration = var_118_20

					if var_118_20 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_15
					end
				end
			end

			local var_118_21 = math.max(0.133333333333333, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_21 then
				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_18, (arg_115_1.time_ - var_118_15) / var_118_21)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_21 and arg_115_1.time_ < var_118_15 + var_118_21 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_18

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_19
			end

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				local var_118_22 = arg_115_1.fswbg_.transform:Find("textbox/adapt/content") or arg_115_1.fswbg_.transform:Find("textbox/content")
				local var_118_23 = arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_118_24 = var_118_22:GetComponent("RectTransform")

				var_118_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_118_24.offsetMin = Vector2.New(0, 0)
				var_118_24.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play120141029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 120141029
		arg_119_1.duration_ = 1.15

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play120141030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.fswbg_:SetActive(true)
				arg_119_1.dialog_:SetActive(false)

				arg_119_1.fswtw_.percent = 0
				arg_119_1.fswt_.text = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(120141029).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.fswt_)

				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_119_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_119_1.fswtw_:SetDirty()

				arg_119_1.typewritterCharCountI18N = 0

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.var_.oldValueTypewriter = arg_119_1.fswtw_.percent

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_1 = 17
			local var_122_2 = 1.13333333333333
			local var_122_3, var_122_4 = arg_119_1:GetPercentByPara(arg_119_1:FormatText(arg_119_1:GetWordFromCfg(120141029).content), 1)

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				local var_122_5 = var_122_1 <= 0 and var_122_2 or var_122_2 * ((var_122_4 - arg_119_1.typewritterCharCountI18N) / var_122_1)

				if (var_122_1 <= 0 and var_122_2 or var_122_2 * ((var_122_4 - arg_119_1.typewritterCharCountI18N) / var_122_1)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_0
					end
				end
			end

			local var_122_6 = math.max(1.13333333333333, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_6 then
				arg_119_1.fswtw_.percent = Mathf.Lerp(arg_119_1.var_.oldValueTypewriter, var_122_3, (arg_119_1.time_ - var_122_0) / var_122_6)
				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_119_1.fswtw_:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_6 and arg_119_1.time_ < var_122_0 + var_122_6 + arg_122_0 then
				arg_119_1.fswtw_.percent = var_122_3

				arg_119_1.fswtw_:SetDirty()
				arg_119_1:ShowNextGo(true)

				arg_119_1.typewritterCharCountI18N = var_122_4
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play120141030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 120141030
		arg_123_1.duration_ = 1.75

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play120141031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.fswbg_:SetActive(true)
				arg_123_1.dialog_:SetActive(false)

				arg_123_1.fswtw_.percent = 0
				arg_123_1.fswt_.text = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(120141030).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.fswt_)

				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_123_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_123_1.fswtw_:SetDirty()

				arg_123_1.typewritterCharCountI18N = 0

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.var_.oldValueTypewriter = arg_123_1.fswtw_.percent

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_1 = 26
			local var_126_2 = 1.73333333333333
			local var_126_3, var_126_4 = arg_123_1:GetPercentByPara(arg_123_1:FormatText(arg_123_1:GetWordFromCfg(120141030).content), 1)

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				local var_126_5 = var_126_1 <= 0 and var_126_2 or var_126_2 * ((var_126_4 - arg_123_1.typewritterCharCountI18N) / var_126_1)

				if (var_126_1 <= 0 and var_126_2 or var_126_2 * ((var_126_4 - arg_123_1.typewritterCharCountI18N) / var_126_1)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end
			end

			local var_126_6 = math.max(1.73333333333333, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_6 then
				arg_123_1.fswtw_.percent = Mathf.Lerp(arg_123_1.var_.oldValueTypewriter, var_126_3, (arg_123_1.time_ - var_126_0) / var_126_6)
				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_123_1.fswtw_:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_6 and arg_123_1.time_ < var_126_0 + var_126_6 + arg_126_0 then
				arg_123_1.fswtw_.percent = var_126_3

				arg_123_1.fswtw_:SetDirty()
				arg_123_1:ShowNextGo(true)

				arg_123_1.typewritterCharCountI18N = var_126_4
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play120141031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 120141031
		arg_127_1.duration_ = 1

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play120141032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.fswbg_:SetActive(true)
				arg_127_1.dialog_:SetActive(false)

				arg_127_1.fswtw_.percent = 0
				arg_127_1.fswt_.text = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(120141031).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.fswt_)

				arg_127_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_127_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_127_1.fswtw_:SetDirty()

				arg_127_1.typewritterCharCountI18N = 0

				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.var_.oldValueTypewriter = arg_127_1.fswtw_.percent

				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_1 = 4
			local var_130_2 = 0.266666666666667
			local var_130_3, var_130_4 = arg_127_1:GetPercentByPara(arg_127_1:FormatText(arg_127_1:GetWordFromCfg(120141031).content), 1)

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				local var_130_5 = var_130_1 <= 0 and var_130_2 or var_130_2 * ((var_130_4 - arg_127_1.typewritterCharCountI18N) / var_130_1)

				if (var_130_1 <= 0 and var_130_2 or var_130_2 * ((var_130_4 - arg_127_1.typewritterCharCountI18N) / var_130_1)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_0
					end
				end
			end

			local var_130_6 = math.max(0.266666666666667, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_6 then
				arg_127_1.fswtw_.percent = Mathf.Lerp(arg_127_1.var_.oldValueTypewriter, var_130_3, (arg_127_1.time_ - var_130_0) / var_130_6)
				arg_127_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_127_1.fswtw_:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_6 and arg_127_1.time_ < var_130_0 + var_130_6 + arg_130_0 then
				arg_127_1.fswtw_.percent = var_130_3

				arg_127_1.fswtw_:SetDirty()
				arg_127_1:ShowNextGo(true)

				arg_127_1.typewritterCharCountI18N = var_130_4
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play120141032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 120141032
		arg_131_1.duration_ = 1.28

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play120141033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.fswbg_:SetActive(true)
				arg_131_1.dialog_:SetActive(false)

				arg_131_1.fswtw_.percent = 0
				arg_131_1.fswt_.text = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(120141032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.fswt_)

				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_131_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_131_1.fswtw_:SetDirty()

				arg_131_1.typewritterCharCountI18N = 0

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.var_.oldValueTypewriter = arg_131_1.fswtw_.percent

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_1 = 19
			local var_134_2 = 1.26666666666667
			local var_134_3, var_134_4 = arg_131_1:GetPercentByPara(arg_131_1:FormatText(arg_131_1:GetWordFromCfg(120141032).content), 1)

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				local var_134_5 = var_134_1 <= 0 and var_134_2 or var_134_2 * ((var_134_4 - arg_131_1.typewritterCharCountI18N) / var_134_1)

				if (var_134_1 <= 0 and var_134_2 or var_134_2 * ((var_134_4 - arg_131_1.typewritterCharCountI18N) / var_134_1)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_0
					end
				end
			end

			local var_134_6 = math.max(1.26666666666667, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_6 then
				arg_131_1.fswtw_.percent = Mathf.Lerp(arg_131_1.var_.oldValueTypewriter, var_134_3, (arg_131_1.time_ - var_134_0) / var_134_6)
				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_131_1.fswtw_:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_6 and arg_131_1.time_ < var_134_0 + var_134_6 + arg_134_0 then
				arg_131_1.fswtw_.percent = var_134_3

				arg_131_1.fswtw_:SetDirty()
				arg_131_1:ShowNextGo(true)

				arg_131_1.typewritterCharCountI18N = var_134_4
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play120141033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 120141033
		arg_135_1.duration_ = 7.17

		local var_135_0 = {
			zh = 6.7,
			ja = 7.166
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
				arg_135_0:Play120141034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				local var_138_0 = arg_135_1.bgs_.J04f

				arg_135_1.bgs_.J04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_1 = var_138_0:GetComponent("SpriteRenderer")

				if var_138_1 and var_138_1.sprite then
					local var_138_2 = 2 * (var_138_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_0.transform.localScale = Vector3.New(var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "J04f" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_3 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_4 = 2

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_4 then
				local var_138_5 = Color.New(1, 1, 1)

				var_138_5.a = Mathf.Lerp(0, 1, (arg_135_1.time_ - var_138_3) / var_138_4)
				arg_135_1.mask_.color = var_138_5
			end

			if arg_135_1.time_ >= var_138_3 + var_138_4 and arg_135_1.time_ < var_138_3 + var_138_4 + arg_138_0 then
				local var_138_6 = Color.New(1, 1, 1)

				var_138_6.a = 1
				arg_135_1.mask_.color = var_138_6
			end

			local var_138_7 = 2

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_8 = 2

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 then
				local var_138_9 = Color.New(1, 1, 1)

				var_138_9.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_7) / var_138_8)
				arg_135_1.mask_.color = var_138_9
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 then
				local var_138_10 = Color.New(1, 1, 1)

				arg_135_1.mask_.enabled = false
				var_138_10.a = 0
				arg_135_1.mask_.color = var_138_10
			end

			local var_138_11 = arg_135_1.actors_["1075ui_story"].transform

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				arg_135_1.var_.moveOldPos1075ui_story = var_138_11.localPosition
			end

			local var_138_12 = 0.001

			if 2 <= arg_135_1.time_ and arg_135_1.time_ < 2 + var_138_12 then
				var_138_11.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_135_1.time_ - 2) / var_138_12)
				var_138_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_11.position).x, (manager.ui.mainCamera.transform.position - var_138_11.position).y, (manager.ui.mainCamera.transform.position - var_138_11.position).z)
				var_138_11.localEulerAngles.z = 0
				var_138_11.localEulerAngles.x = 0
				var_138_11.localEulerAngles = var_138_11.localEulerAngles
			end

			if arg_135_1.time_ >= 2 + var_138_12 and arg_135_1.time_ < 2 + var_138_12 + arg_138_0 then
				var_138_11.localPosition = Vector3.New(0, -1.055, -6.16)
				var_138_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_11.position).x, (manager.ui.mainCamera.transform.position - var_138_11.position).y, (manager.ui.mainCamera.transform.position - var_138_11.position).z)
				var_138_11.localEulerAngles.z = 0
				var_138_11.localEulerAngles.x = 0
				var_138_11.localEulerAngles = var_138_11.localEulerAngles
			end

			local var_138_13 = arg_135_1.actors_["1075ui_story"]

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 and not isNil(var_138_13) and arg_135_1.var_.characterEffect1075ui_story == nil then
				arg_135_1.var_.characterEffect1075ui_story = var_138_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_14 = 0.2

			if 2 <= arg_135_1.time_ and arg_135_1.time_ < 2 + var_138_14 and not isNil(var_138_13) then
				if arg_135_1.var_.characterEffect1075ui_story and not isNil(var_138_13) then
					arg_135_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 2 + var_138_14 and arg_135_1.time_ < 2 + var_138_14 + arg_138_0 and not isNil(var_138_13) and arg_135_1.var_.characterEffect1075ui_story then
				arg_135_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				arg_135_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action7_2")
			end

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				arg_135_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.fswbg_:SetActive(false)
				arg_135_1.dialog_:SetActive(false)
				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_16 = 4
			local var_138_17 = 0.4

			if 4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_18 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_18:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_19 = arg_135_1:GetWordFromCfg(120141033)
				local var_138_20 = arg_135_1:FormatText(var_138_19.content)

				arg_135_1.text_.text = var_138_20

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_22 = 16 <= 0 and var_138_17 or var_138_17 * (utf8.len(var_138_20) / 16)

				if (16 <= 0 and var_138_17 or var_138_17 * (utf8.len(var_138_20) / 16)) > 0 and var_138_17 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22
					var_138_16 = var_138_16 + 0.3

					if var_138_22 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_16
					end
				end

				arg_135_1.text_.text = var_138_20
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141033", "story_v_out_120141.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141033", "story_v_out_120141.awb") / 1000

					if var_138_23 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_16
					end

					if var_138_19.prefab_name ~= "" and arg_135_1.actors_[var_138_19.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_19.prefab_name].transform, "story_v_out_120141", "120141033", "story_v_out_120141.awb")

						arg_135_1:RecordAudio("120141033", var_138_24)
						arg_135_1:RecordAudio("120141033", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_120141", "120141033", "story_v_out_120141.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_120141", "120141033", "story_v_out_120141.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = var_138_16 + 0.3
			local var_138_26 = math.max(var_138_17, arg_135_1.talkMaxDuration)

			if var_138_16 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_26 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_25) / var_138_26

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_25 + var_138_26 and arg_135_1.time_ < var_138_25 + var_138_26 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play120141034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120141034
		arg_141_1.duration_ = 5.13

		local var_141_0 = {
			zh = 5.133,
			ja = 4.5
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
				arg_141_0:Play120141035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_144_0 = 0
			local var_144_1 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(120141034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 21 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 21)

				if (21 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 21)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141034", "story_v_out_120141.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141034", "story_v_out_120141.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_out_120141", "120141034", "story_v_out_120141.awb")

						arg_141_1:RecordAudio("120141034", var_144_7)
						arg_141_1:RecordAudio("120141034", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120141", "120141034", "story_v_out_120141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120141", "120141034", "story_v_out_120141.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120141035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120141035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120141036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1075ui_story"]) and arg_145_1.var_.characterEffect1075ui_story == nil then
				arg_145_1.var_.characterEffect1075ui_story = arg_145_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1075ui_story"]) then
				if arg_145_1.var_.characterEffect1075ui_story and not isNil(arg_145_1.actors_["1075ui_story"]) then
					arg_145_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1075ui_story"]) and arg_145_1.var_.characterEffect1075ui_story then
				arg_145_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_148_1 = arg_145_1.actors_["1075ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1075ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = 0
			local var_148_4 = 0.6

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(120141035).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 24 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 24)

				if (24 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 24)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play120141036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120141036
		arg_149_1.duration_ = 1.13

		local var_149_0 = {
			zh = 1.066,
			ja = 1.133
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
				arg_149_0:Play120141037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.05

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(120141036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 2 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 2)

				if (2 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 2)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141036", "story_v_out_120141.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141036", "story_v_out_120141.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_120141", "120141036", "story_v_out_120141.awb")

						arg_149_1:RecordAudio("120141036", var_152_6)
						arg_149_1:RecordAudio("120141036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120141", "120141036", "story_v_out_120141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120141", "120141036", "story_v_out_120141.awb")
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
	Play120141037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120141037
		arg_153_1.duration_ = 7

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play120141038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.bgs_.XH0107 == nil then
				local var_156_0 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0107")
				var_156_0.name = "XH0107"
				var_156_0.transform.parent = arg_153_1.stage_.transform
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_.XH0107 = var_156_0
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				local var_156_1 = arg_153_1.bgs_.XH0107

				arg_153_1.bgs_.XH0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_156_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_2 = var_156_1:GetComponent("SpriteRenderer")

				if var_156_2 and var_156_2.sprite then
					local var_156_3 = 2 * (var_156_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_156_1.transform.localScale = Vector3.New(var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "XH0107" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_4 = arg_153_1.actors_["10044ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10044ui_story = var_156_4.localPosition
			end

			local var_156_5 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				var_156_4.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_5)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				var_156_4.localPosition = Vector3.New(0, 100, 0)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			local var_156_6 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_7 = 2

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_7 then
				local var_156_8 = Color.New(1, 1, 1)

				var_156_8.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_6) / var_156_7)
				arg_153_1.mask_.color = var_156_8
			end

			if arg_153_1.time_ >= var_156_6 + var_156_7 and arg_153_1.time_ < var_156_6 + var_156_7 + arg_156_0 then
				local var_156_9 = Color.New(1, 1, 1)

				arg_153_1.mask_.enabled = false
				var_156_9.a = 0
				arg_153_1.mask_.color = var_156_9
			end

			if 1.99933333333333 < arg_153_1.time_ and arg_153_1.time_ <= 1.99933333333333 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_lingguang05", "")
			end

			local var_156_11 = arg_153_1.bgs_.XH0107.transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPosXH0107 = var_156_11.localPosition
			end

			local var_156_12 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_12 then
				var_156_11.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosXH0107, Vector3.New(0, 1, 9.5), (arg_153_1.time_ - 0) / var_156_12)
			end

			if arg_153_1.time_ >= 0 + var_156_12 and arg_153_1.time_ < 0 + var_156_12 + arg_156_0 then
				var_156_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_156_13 = arg_153_1.bgs_.XH0107.transform

			if 0.0339999999999998 < arg_153_1.time_ and arg_153_1.time_ <= 0.0339999999999998 + arg_156_0 then
				arg_153_1.var_.moveOldPosXH0107 = var_156_13.localPosition
			end

			local var_156_14 = 4.5

			if 0.0339999999999998 <= arg_153_1.time_ and arg_153_1.time_ < 0.0339999999999998 + var_156_14 then
				var_156_13.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosXH0107, Vector3.New(0, 1, 10), (arg_153_1.time_ - 0.0339999999999998) / var_156_14)
			end

			if arg_153_1.time_ >= 0.0339999999999998 + var_156_14 and arg_153_1.time_ < 0.0339999999999998 + var_156_14 + arg_156_0 then
				var_156_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_156_15 = 2.99933333333333

			if 2.99933333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_15 + 1.53466666666667 and arg_153_1.time_ < var_156_15 + 1.53466666666667 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_16 = 1.99933333333333
			local var_156_17 = 1.4

			if 1.99933333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_18 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_18:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(120141037).content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 56 <= 0 and var_156_17 or var_156_17 * (utf8.len(var_156_19) / 56)

				if (56 <= 0 and var_156_17 or var_156_17 * (utf8.len(var_156_19) / 56)) > 0 and var_156_17 < var_156_21 then
					arg_153_1.talkMaxDuration = var_156_21
					var_156_16 = var_156_16 + 0.3

					if var_156_21 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_21 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = var_156_16 + 0.3
			local var_156_23 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_22 + var_156_23 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_22) / var_156_23

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_22 + var_156_23 and arg_153_1.time_ < var_156_22 + var_156_23 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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
				actorName = "XH0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play120141038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 120141038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play120141039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.025

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

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(120141038).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 41 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 41)

				if (41 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 41)) > 0 and var_162_0 < var_162_3 then
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
	Play120141039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 120141039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play120141040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.475

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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(120141039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 59 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 59)

				if (59 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 59)) > 0 and var_166_0 < var_166_3 then
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
	Play120141040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 120141040
		arg_167_1.duration_ = 2.7

		local var_167_0 = {
			zh = 2.333,
			ja = 2.7
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
				arg_167_0:Play120141041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(120141040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 6 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 6)

				if (6 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 6)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141040", "story_v_out_120141.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141040", "story_v_out_120141.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_120141", "120141040", "story_v_out_120141.awb")

						arg_167_1:RecordAudio("120141040", var_170_6)
						arg_167_1:RecordAudio("120141040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_120141", "120141040", "story_v_out_120141.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_120141", "120141040", "story_v_out_120141.awb")
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
	Play120141041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 120141041
		arg_171_1.duration_ = 5.8

		local var_171_0 = {
			zh = 5.633,
			ja = 5.8
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
				arg_171_0:Play120141042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(120141041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)

				if (24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141041", "story_v_out_120141.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141041", "story_v_out_120141.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_120141", "120141041", "story_v_out_120141.awb")

						arg_171_1:RecordAudio("120141041", var_174_6)
						arg_171_1:RecordAudio("120141041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_120141", "120141041", "story_v_out_120141.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_120141", "120141041", "story_v_out_120141.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play120141042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 120141042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play120141043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.075

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(120141042).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 43)

				if (43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 43)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play120141043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 120141043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play120141044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.875

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(120141043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 35 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 35)

				if (35 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 35)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play120141044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 120141044
		arg_183_1.duration_ = 1.7

		local var_183_0 = {
			zh = 1.7,
			ja = 1.1
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play120141045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.075

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(120141044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 3 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 3)

				if (3 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 3)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141044", "story_v_out_120141.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141044", "story_v_out_120141.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_120141", "120141044", "story_v_out_120141.awb")

						arg_183_1:RecordAudio("120141044", var_186_6)
						arg_183_1:RecordAudio("120141044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_120141", "120141044", "story_v_out_120141.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_120141", "120141044", "story_v_out_120141.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play120141045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 120141045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play120141046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:AudioAction("stop", "effect", "se_story_120_00", "se_story_120_00_sizzle", "")
			end

			local var_190_1 = 0
			local var_190_2 = 0.675

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(120141045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 27 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 27)

				if (27 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 27)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play120141046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 120141046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play120141047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.9

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(120141046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 36 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 36)

				if (36 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 36)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play120141047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 120141047
		arg_195_1.duration_ = 5.27

		local var_195_0 = {
			zh = 5.266,
			ja = 2.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play120141048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(120141047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 13)

				if (13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 13)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141047", "story_v_out_120141.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141047", "story_v_out_120141.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_120141", "120141047", "story_v_out_120141.awb")

						arg_195_1:RecordAudio("120141047", var_198_6)
						arg_195_1:RecordAudio("120141047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_120141", "120141047", "story_v_out_120141.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_120141", "120141047", "story_v_out_120141.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play120141048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 120141048
		arg_199_1.duration_ = 2

		local var_199_0 = {
			zh = 2,
			ja = 1.433
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play120141049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(120141048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 4 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 4)

				if (4 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 4)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141048", "story_v_out_120141.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141048", "story_v_out_120141.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_120141", "120141048", "story_v_out_120141.awb")

						arg_199_1:RecordAudio("120141048", var_202_6)
						arg_199_1:RecordAudio("120141048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_120141", "120141048", "story_v_out_120141.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_120141", "120141048", "story_v_out_120141.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play120141049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 120141049
		arg_203_1.duration_ = 4

		local var_203_0 = {
			zh = 4,
			ja = 3.566
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play120141050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.25

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(120141049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 10)

				if (10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 10)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141049", "story_v_out_120141.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141049", "story_v_out_120141.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_120141", "120141049", "story_v_out_120141.awb")

						arg_203_1:RecordAudio("120141049", var_206_6)
						arg_203_1:RecordAudio("120141049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_120141", "120141049", "story_v_out_120141.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_120141", "120141049", "story_v_out_120141.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play120141050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 120141050
		arg_207_1.duration_ = 3.07

		local var_207_0 = {
			zh = 2.2,
			ja = 3.066
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
				arg_207_0:Play120141051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.2

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(120141050)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 8 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 8)

				if (8 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 8)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141050", "story_v_out_120141.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141050", "story_v_out_120141.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_120141", "120141050", "story_v_out_120141.awb")

						arg_207_1:RecordAudio("120141050", var_210_6)
						arg_207_1:RecordAudio("120141050", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_120141", "120141050", "story_v_out_120141.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_120141", "120141050", "story_v_out_120141.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play120141051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 120141051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play120141052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.725

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(120141051).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 29 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 29)

				if (29 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 29)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play120141052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 120141052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play120141053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0.5 < arg_215_1.time_ and arg_215_1.time_ <= 0.5 + arg_218_0 then
				arg_215_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_218_0 = 0.6

			if 0.5 <= arg_215_1.time_ and arg_215_1.time_ < 0.5 + var_218_0 then
				local var_218_1, var_218_2 = math.modf((arg_215_1.time_ - 0.5) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_218_2 * 0.13, var_218_2 * 0.13, var_218_2 * 0.13) + arg_215_1.var_.shakeOldPos
			end

			if arg_215_1.time_ >= 0.5 + var_218_0 and arg_215_1.time_ < 0.5 + var_218_0 + arg_218_0 then
				manager.ui.mainCamera.transform.localPosition = arg_215_1.var_.shakeOldPos
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_lingguang06", "")
			end

			local var_218_4 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_4 + 1.1 and arg_215_1.time_ < var_218_4 + 1.1 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_5 = 0
			local var_218_6 = 1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(120141052).content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 40 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 40)

				if (40 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 40)) > 0 and var_218_6 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_10 and arg_215_1.time_ < var_218_5 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play120141053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 120141053
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play120141054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_0 = arg_219_1.bgs_.J04f

				arg_219_1.bgs_.J04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_1 = var_222_0:GetComponent("SpriteRenderer")

				if var_222_1 and var_222_1.sprite then
					local var_222_2 = 2 * (var_222_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_0.transform.localScale = Vector3.New(var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "J04f" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_3 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_4 = 2

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_4 then
				local var_222_5 = Color.New(0, 0, 0)

				var_222_5.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_3) / var_222_4)
				arg_219_1.mask_.color = var_222_5
			end

			if arg_219_1.time_ >= var_222_3 + var_222_4 and arg_219_1.time_ < var_222_3 + var_222_4 + arg_222_0 then
				local var_222_6 = Color.New(0, 0, 0)

				var_222_6.a = 1
				arg_219_1.mask_.color = var_222_6
			end

			local var_222_7 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_8 = 2

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_8 then
				local var_222_9 = Color.New(0, 0, 0)

				var_222_9.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_7) / var_222_8)
				arg_219_1.mask_.color = var_222_9
			end

			if arg_219_1.time_ >= var_222_7 + var_222_8 and arg_219_1.time_ < var_222_7 + var_222_8 + arg_222_0 then
				local var_222_10 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_10.a = 0
				arg_219_1.mask_.color = var_222_10
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_11 = 4
			local var_222_12 = 1

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_13 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_13:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(120141053).content)

				arg_219_1.text_.text = var_222_14

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_16 = 40 <= 0 and var_222_12 or var_222_12 * (utf8.len(var_222_14) / 40)

				if (40 <= 0 and var_222_12 or var_222_12 * (utf8.len(var_222_14) / 40)) > 0 and var_222_12 < var_222_16 then
					arg_219_1.talkMaxDuration = var_222_16
					var_222_11 = var_222_11 + 0.3

					if var_222_16 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_16 + var_222_11
					end
				end

				arg_219_1.text_.text = var_222_14
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_17 = var_222_11 + 0.3
			local var_222_18 = math.max(var_222_12, arg_219_1.talkMaxDuration)

			if var_222_11 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_17 + var_222_18 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_17) / var_222_18

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_17 + var_222_18 and arg_219_1.time_ < var_222_17 + var_222_18 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play120141054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120141054
		arg_225_1.duration_ = 6.87

		local var_225_0 = {
			zh = 2,
			ja = 6.866
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
				arg_225_0:Play120141055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if arg_225_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_228_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_225_1.stage_.transform)

				var_228_0.name = "1184ui_story"
				var_228_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1184ui_story"] = var_228_0

				local var_228_1 = var_228_0:GetComponentInChildren(typeof(CharacterEffect))

				var_228_1.enabled = true

				local var_228_2 = GameObjectTools.GetOrAddComponent(var_228_0, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(false)
				end

				arg_225_1:ShowWeapon(var_228_1.transform, false)

				arg_225_1.var_["1184ui_story" .. "Animator"] = var_228_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_225_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_225_1.var_["1184ui_story" .. "LipSync"] = var_228_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_228_3 = arg_225_1.actors_["1184ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1184ui_story = var_228_3.localPosition

				arg_225_1:ShowWeapon(arg_225_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, -0.97, -6)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["1184ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1184ui_story == nil then
				arg_225_1.var_.characterEffect1184ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect1184ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1184ui_story then
				arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_228_8 = 0
			local var_228_9 = 0.2

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
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

				local var_228_10 = arg_225_1:GetWordFromCfg(120141054)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 8 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 8)

				if (8 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 8)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141054", "story_v_out_120141.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_out_120141", "120141054", "story_v_out_120141.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_out_120141", "120141054", "story_v_out_120141.awb")

						arg_225_1:RecordAudio("120141054", var_228_15)
						arg_225_1:RecordAudio("120141054", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_120141", "120141054", "story_v_out_120141.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_120141", "120141054", "story_v_out_120141.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play120141055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120141055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play120141056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1184ui_story"]) and arg_229_1.var_.characterEffect1184ui_story == nil then
				arg_229_1.var_.characterEffect1184ui_story = arg_229_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1184ui_story"]) then
				if arg_229_1.var_.characterEffect1184ui_story and not isNil(arg_229_1.actors_["1184ui_story"]) then
					arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1184ui_story"]) and arg_229_1.var_.characterEffect1184ui_story then
				arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.425

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(120141055).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 17 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 17)

				if (17 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 17)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play120141056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120141056
		arg_233_1.duration_ = 5.27

		local var_233_0 = {
			zh = 5.266,
			ja = 5.2
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
				arg_233_0:Play120141057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if arg_233_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_236_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_233_1.stage_.transform)

				var_236_0.name = "10037ui_story"
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["10037ui_story"] = var_236_0

				local var_236_1 = var_236_0:GetComponentInChildren(typeof(CharacterEffect))

				var_236_1.enabled = true

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_1.transform, false)

				arg_233_1.var_["10037ui_story" .. "Animator"] = var_236_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_233_1.var_["10037ui_story" .. "LipSync"] = var_236_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_3 = arg_233_1.actors_["10037ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10037ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			local var_236_5 = arg_233_1.actors_["10037ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect10037ui_story == nil then
				arg_233_1.var_.characterEffect10037ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect10037ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect10037ui_story then
				arg_233_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_236_8 = arg_233_1.actors_["1184ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1184ui_story = var_236_8.localPosition
			end

			local var_236_9 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_9 then
				var_236_8.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_9)
				var_236_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_8.position).x, (manager.ui.mainCamera.transform.position - var_236_8.position).y, (manager.ui.mainCamera.transform.position - var_236_8.position).z)
				var_236_8.localEulerAngles.z = 0
				var_236_8.localEulerAngles.x = 0
				var_236_8.localEulerAngles = var_236_8.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_9 and arg_233_1.time_ < 0 + var_236_9 + arg_236_0 then
				var_236_8.localPosition = Vector3.New(0, 100, 0)
				var_236_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_8.position).x, (manager.ui.mainCamera.transform.position - var_236_8.position).y, (manager.ui.mainCamera.transform.position - var_236_8.position).z)
				var_236_8.localEulerAngles.z = 0
				var_236_8.localEulerAngles.x = 0
				var_236_8.localEulerAngles = var_236_8.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action2_1")
			end

			local var_236_10 = 0
			local var_236_11 = 0.325

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_12 = arg_233_1:GetWordFromCfg(120141056)
				local var_236_13 = arg_233_1:FormatText(var_236_12.content)

				arg_233_1.text_.text = var_236_13

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_15 = 13 <= 0 and var_236_11 or var_236_11 * (utf8.len(var_236_13) / 13)

				if (13 <= 0 and var_236_11 or var_236_11 * (utf8.len(var_236_13) / 13)) > 0 and var_236_11 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_10
					end
				end

				arg_233_1.text_.text = var_236_13
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141056", "story_v_out_120141.awb") ~= 0 then
					local var_236_16 = manager.audio:GetVoiceLength("story_v_out_120141", "120141056", "story_v_out_120141.awb") / 1000

					if var_236_16 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_10
					end

					if var_236_12.prefab_name ~= "" and arg_233_1.actors_[var_236_12.prefab_name] ~= nil then
						local var_236_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_12.prefab_name].transform, "story_v_out_120141", "120141056", "story_v_out_120141.awb")

						arg_233_1:RecordAudio("120141056", var_236_17)
						arg_233_1:RecordAudio("120141056", var_236_17)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_120141", "120141056", "story_v_out_120141.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_120141", "120141056", "story_v_out_120141.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_11, arg_233_1.talkMaxDuration)

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_10) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_10 + var_236_18 and arg_233_1.time_ < var_236_10 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play120141057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120141057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play120141058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10037ui_story"]) and arg_237_1.var_.characterEffect10037ui_story == nil then
				arg_237_1.var_.characterEffect10037ui_story = arg_237_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10037ui_story"]) then
				if arg_237_1.var_.characterEffect10037ui_story and not isNil(arg_237_1.actors_["10037ui_story"]) then
					arg_237_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10037ui_story"]) and arg_237_1.var_.characterEffect10037ui_story then
				arg_237_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 1.35

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(120141057).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 54 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 54)

				if (54 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 54)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play120141058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120141058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play120141059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10037ui_story = arg_241_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).z)
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles = arg_241_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10037ui_story"].transform.position).z)
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10037ui_story"].transform.localEulerAngles = arg_241_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_244_1 = 0
			local var_244_2 = 0.7

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(120141058).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 28 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 28)

				if (28 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 28)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play120141059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120141059
		arg_245_1.duration_ = 3.7

		local var_245_0 = {
			zh = 1.999999999999,
			ja = 3.7
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
				arg_245_0:Play120141060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_248_0 = arg_245_1.actors_["1075ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1075ui_story = var_248_0.localPosition
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_245_1.time_ - 0) / var_248_1)
				var_248_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_0.position).x, (manager.ui.mainCamera.transform.position - var_248_0.position).y, (manager.ui.mainCamera.transform.position - var_248_0.position).z)
				var_248_0.localEulerAngles.z = 0
				var_248_0.localEulerAngles.x = 0
				var_248_0.localEulerAngles = var_248_0.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_248_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_0.position).x, (manager.ui.mainCamera.transform.position - var_248_0.position).y, (manager.ui.mainCamera.transform.position - var_248_0.position).z)
				var_248_0.localEulerAngles.z = 0
				var_248_0.localEulerAngles.x = 0
				var_248_0.localEulerAngles = var_248_0.localEulerAngles
			end

			local var_248_2 = arg_245_1.actors_["1071ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1071ui_story = var_248_2.localPosition
			end

			local var_248_3 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 then
				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_245_1.time_ - 0) / var_248_3)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles
			end

			local var_248_4 = arg_245_1.actors_["1075ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1075ui_story == nil then
				arg_245_1.var_.characterEffect1075ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_5 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 and not isNil(var_248_4) then
				if arg_245_1.var_.characterEffect1075ui_story and not isNil(var_248_4) then
					arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1075ui_story then
				arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_248_7 = arg_245_1.actors_["1071ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.characterEffect1071ui_story == nil then
				arg_245_1.var_.characterEffect1071ui_story = var_248_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_8 = 0.0166666666666667

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_8 and not isNil(var_248_7) then
				if arg_245_1.var_.characterEffect1071ui_story and not isNil(var_248_7) then
					arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_8)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_8 and arg_245_1.time_ < 0 + var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.characterEffect1071ui_story then
				arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_248_9 = arg_245_1.actors_["1071ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1071ui_story == nil then
				arg_245_1.var_.characterEffect1071ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_10 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_10 and not isNil(var_248_9) then
				if arg_245_1.var_.characterEffect1071ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_10)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_10 and arg_245_1.time_ < 0 + var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1071ui_story then
				arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_248_11 = 0
			local var_248_12 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_11 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_13 = arg_245_1:GetWordFromCfg(120141059)
				local var_248_14 = arg_245_1:FormatText(var_248_13.content)

				arg_245_1.text_.text = var_248_14

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_16 = 5 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 5)

				if (5 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 5)) > 0 and var_248_12 < var_248_16 then
					arg_245_1.talkMaxDuration = var_248_16

					if var_248_16 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_16 + var_248_11
					end
				end

				arg_245_1.text_.text = var_248_14
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141059", "story_v_out_120141.awb") ~= 0 then
					local var_248_17 = manager.audio:GetVoiceLength("story_v_out_120141", "120141059", "story_v_out_120141.awb") / 1000

					if var_248_17 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_17 + var_248_11
					end

					if var_248_13.prefab_name ~= "" and arg_245_1.actors_[var_248_13.prefab_name] ~= nil then
						local var_248_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_13.prefab_name].transform, "story_v_out_120141", "120141059", "story_v_out_120141.awb")

						arg_245_1:RecordAudio("120141059", var_248_18)
						arg_245_1:RecordAudio("120141059", var_248_18)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120141", "120141059", "story_v_out_120141.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120141", "120141059", "story_v_out_120141.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_19 = math.max(var_248_12, arg_245_1.talkMaxDuration)

			if var_248_11 <= arg_245_1.time_ and arg_245_1.time_ < var_248_11 + var_248_19 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_11) / var_248_19

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_11 + var_248_19 and arg_245_1.time_ < var_248_11 + var_248_19 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play120141060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120141060
		arg_249_1.duration_ = 11.5

		local var_249_0 = {
			zh = 7.833,
			ja = 11.5
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
				arg_249_0:Play120141061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1075ui_story"]) and arg_249_1.var_.characterEffect1075ui_story == nil then
				arg_249_1.var_.characterEffect1075ui_story = arg_249_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1075ui_story"]) then
				if arg_249_1.var_.characterEffect1075ui_story and not isNil(arg_249_1.actors_["1075ui_story"]) then
					arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1075ui_story"]) and arg_249_1.var_.characterEffect1075ui_story then
				arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_252_1 = arg_249_1.actors_["1071ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1071ui_story == nil then
				arg_249_1.var_.characterEffect1071ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1071ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1071ui_story then
				arg_249_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_252_4 = 0
			local var_252_5 = 0.825

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(120141060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 33 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 33)

				if (33 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 33)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141060", "story_v_out_120141.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141060", "story_v_out_120141.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_120141", "120141060", "story_v_out_120141.awb")

						arg_249_1:RecordAudio("120141060", var_252_11)
						arg_249_1:RecordAudio("120141060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120141", "120141060", "story_v_out_120141.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120141", "120141060", "story_v_out_120141.awb")
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
	Play120141061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120141061
		arg_253_1.duration_ = 3.43

		local var_253_0 = {
			zh = 1.999999999999,
			ja = 3.433
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play120141062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1071ui_story = arg_253_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).z)
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles = arg_253_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1071ui_story"].transform.position).z)
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1071ui_story"].transform.localEulerAngles = arg_253_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1075ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1075ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			local var_256_3 = arg_253_1.actors_["10037ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10037ui_story = var_256_3.localPosition
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_3.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_253_1.time_ - 0) / var_256_4)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			local var_256_5 = arg_253_1.actors_["10037ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect10037ui_story == nil then
				arg_253_1.var_.characterEffect10037ui_story = var_256_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.characterEffect10037ui_story and not isNil(var_256_5) then
					arg_253_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect10037ui_story then
				arg_253_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_8 = 0
			local var_256_9 = 0.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(120141061)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 3 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 3)

				if (3 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 3)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141061", "story_v_out_120141.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_120141", "120141061", "story_v_out_120141.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_120141", "120141061", "story_v_out_120141.awb")

						arg_253_1:RecordAudio("120141061", var_256_15)
						arg_253_1:RecordAudio("120141061", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120141", "120141061", "story_v_out_120141.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120141", "120141061", "story_v_out_120141.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play120141062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120141062
		arg_257_1.duration_ = 6.33

		local var_257_0 = {
			zh = 5.266,
			ja = 6.333
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play120141063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_0 = 0
			local var_260_1 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(120141062)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 24 <= 0 and var_260_1 or var_260_1 * (utf8.len(var_260_3) / 24)

				if (24 <= 0 and var_260_1 or var_260_1 * (utf8.len(var_260_3) / 24)) > 0 and var_260_1 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141062", "story_v_out_120141.awb") ~= 0 then
					local var_260_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141062", "story_v_out_120141.awb") / 1000

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end

					if var_260_2.prefab_name ~= "" and arg_257_1.actors_[var_260_2.prefab_name] ~= nil then
						local var_260_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_2.prefab_name].transform, "story_v_out_120141", "120141062", "story_v_out_120141.awb")

						arg_257_1:RecordAudio("120141062", var_260_7)
						arg_257_1:RecordAudio("120141062", var_260_7)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120141", "120141062", "story_v_out_120141.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120141", "120141062", "story_v_out_120141.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120141063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120141063
		arg_261_1.duration_ = 14.73

		local var_261_0 = {
			zh = 13.966,
			ja = 14.733
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
				arg_261_0:Play120141064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action423")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_264_0 = 0
			local var_264_1 = 1.2

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(120141063)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 48 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 48)

				if (48 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 48)) > 0 and var_264_1 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141063", "story_v_out_120141.awb") ~= 0 then
					local var_264_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141063", "story_v_out_120141.awb") / 1000

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end

					if var_264_2.prefab_name ~= "" and arg_261_1.actors_[var_264_2.prefab_name] ~= nil then
						local var_264_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_2.prefab_name].transform, "story_v_out_120141", "120141063", "story_v_out_120141.awb")

						arg_261_1:RecordAudio("120141063", var_264_7)
						arg_261_1:RecordAudio("120141063", var_264_7)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120141", "120141063", "story_v_out_120141.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120141", "120141063", "story_v_out_120141.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120141064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120141064
		arg_265_1.duration_ = 23.53

		local var_265_0 = {
			zh = 5.066,
			ja = 23.533
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play120141065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(120141064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 21 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 21)

				if (21 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 21)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141064", "story_v_out_120141.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_120141", "120141064", "story_v_out_120141.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_120141", "120141064", "story_v_out_120141.awb")

						arg_265_1:RecordAudio("120141064", var_268_6)
						arg_265_1:RecordAudio("120141064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120141", "120141064", "story_v_out_120141.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120141", "120141064", "story_v_out_120141.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120141065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120141065
		arg_269_1.duration_ = 4.5

		local var_269_0 = {
			zh = 2.466,
			ja = 4.5
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120141066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10037ui_story = arg_269_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).z)
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles = arg_269_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).z)
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles = arg_269_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1071ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1071ui_story = var_272_1.localPosition
			end

			local var_272_2 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 then
				var_272_1.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_269_1.time_ - 0) / var_272_2)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 then
				var_272_1.localPosition = Vector3.New(0, -1.05, -6.2)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_272_3 = 0
			local var_272_4 = 0.3

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_5 = arg_269_1:GetWordFromCfg(120141065)
				local var_272_6 = arg_269_1:FormatText(var_272_5.content)

				arg_269_1.text_.text = var_272_6

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_8 = 12 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_6) / 12)

				if (12 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_6) / 12)) > 0 and var_272_4 < var_272_8 then
					arg_269_1.talkMaxDuration = var_272_8

					if var_272_8 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_3
					end
				end

				arg_269_1.text_.text = var_272_6
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141065", "story_v_out_120141.awb") ~= 0 then
					local var_272_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141065", "story_v_out_120141.awb") / 1000

					if var_272_9 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_3
					end

					if var_272_5.prefab_name ~= "" and arg_269_1.actors_[var_272_5.prefab_name] ~= nil then
						local var_272_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_5.prefab_name].transform, "story_v_out_120141", "120141065", "story_v_out_120141.awb")

						arg_269_1:RecordAudio("120141065", var_272_10)
						arg_269_1:RecordAudio("120141065", var_272_10)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_120141", "120141065", "story_v_out_120141.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_120141", "120141065", "story_v_out_120141.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_11 = math.max(var_272_4, arg_269_1.talkMaxDuration)

			if var_272_3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_3 + var_272_11 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_3) / var_272_11

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_3 + var_272_11 and arg_269_1.time_ < var_272_3 + var_272_11 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_269_1:InitPlayNodeList()
	end,
	Play120141066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120141066
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play120141067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) and arg_273_1.var_.characterEffect10037ui_story == nil then
				arg_273_1.var_.characterEffect10037ui_story = arg_273_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) then
				if arg_273_1.var_.characterEffect10037ui_story and not isNil(arg_273_1.actors_["10037ui_story"]) then
					arg_273_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) and arg_273_1.var_.characterEffect10037ui_story then
				arg_273_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["10037ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10037ui_story = var_276_2.localPosition
			end

			local var_276_3 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_273_1.time_ - 0) / var_276_3)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(0, -1.13, -6.2)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			local var_276_4 = arg_273_1.actors_["1071ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1071ui_story = var_276_4.localPosition
			end

			local var_276_5 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				var_276_4.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_5)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				var_276_4.localPosition = Vector3.New(0, 100, 0)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_276_6 = 0
			local var_276_7 = 0.1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(120141066)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 4 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 4)

				if (4 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 4)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141066", "story_v_out_120141.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_out_120141", "120141066", "story_v_out_120141.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_out_120141", "120141066", "story_v_out_120141.awb")

						arg_273_1:RecordAudio("120141066", var_276_13)
						arg_273_1:RecordAudio("120141066", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120141", "120141066", "story_v_out_120141.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120141", "120141066", "story_v_out_120141.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_273_1:InitPlayNodeList()
	end,
	Play120141067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120141067
		arg_277_1.duration_ = 7.1

		local var_277_0 = {
			zh = 5.733,
			ja = 7.1
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play120141068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_280_0 = 0
			local var_280_1 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(120141067)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 21 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 21)

				if (21 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 21)) > 0 and var_280_1 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141067", "story_v_out_120141.awb") ~= 0 then
					local var_280_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141067", "story_v_out_120141.awb") / 1000

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end

					if var_280_2.prefab_name ~= "" and arg_277_1.actors_[var_280_2.prefab_name] ~= nil then
						local var_280_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_2.prefab_name].transform, "story_v_out_120141", "120141067", "story_v_out_120141.awb")

						arg_277_1:RecordAudio("120141067", var_280_7)
						arg_277_1:RecordAudio("120141067", var_280_7)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_120141", "120141067", "story_v_out_120141.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_120141", "120141067", "story_v_out_120141.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play120141068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120141068
		arg_281_1.duration_ = 3.9

		local var_281_0 = {
			zh = 3.9,
			ja = 3.733
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play120141069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10037ui_story = arg_281_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).z)
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles = arg_281_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10037ui_story"].transform.position).z)
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10037ui_story"].transform.localEulerAngles = arg_281_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1071ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1071ui_story = var_284_1.localPosition
			end

			local var_284_2 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 then
				var_284_1.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_281_1.time_ - 0) / var_284_2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 then
				var_284_1.localPosition = Vector3.New(0, -1.05, -6.2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_284_3 = arg_281_1.actors_["1071ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1071ui_story == nil then
				arg_281_1.var_.characterEffect1071ui_story = var_284_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 and not isNil(var_284_3) then
				if arg_281_1.var_.characterEffect1071ui_story and not isNil(var_284_3) then
					arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1071ui_story then
				arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_284_6 = 0
			local var_284_7 = 0.3

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(120141068)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 12 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 12)

				if (12 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 12)) > 0 and var_284_7 < var_284_11 then
					arg_281_1.talkMaxDuration = var_284_11

					if var_284_11 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141068", "story_v_out_120141.awb") ~= 0 then
					local var_284_12 = manager.audio:GetVoiceLength("story_v_out_120141", "120141068", "story_v_out_120141.awb") / 1000

					if var_284_12 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_6
					end

					if var_284_8.prefab_name ~= "" and arg_281_1.actors_[var_284_8.prefab_name] ~= nil then
						local var_284_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_8.prefab_name].transform, "story_v_out_120141", "120141068", "story_v_out_120141.awb")

						arg_281_1:RecordAudio("120141068", var_284_13)
						arg_281_1:RecordAudio("120141068", var_284_13)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_120141", "120141068", "story_v_out_120141.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_120141", "120141068", "story_v_out_120141.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_281_1:InitPlayNodeList()
	end,
	Play120141069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120141069
		arg_285_1.duration_ = 13.77

		local var_285_0 = {
			zh = 8.166,
			ja = 13.766
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play120141070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10037ui_story"]) and arg_285_1.var_.characterEffect10037ui_story == nil then
				arg_285_1.var_.characterEffect10037ui_story = arg_285_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10037ui_story"]) then
				if arg_285_1.var_.characterEffect10037ui_story and not isNil(arg_285_1.actors_["10037ui_story"]) then
					arg_285_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10037ui_story"]) and arg_285_1.var_.characterEffect10037ui_story then
				arg_285_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["10037ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10037ui_story = var_288_2.localPosition
			end

			local var_288_3 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_285_1.time_ - 0) / var_288_3)
				var_288_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_2.position).x, (manager.ui.mainCamera.transform.position - var_288_2.position).y, (manager.ui.mainCamera.transform.position - var_288_2.position).z)
				var_288_2.localEulerAngles.z = 0
				var_288_2.localEulerAngles.x = 0
				var_288_2.localEulerAngles = var_288_2.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(0, -1.13, -6.2)
				var_288_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_2.position).x, (manager.ui.mainCamera.transform.position - var_288_2.position).y, (manager.ui.mainCamera.transform.position - var_288_2.position).z)
				var_288_2.localEulerAngles.z = 0
				var_288_2.localEulerAngles.x = 0
				var_288_2.localEulerAngles = var_288_2.localEulerAngles
			end

			local var_288_4 = arg_285_1.actors_["1071ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1071ui_story = var_288_4.localPosition
			end

			local var_288_5 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_5 then
				var_288_4.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_5)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_5 and arg_285_1.time_ < 0 + var_288_5 + arg_288_0 then
				var_288_4.localPosition = Vector3.New(0, 100, 0)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_288_6 = 0
			local var_288_7 = 0.85

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_8 = arg_285_1:GetWordFromCfg(120141069)
				local var_288_9 = arg_285_1:FormatText(var_288_8.content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 34 <= 0 and var_288_7 or var_288_7 * (utf8.len(var_288_9) / 34)

				if (34 <= 0 and var_288_7 or var_288_7 * (utf8.len(var_288_9) / 34)) > 0 and var_288_7 < var_288_11 then
					arg_285_1.talkMaxDuration = var_288_11

					if var_288_11 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141069", "story_v_out_120141.awb") ~= 0 then
					local var_288_12 = manager.audio:GetVoiceLength("story_v_out_120141", "120141069", "story_v_out_120141.awb") / 1000

					if var_288_12 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_6
					end

					if var_288_8.prefab_name ~= "" and arg_285_1.actors_[var_288_8.prefab_name] ~= nil then
						local var_288_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_8.prefab_name].transform, "story_v_out_120141", "120141069", "story_v_out_120141.awb")

						arg_285_1:RecordAudio("120141069", var_288_13)
						arg_285_1:RecordAudio("120141069", var_288_13)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_120141", "120141069", "story_v_out_120141.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_120141", "120141069", "story_v_out_120141.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_285_1:InitPlayNodeList()
	end,
	Play120141070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120141070
		arg_289_1.duration_ = 11.87

		local var_289_0 = {
			zh = 9.9,
			ja = 11.866
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play120141071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			local var_292_0 = 0
			local var_292_1 = 0.7

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(120141070)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 28 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 28)

				if (28 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 28)) > 0 and var_292_1 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141070", "story_v_out_120141.awb") ~= 0 then
					local var_292_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141070", "story_v_out_120141.awb") / 1000

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end

					if var_292_2.prefab_name ~= "" and arg_289_1.actors_[var_292_2.prefab_name] ~= nil then
						local var_292_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_2.prefab_name].transform, "story_v_out_120141", "120141070", "story_v_out_120141.awb")

						arg_289_1:RecordAudio("120141070", var_292_7)
						arg_289_1:RecordAudio("120141070", var_292_7)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_120141", "120141070", "story_v_out_120141.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_120141", "120141070", "story_v_out_120141.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play120141071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 120141071
		arg_293_1.duration_ = 7

		local var_293_0 = {
			zh = 7,
			ja = 5.133
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play120141072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_296_0 = 0
			local var_296_1 = 0.625

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(120141071)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 25 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 25)

				if (25 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 25)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141071", "story_v_out_120141.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141071", "story_v_out_120141.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_out_120141", "120141071", "story_v_out_120141.awb")

						arg_293_1:RecordAudio("120141071", var_296_7)
						arg_293_1:RecordAudio("120141071", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_120141", "120141071", "story_v_out_120141.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_120141", "120141071", "story_v_out_120141.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play120141072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 120141072
		arg_297_1.duration_ = 2.6

		local var_297_0 = {
			zh = 2.6,
			ja = 2.566
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play120141073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1075ui_story"]) and arg_297_1.var_.characterEffect1075ui_story == nil then
				arg_297_1.var_.characterEffect1075ui_story = arg_297_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1075ui_story"]) then
				if arg_297_1.var_.characterEffect1075ui_story and not isNil(arg_297_1.actors_["1075ui_story"]) then
					arg_297_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1075ui_story"]) and arg_297_1.var_.characterEffect1075ui_story then
				arg_297_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["10037ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10037ui_story = var_300_2.localPosition
			end

			local var_300_3 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 then
				var_300_2.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_3)
				var_300_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_2.position).x, (manager.ui.mainCamera.transform.position - var_300_2.position).y, (manager.ui.mainCamera.transform.position - var_300_2.position).z)
				var_300_2.localEulerAngles.z = 0
				var_300_2.localEulerAngles.x = 0
				var_300_2.localEulerAngles = var_300_2.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 then
				var_300_2.localPosition = Vector3.New(0, 100, 0)
				var_300_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_2.position).x, (manager.ui.mainCamera.transform.position - var_300_2.position).y, (manager.ui.mainCamera.transform.position - var_300_2.position).z)
				var_300_2.localEulerAngles.z = 0
				var_300_2.localEulerAngles.x = 0
				var_300_2.localEulerAngles = var_300_2.localEulerAngles
			end

			local var_300_4 = arg_297_1.actors_["1075ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1075ui_story = var_300_4.localPosition
			end

			local var_300_5 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_297_1.time_ - 0) / var_300_5)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(0, -1.055, -6.16)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_300_6 = 0
			local var_300_7 = 0.3

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(120141072)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 12 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 12)

				if (12 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 12)) > 0 and var_300_7 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141072", "story_v_out_120141.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_120141", "120141072", "story_v_out_120141.awb") / 1000

					if var_300_12 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_6
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_120141", "120141072", "story_v_out_120141.awb")

						arg_297_1:RecordAudio("120141072", var_300_13)
						arg_297_1:RecordAudio("120141072", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_120141", "120141072", "story_v_out_120141.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_120141", "120141072", "story_v_out_120141.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_297_1:InitPlayNodeList()
	end,
	Play120141073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 120141073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play120141074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1075ui_story = arg_301_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).z)
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles = arg_301_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1075ui_story"].transform.position).z)
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1075ui_story"].transform.localEulerAngles = arg_301_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_304_1 = 0
			local var_304_2 = 0.775

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(120141073).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 31 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 31)

				if (31 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 31)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play120141074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 120141074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play120141075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.65

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(120141074).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 26 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 26)

				if (26 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 26)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play120141075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 120141075
		arg_309_1.duration_ = 1

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"

			SetActive(arg_309_1.choicesGo_, true)

			for iter_310_0, iter_310_1 in ipairs(arg_309_1.choices_) do
				SetActive(iter_310_1.go, iter_310_0 <= 2)
			end

			arg_309_1.choices_[1].txt.text = arg_309_1:FormatText(StoryChoiceCfg[374].name)
			arg_309_1.choices_[2].txt.text = arg_309_1:FormatText(StoryChoiceCfg[375].name)
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play120141076(arg_309_1)
			end

			if arg_311_0 == 2 then
				arg_309_0:Play120141076(arg_309_1)
			end

			arg_309_1:RecordChoiceLog(120141075, 374, 375)
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			if arg_309_1.time_ >= 0 + 1 and arg_309_1.time_ < 0 + 1 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play120141076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 120141076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play120141077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10037ui_story = arg_313_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).z)
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles = arg_313_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10037ui_story"].transform.position).z)
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10037ui_story"].transform.localEulerAngles = arg_313_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_316_1 = manager.ui.mainCamera.transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.shakeOldPos = var_316_1.localPosition
			end

			local var_316_2 = 1

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 then
				local var_316_3, var_316_4 = math.modf((arg_313_1.time_ - 0) / 0.066)

				var_316_1.localPosition = Vector3.New(var_316_4 * 0.13, var_316_4 * 0.13, var_316_4 * 0.13) + arg_313_1.var_.shakeOldPos
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 then
				var_316_1.localPosition = arg_313_1.var_.shakeOldPos
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			local var_316_6 = 0
			local var_316_7 = 0.075

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(120141076).content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 3 <= 0 and var_316_7 or var_316_7 * (utf8.len(var_316_8) / 3)

				if (3 <= 0 and var_316_7 or var_316_7 * (utf8.len(var_316_8) / 3)) > 0 and var_316_7 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_11 and arg_313_1.time_ < var_316_6 + var_316_11 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play120141077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 120141077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play120141078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(120141077).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 40 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 40)

				if (40 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 40)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play120141078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 120141078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play120141079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.05

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[385].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3041")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(120141078).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 2 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 2)

				if (2 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 2)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play120141079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 120141079
		arg_325_1.duration_ = 4.63

		local var_325_0 = {
			zh = 3.9,
			ja = 4.633
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play120141080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1184ui_story = arg_325_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).z)
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles = arg_325_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_325_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1184ui_story"].transform.position).z)
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1184ui_story"].transform.localEulerAngles = arg_325_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1184ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1184ui_story == nil then
				arg_325_1.var_.characterEffect1184ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1184ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1184ui_story then
				arg_325_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_328_4 = 0
			local var_328_5 = 0.35

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(120141079)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 14 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 14)

				if (14 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 14)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141079", "story_v_out_120141.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141079", "story_v_out_120141.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_120141", "120141079", "story_v_out_120141.awb")

						arg_325_1:RecordAudio("120141079", var_328_11)
						arg_325_1:RecordAudio("120141079", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_120141", "120141079", "story_v_out_120141.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_120141", "120141079", "story_v_out_120141.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play120141080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 120141080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play120141081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if arg_329_1.bgs_.J04f_blur == nil then
				local var_332_0 = Object.Instantiate(arg_329_1.blurPaintGo_)

				var_332_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J04f_blur")
				var_332_0.name = "J04f_blur"
				var_332_0.transform.parent = arg_329_1.stage_.transform
				var_332_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.bgs_.J04f_blur = var_332_0
			end

			local var_332_1 = 0
			local var_332_2 = arg_329_1.bgs_.J04f_blur

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				var_332_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_332_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_3 = var_332_2:GetComponent("SpriteRenderer")

				if var_332_3 and var_332_3.sprite then
					local var_332_4 = 2 * (var_332_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_332_2.transform.localScale = Vector3.New(var_332_4 / var_332_3.sprite.bounds.size.y < var_332_4 * manager.ui.mainCameraCom_.aspect / var_332_3.sprite.bounds.size.x and var_332_4 * manager.ui.mainCameraCom_.aspect / var_332_3.sprite.bounds.size.x or var_332_4 / var_332_3.sprite.bounds.size.y, var_332_4 / var_332_3.sprite.bounds.size.y < var_332_4 * manager.ui.mainCameraCom_.aspect / var_332_3.sprite.bounds.size.x and var_332_4 * manager.ui.mainCameraCom_.aspect / var_332_3.sprite.bounds.size.x or var_332_4 / var_332_3.sprite.bounds.size.y, 0)
				end
			end

			local var_332_5 = 2.5

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_5 then
				local var_332_6 = Color.New(1, 1, 1)

				var_332_6.a = Mathf.Lerp(0, 1, (arg_329_1.time_ - var_332_1) / var_332_5)

				var_332_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_332_6)
			end

			local var_332_7 = arg_329_1.actors_["1184ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1184ui_story = var_332_7.localPosition
			end

			local var_332_8 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_8 then
				var_332_7.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_8)
				var_332_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_7.position).x, (manager.ui.mainCamera.transform.position - var_332_7.position).y, (manager.ui.mainCamera.transform.position - var_332_7.position).z)
				var_332_7.localEulerAngles.z = 0
				var_332_7.localEulerAngles.x = 0
				var_332_7.localEulerAngles = var_332_7.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_8 and arg_329_1.time_ < 0 + var_332_8 + arg_332_0 then
				var_332_7.localPosition = Vector3.New(0, 100, 0)
				var_332_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_7.position).x, (manager.ui.mainCamera.transform.position - var_332_7.position).y, (manager.ui.mainCamera.transform.position - var_332_7.position).z)
				var_332_7.localEulerAngles.z = 0
				var_332_7.localEulerAngles.x = 0
				var_332_7.localEulerAngles = var_332_7.localEulerAngles
			end

			local var_332_9 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_9 + 2.5 and arg_329_1.time_ < var_332_9 + 2.5 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_10 = 0
			local var_332_11 = 1.425

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_12 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(120141080).content)

				arg_329_1.text_.text = var_332_12

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_14 = 57 <= 0 and var_332_11 or var_332_11 * (utf8.len(var_332_12) / 57)

				if (57 <= 0 and var_332_11 or var_332_11 * (utf8.len(var_332_12) / 57)) > 0 and var_332_11 < var_332_14 then
					arg_329_1.talkMaxDuration = var_332_14

					if var_332_14 + var_332_10 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_10
					end
				end

				arg_329_1.text_.text = var_332_12
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_15 = math.max(var_332_11, arg_329_1.talkMaxDuration)

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_15 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_10) / var_332_15

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_10 + var_332_15 and arg_329_1.time_ < var_332_10 + var_332_15 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play120141081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 120141081
		arg_333_1.duration_ = 5.3

		local var_333_0 = {
			zh = 3.333,
			ja = 5.3
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play120141082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_336_0 = 0.6

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				local var_336_1, var_336_2 = math.modf((arg_333_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_336_2 * 0.13, var_336_2 * 0.13, var_336_2 * 0.13) + arg_333_1.var_.shakeOldPos
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				manager.ui.mainCamera.transform.localPosition = arg_333_1.var_.shakeOldPos
			end

			local var_336_3 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			if arg_333_1.time_ >= var_336_3 + 0.6 and arg_333_1.time_ < var_336_3 + 0.6 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end

			local var_336_4 = 0
			local var_336_5 = 0.375

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_6 = arg_333_1:GetWordFromCfg(120141081)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 15 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 15)

				if (15 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 15)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141081", "story_v_out_120141.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141081", "story_v_out_120141.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_120141", "120141081", "story_v_out_120141.awb")

						arg_333_1:RecordAudio("120141081", var_336_11)
						arg_333_1:RecordAudio("120141081", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_120141", "120141081", "story_v_out_120141.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_120141", "120141081", "story_v_out_120141.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play120141082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 120141082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play120141083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1071ui_story = arg_337_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).z)
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles = arg_337_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1071ui_story"].transform.position).z)
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1071ui_story"].transform.localEulerAngles = arg_337_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_340_1 = 0
			local var_340_2 = 0.975

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(120141082).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 39 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 39)

				if (39 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 39)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play120141083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 120141083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play120141084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.85

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(120141083).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 34 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 34)

				if (34 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 34)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play120141084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 120141084
		arg_345_1.duration_ = 5.47

		local var_345_0 = {
			zh = 4.933,
			ja = 5.466
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play120141085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10037ui_story = arg_345_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).z)
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles = arg_345_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_345_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10037ui_story"].transform.position).z)
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10037ui_story"].transform.localEulerAngles = arg_345_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["10037ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10037ui_story == nil then
				arg_345_1.var_.characterEffect10037ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect10037ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10037ui_story then
				arg_345_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_348_4 = 0
			local var_348_5 = 0.425

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(120141084)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 17 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 17)

				if (17 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 17)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141084", "story_v_out_120141.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141084", "story_v_out_120141.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_out_120141", "120141084", "story_v_out_120141.awb")

						arg_345_1:RecordAudio("120141084", var_348_11)
						arg_345_1:RecordAudio("120141084", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_120141", "120141084", "story_v_out_120141.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_120141", "120141084", "story_v_out_120141.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play120141085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 120141085
		arg_349_1.duration_ = 7.4

		local var_349_0 = {
			zh = 3.533,
			ja = 7.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play120141086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action4_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_352_0 = 0
			local var_352_1 = 0.2

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:GetWordFromCfg(120141085)
				local var_352_3 = arg_349_1:FormatText(var_352_2.content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 8 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_3) / 8)

				if (8 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_3) / 8)) > 0 and var_352_1 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141085", "story_v_out_120141.awb") ~= 0 then
					local var_352_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141085", "story_v_out_120141.awb") / 1000

					if var_352_6 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_0
					end

					if var_352_2.prefab_name ~= "" and arg_349_1.actors_[var_352_2.prefab_name] ~= nil then
						local var_352_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_2.prefab_name].transform, "story_v_out_120141", "120141085", "story_v_out_120141.awb")

						arg_349_1:RecordAudio("120141085", var_352_7)
						arg_349_1:RecordAudio("120141085", var_352_7)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_120141", "120141085", "story_v_out_120141.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_120141", "120141085", "story_v_out_120141.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play120141086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 120141086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play120141087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10037ui_story = arg_353_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).z)
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles = arg_353_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).z)
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles = arg_353_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_356_1 = 0
			local var_356_2 = 1.225

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(120141086).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 49 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 49)

				if (49 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 49)) > 0 and var_356_2 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_6 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_6 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_6

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_6 and arg_353_1.time_ < var_356_1 + var_356_6 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play120141087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 120141087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play120141088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.475

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(120141087).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 19 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 19)

				if (19 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 19)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play120141088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 120141088
		arg_361_1.duration_ = 6.27

		local var_361_0 = {
			zh = 4.166,
			ja = 6.266
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play120141089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1075ui_story = arg_361_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).z)
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles = arg_361_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_361_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1075ui_story"].transform.position).z)
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1075ui_story"].transform.localEulerAngles = arg_361_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["1075ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1075ui_story == nil then
				arg_361_1.var_.characterEffect1075ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect1075ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1075ui_story then
				arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_364_4 = 0
			local var_364_5 = 0.5

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_6 = arg_361_1:GetWordFromCfg(120141088)
				local var_364_7 = arg_361_1:FormatText(var_364_6.content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 20 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 20)

				if (20 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 20)) > 0 and var_364_5 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141088", "story_v_out_120141.awb") ~= 0 then
					local var_364_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141088", "story_v_out_120141.awb") / 1000

					if var_364_10 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_4
					end

					if var_364_6.prefab_name ~= "" and arg_361_1.actors_[var_364_6.prefab_name] ~= nil then
						local var_364_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_6.prefab_name].transform, "story_v_out_120141", "120141088", "story_v_out_120141.awb")

						arg_361_1:RecordAudio("120141088", var_364_11)
						arg_361_1:RecordAudio("120141088", var_364_11)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_120141", "120141088", "story_v_out_120141.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_120141", "120141088", "story_v_out_120141.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_12 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_12 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_12

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_12 and arg_361_1.time_ < var_364_4 + var_364_12 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play120141089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 120141089
		arg_365_1.duration_ = 2.73

		local var_365_0 = {
			zh = 2.733,
			ja = 2.066
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play120141090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_368_0 = 0
			local var_368_1 = 0.375

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_2 = arg_365_1:GetWordFromCfg(120141089)
				local var_368_3 = arg_365_1:FormatText(var_368_2.content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 15 <= 0 and var_368_1 or var_368_1 * (utf8.len(var_368_3) / 15)

				if (15 <= 0 and var_368_1 or var_368_1 * (utf8.len(var_368_3) / 15)) > 0 and var_368_1 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141089", "story_v_out_120141.awb") ~= 0 then
					local var_368_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141089", "story_v_out_120141.awb") / 1000

					if var_368_6 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_0
					end

					if var_368_2.prefab_name ~= "" and arg_365_1.actors_[var_368_2.prefab_name] ~= nil then
						local var_368_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_2.prefab_name].transform, "story_v_out_120141", "120141089", "story_v_out_120141.awb")

						arg_365_1:RecordAudio("120141089", var_368_7)
						arg_365_1:RecordAudio("120141089", var_368_7)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_120141", "120141089", "story_v_out_120141.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_120141", "120141089", "story_v_out_120141.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play120141090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 120141090
		arg_369_1.duration_ = 9.77

		local var_369_0 = {
			zh = 5.7,
			ja = 9.766
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play120141091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_372_0 = 0
			local var_372_1 = 0.825

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_2 = arg_369_1:GetWordFromCfg(120141090)
				local var_372_3 = arg_369_1:FormatText(var_372_2.content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 33 <= 0 and var_372_1 or var_372_1 * (utf8.len(var_372_3) / 33)

				if (33 <= 0 and var_372_1 or var_372_1 * (utf8.len(var_372_3) / 33)) > 0 and var_372_1 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141090", "story_v_out_120141.awb") ~= 0 then
					local var_372_6 = manager.audio:GetVoiceLength("story_v_out_120141", "120141090", "story_v_out_120141.awb") / 1000

					if var_372_6 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_0
					end

					if var_372_2.prefab_name ~= "" and arg_369_1.actors_[var_372_2.prefab_name] ~= nil then
						local var_372_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_2.prefab_name].transform, "story_v_out_120141", "120141090", "story_v_out_120141.awb")

						arg_369_1:RecordAudio("120141090", var_372_7)
						arg_369_1:RecordAudio("120141090", var_372_7)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_120141", "120141090", "story_v_out_120141.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_120141", "120141090", "story_v_out_120141.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_8 and arg_369_1.time_ < var_372_0 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play120141091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 120141091
		arg_373_1.duration_ = 6.13

		local var_373_0 = {
			zh = 6.133,
			ja = 4.7
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play120141092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1075ui_story = arg_373_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).z)
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles = arg_373_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1075ui_story"].transform.position).z)
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1075ui_story"].transform.localEulerAngles = arg_373_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1071ui_story"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1071ui_story = var_376_1.localPosition
			end

			local var_376_2 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 then
				var_376_1.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_373_1.time_ - 0) / var_376_2)
				var_376_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_1.position).x, (manager.ui.mainCamera.transform.position - var_376_1.position).y, (manager.ui.mainCamera.transform.position - var_376_1.position).z)
				var_376_1.localEulerAngles.z = 0
				var_376_1.localEulerAngles.x = 0
				var_376_1.localEulerAngles = var_376_1.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 then
				var_376_1.localPosition = Vector3.New(0, -1.05, -6.2)
				var_376_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_1.position).x, (manager.ui.mainCamera.transform.position - var_376_1.position).y, (manager.ui.mainCamera.transform.position - var_376_1.position).z)
				var_376_1.localEulerAngles.z = 0
				var_376_1.localEulerAngles.x = 0
				var_376_1.localEulerAngles = var_376_1.localEulerAngles
			end

			local var_376_3 = arg_373_1.actors_["1071ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_3) and arg_373_1.var_.characterEffect1071ui_story == nil then
				arg_373_1.var_.characterEffect1071ui_story = var_376_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_4 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 and not isNil(var_376_3) then
				if arg_373_1.var_.characterEffect1071ui_story and not isNil(var_376_3) then
					arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 and not isNil(var_376_3) and arg_373_1.var_.characterEffect1071ui_story then
				arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_376_6 = 0
			local var_376_7 = 0.6

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(120141091)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 24 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 24)

				if (24 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 24)) > 0 and var_376_7 < var_376_11 then
					arg_373_1.talkMaxDuration = var_376_11

					if var_376_11 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141091", "story_v_out_120141.awb") ~= 0 then
					local var_376_12 = manager.audio:GetVoiceLength("story_v_out_120141", "120141091", "story_v_out_120141.awb") / 1000

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end

					if var_376_8.prefab_name ~= "" and arg_373_1.actors_[var_376_8.prefab_name] ~= nil then
						local var_376_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_8.prefab_name].transform, "story_v_out_120141", "120141091", "story_v_out_120141.awb")

						arg_373_1:RecordAudio("120141091", var_376_13)
						arg_373_1:RecordAudio("120141091", var_376_13)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_120141", "120141091", "story_v_out_120141.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_120141", "120141091", "story_v_out_120141.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play120141092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 120141092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play120141093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1071ui_story = arg_377_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).z)
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles = arg_377_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1071ui_story"].transform.position).z)
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1071ui_story"].transform.localEulerAngles = arg_377_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_380_1 = 0
			local var_380_2 = 0.975

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(120141092).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 39 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 39)

				if (39 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 39)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play120141093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 120141093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play120141094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.7

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(120141093).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 28 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 28)

				if (28 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 28)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play120141094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 120141094
		arg_385_1.duration_ = 5.67

		local var_385_0 = {
			zh = 2.3,
			ja = 5.666
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
			arg_385_1.auto_ = false
		end

		function arg_385_1.playNext_(arg_387_0)
			arg_385_1.onStoryFinished_()
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1075ui_story = arg_385_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).z)
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles = arg_385_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_385_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1075ui_story"].transform.position).z)
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1075ui_story"].transform.localEulerAngles = arg_385_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1075ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1075ui_story == nil then
				arg_385_1.var_.characterEffect1075ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1075ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1075ui_story then
				arg_385_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_388_4 = 0
			local var_388_5 = 0.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(120141094)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 13 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 13)

				if (13 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 13)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141094", "story_v_out_120141.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141094", "story_v_out_120141.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_out_120141", "120141094", "story_v_out_120141.awb")

						arg_385_1:RecordAudio("120141094", var_388_11)
						arg_385_1:RecordAudio("120141094", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_120141", "120141094", "story_v_out_120141.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_120141", "120141094", "story_v_out_120141.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J04f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0107"
	},
	voices = {
		"story_v_out_120141.awb"
	}
}
