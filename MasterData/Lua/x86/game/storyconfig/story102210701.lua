return {
	Play221071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 221071001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			ja = 5.4,
			ko = 4.2,
			zh = 4.2
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
				arg_1_0:Play221071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST29 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_4_0.name = "ST29"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST29 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST29

				arg_1_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST29" then
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

			local var_4_8 = "1072ui_story"

			if arg_1_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1072ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.71, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1072ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 1.03400000184774 < arg_1_1.time_ and arg_1_1.time_ <= 1.03400000184774 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

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
			local var_4_24 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(221071001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 10 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 10)

				if (10 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 10)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071001", "story_v_out_221071.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_221071", "221071001", "story_v_out_221071.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_221071", "221071001", "story_v_out_221071.awb")

						arg_1_1:RecordAudio("221071001", var_4_31)
						arg_1_1:RecordAudio("221071001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_221071", "221071001", "story_v_out_221071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_221071", "221071001", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play221071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 221071002
		arg_9_1.duration_ = 8.7

		local var_9_0 = {
			ja = 8.7,
			ko = 3.733,
			zh = 3.733
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
				arg_9_0:Play221071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1072ui_story = arg_9_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1072ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story == nil then
				arg_9_1.var_.characterEffect1072ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1072ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story then
				arg_9_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_12_4 = 0
			local var_12_5 = 0.525

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(221071002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 21 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 21)

				if (21 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 21)) > 0 and var_12_5 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071002", "story_v_out_221071.awb") ~= 0 then
					local var_12_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071002", "story_v_out_221071.awb") / 1000

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end

					if var_12_6.prefab_name ~= "" and arg_9_1.actors_[var_12_6.prefab_name] ~= nil then
						local var_12_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_6.prefab_name].transform, "story_v_out_221071", "221071002", "story_v_out_221071.awb")

						arg_9_1:RecordAudio("221071002", var_12_11)
						arg_9_1:RecordAudio("221071002", var_12_11)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_221071", "221071002", "story_v_out_221071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_221071", "221071002", "story_v_out_221071.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_12 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_12 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_12

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_12 and arg_9_1.time_ < var_12_4 + var_12_12 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 221071003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play221071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1072ui_story = arg_13_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).z)
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles = arg_13_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1072ui_story"].transform.position).z)
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1072ui_story"].transform.localEulerAngles = arg_13_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1072ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1072ui_story == nil then
				arg_13_1.var_.characterEffect1072ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1072ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1072ui_story then
				arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_16_3 = 0
			local var_16_4 = 1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(221071003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 40 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 40)

				if (40 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 40)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 221071004
		arg_17_1.duration_ = 7.13

		local var_17_0 = {
			ja = 7.133,
			ko = 4.3,
			zh = 4.3
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
				arg_17_0:Play221071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1072ui_story = arg_17_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1072ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story == nil then
				arg_17_1.var_.characterEffect1072ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1072ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story then
				arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(221071004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)

				if (19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071004", "story_v_out_221071.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071004", "story_v_out_221071.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_221071", "221071004", "story_v_out_221071.awb")

						arg_17_1:RecordAudio("221071004", var_20_11)
						arg_17_1:RecordAudio("221071004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_221071", "221071004", "story_v_out_221071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_221071", "221071004", "story_v_out_221071.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 221071005
		arg_21_1.duration_ = 2.93

		local var_21_0 = {
			ja = 1.999999999999,
			ko = 2.933,
			zh = 2.933
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
				arg_21_0:Play221071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1074ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1074ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1074ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1074ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1074ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1074ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1074ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1074ui_story == nil then
				arg_21_1.var_.characterEffect1074ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1074ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1074ui_story then
				arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_24_8 = arg_21_1.actors_["1072ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_24_10 = 0
			local var_24_11 = 0.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(221071005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 5 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 5)

				if (5 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 5)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071005", "story_v_out_221071.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_221071", "221071005", "story_v_out_221071.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_221071", "221071005", "story_v_out_221071.awb")

						arg_21_1:RecordAudio("221071005", var_24_17)
						arg_21_1:RecordAudio("221071005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_221071", "221071005", "story_v_out_221071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_221071", "221071005", "story_v_out_221071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play221071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 221071006
		arg_25_1.duration_ = 11.13

		local var_25_0 = {
			ja = 11.133,
			ko = 9.6,
			zh = 9.6
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
				arg_25_0:Play221071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1072ui_story = arg_25_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).z)
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles = arg_25_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_25_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).z)
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles = arg_25_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1072ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1072ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1072ui_story then
				arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = arg_25_1.actors_["1074ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1074ui_story == nil then
				arg_25_1.var_.characterEffect1074ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect1074ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1074ui_story then
				arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 1.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(221071006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 44 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 44)

				if (44 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 44)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071006", "story_v_out_221071.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071006", "story_v_out_221071.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_221071", "221071006", "story_v_out_221071.awb")

						arg_25_1:RecordAudio("221071006", var_28_13)
						arg_25_1:RecordAudio("221071006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_221071", "221071006", "story_v_out_221071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_221071", "221071006", "story_v_out_221071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 221071007
		arg_29_1.duration_ = 15

		local var_29_0 = {
			ja = 15,
			ko = 11.433,
			zh = 11.433
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
				arg_29_0:Play221071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1072ui_story = arg_29_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).z)
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles = arg_29_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_29_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).z)
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles = arg_29_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_1 = 0
			local var_32_2 = 1.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(221071007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 53)

				if (53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 53)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071007", "story_v_out_221071.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071007", "story_v_out_221071.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_221071", "221071007", "story_v_out_221071.awb")

						arg_29_1:RecordAudio("221071007", var_32_8)
						arg_29_1:RecordAudio("221071007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_221071", "221071007", "story_v_out_221071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_221071", "221071007", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play221071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 221071008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play221071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1074ui_story = arg_33_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).z)
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles = arg_33_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_33_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).z)
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles = arg_33_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1074ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1074ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1074ui_story then
				arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action426")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_36_4 = arg_33_1.actors_["1072ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1072ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_36_6 = 0
			local var_36_7 = 0.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(221071008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 2 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 2)

				if (2 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 2)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071008", "story_v_out_221071.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071008", "story_v_out_221071.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_221071", "221071008", "story_v_out_221071.awb")

						arg_33_1:RecordAudio("221071008", var_36_13)
						arg_33_1:RecordAudio("221071008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_221071", "221071008", "story_v_out_221071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_221071", "221071008", "story_v_out_221071.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play221071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 221071009
		arg_37_1.duration_ = 9.33

		local var_37_0 = {
			ja = 9.333,
			ko = 8.6,
			zh = 8.6
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play221071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1074ui_story = arg_37_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).z)
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles = arg_37_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_37_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1074ui_story"].transform.position).z)
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1074ui_story"].transform.localEulerAngles = arg_37_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_1 = 0
			local var_40_2 = 0.925

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(221071009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 37 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 37)

				if (37 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 37)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071009", "story_v_out_221071.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071009", "story_v_out_221071.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_221071", "221071009", "story_v_out_221071.awb")

						arg_37_1:RecordAudio("221071009", var_40_8)
						arg_37_1:RecordAudio("221071009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_221071", "221071009", "story_v_out_221071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_221071", "221071009", "story_v_out_221071.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play221071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 221071010
		arg_41_1.duration_ = 2.7

		local var_41_0 = {
			ja = 2.7,
			ko = 2.166,
			zh = 2.166
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
				arg_41_0:Play221071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1072ui_story = arg_41_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1072ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1072ui_story then
				arg_41_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["1074ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1074ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1074ui_story then
				arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(221071010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 12 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 12)

				if (12 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 12)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071010", "story_v_out_221071.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071010", "story_v_out_221071.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_221071", "221071010", "story_v_out_221071.awb")

						arg_41_1:RecordAudio("221071010", var_44_13)
						arg_41_1:RecordAudio("221071010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_221071", "221071010", "story_v_out_221071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_221071", "221071010", "story_v_out_221071.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 221071011
		arg_45_1.duration_ = 8.3

		local var_45_0 = {
			ja = 8.3,
			ko = 4.6,
			zh = 4.6
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
				arg_45_0:Play221071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1074ui_story = arg_45_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).z)
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles = arg_45_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_45_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1074ui_story"].transform.position).z)
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1074ui_story"].transform.localEulerAngles = arg_45_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1074ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1074ui_story == nil then
				arg_45_1.var_.characterEffect1074ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1074ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1074ui_story then
				arg_45_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["1072ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect1072ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1072ui_story then
				arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(221071011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 20 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 20)

				if (20 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 20)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071011", "story_v_out_221071.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071011", "story_v_out_221071.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_221071", "221071011", "story_v_out_221071.awb")

						arg_45_1:RecordAudio("221071011", var_48_13)
						arg_45_1:RecordAudio("221071011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_221071", "221071011", "story_v_out_221071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_221071", "221071011", "story_v_out_221071.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play221071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 221071012
		arg_49_1.duration_ = 2.63

		local var_49_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_49_0:Play221071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1072ui_story = arg_49_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1072ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1074ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1074ui_story == nil then
				arg_49_1.var_.characterEffect1074ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1074ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1074ui_story then
				arg_49_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(221071012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 3 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 3)

				if (3 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 3)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071012", "story_v_out_221071.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071012", "story_v_out_221071.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_221071", "221071012", "story_v_out_221071.awb")

						arg_49_1:RecordAudio("221071012", var_52_13)
						arg_49_1:RecordAudio("221071012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_221071", "221071012", "story_v_out_221071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_221071", "221071012", "story_v_out_221071.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play221071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 221071013
		arg_53_1.duration_ = 5.27

		local var_53_0 = {
			ja = 4.766,
			ko = 5.266,
			zh = 5.266
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
				arg_53_0:Play221071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1072ui_story = arg_53_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_56_1 = 0
			local var_56_2 = 0.525

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(221071013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 21 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 21)

				if (21 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 21)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071013", "story_v_out_221071.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071013", "story_v_out_221071.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_221071", "221071013", "story_v_out_221071.awb")

						arg_53_1:RecordAudio("221071013", var_56_8)
						arg_53_1:RecordAudio("221071013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_221071", "221071013", "story_v_out_221071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_221071", "221071013", "story_v_out_221071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play221071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 221071014
		arg_57_1.duration_ = 3.3

		local var_57_0 = {
			ja = 2.9,
			ko = 3.3,
			zh = 3.3
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
				arg_57_0:Play221071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1072ui_story = arg_57_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).z)
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles = arg_57_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_57_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).z)
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles = arg_57_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1072ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1072ui_story == nil then
				arg_57_1.var_.characterEffect1072ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1072ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1072ui_story then
				arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(221071014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 17 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 17)

				if (17 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 17)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071014", "story_v_out_221071.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071014", "story_v_out_221071.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_221071", "221071014", "story_v_out_221071.awb")

						arg_57_1:RecordAudio("221071014", var_60_11)
						arg_57_1:RecordAudio("221071014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_221071", "221071014", "story_v_out_221071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_221071", "221071014", "story_v_out_221071.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play221071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 221071015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play221071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1074ui_story = arg_61_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).z)
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles = arg_61_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_61_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).z)
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles = arg_61_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1074ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1074ui_story == nil then
				arg_61_1.var_.characterEffect1074ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1074ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1074ui_story then
				arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["1072ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_64_6 = 0
			local var_64_7 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(221071015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 4 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 4)

				if (4 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 4)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071015", "story_v_out_221071.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071015", "story_v_out_221071.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_221071", "221071015", "story_v_out_221071.awb")

						arg_61_1:RecordAudio("221071015", var_64_13)
						arg_61_1:RecordAudio("221071015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_221071", "221071015", "story_v_out_221071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_221071", "221071015", "story_v_out_221071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play221071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 221071016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play221071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1072ui_story = arg_65_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).z)
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles = arg_65_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).z)
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles = arg_65_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1072ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1072ui_story then
				arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_68_3 = arg_65_1.actors_["1074ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1074ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, 100, 0)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["1074ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_6)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_68_7 = 0
			local var_68_8 = 0.925

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(221071016).content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 37 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 37)

				if (37 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 37)) > 0 and var_68_8 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_7
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_8, arg_65_1.talkMaxDuration)

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_7) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_7 + var_68_12 and arg_65_1.time_ < var_68_7 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play221071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 221071017
		arg_69_1.duration_ = 4.37

		local var_69_0 = {
			ja = 4.366,
			ko = 4.2,
			zh = 4.2
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
				arg_69_0:Play221071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1072ui_story = arg_69_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).z)
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles = arg_69_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_69_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).z)
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles = arg_69_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1072ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(221071017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 19 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 19)

				if (19 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 19)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071017", "story_v_out_221071.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071017", "story_v_out_221071.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_221071", "221071017", "story_v_out_221071.awb")

						arg_69_1:RecordAudio("221071017", var_72_11)
						arg_69_1:RecordAudio("221071017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_221071", "221071017", "story_v_out_221071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_221071", "221071017", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
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
	Play221071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 221071018
		arg_73_1.duration_ = 10.43

		local var_73_0 = {
			ja = 10.433,
			ko = 7.6,
			zh = 7.6
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
				arg_73_0:Play221071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1072ui_story"]) and arg_73_1.var_.characterEffect1072ui_story == nil then
				arg_73_1.var_.characterEffect1072ui_story = arg_73_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1072ui_story"]) then
				if arg_73_1.var_.characterEffect1072ui_story and not isNil(arg_73_1.actors_["1072ui_story"]) then
					arg_73_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1072ui_story"]) and arg_73_1.var_.characterEffect1072ui_story then
				arg_73_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 1.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[429].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(221071018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 47 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 47)

				if (47 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 47)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071018", "story_v_out_221071.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071018", "story_v_out_221071.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_221071", "221071018", "story_v_out_221071.awb")

						arg_73_1:RecordAudio("221071018", var_76_8)
						arg_73_1:RecordAudio("221071018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_221071", "221071018", "story_v_out_221071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_221071", "221071018", "story_v_out_221071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play221071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 221071019
		arg_77_1.duration_ = 3.67

		local var_77_0 = {
			ja = 3.133,
			ko = 3.666,
			zh = 3.666
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
				arg_77_0:Play221071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1072ui_story = arg_77_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).z)
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles = arg_77_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_77_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1072ui_story"].transform.position).z)
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1072ui_story"].transform.localEulerAngles = arg_77_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1072ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(221071019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)

				if (12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071019", "story_v_out_221071.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071019", "story_v_out_221071.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_221071", "221071019", "story_v_out_221071.awb")

						arg_77_1:RecordAudio("221071019", var_80_11)
						arg_77_1:RecordAudio("221071019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_221071", "221071019", "story_v_out_221071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_221071", "221071019", "story_v_out_221071.awb")
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

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play221071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 221071020
		arg_81_1.duration_ = 11.4

		local var_81_0 = {
			ja = 11.4,
			ko = 8.533,
			zh = 8.533
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
				arg_81_0:Play221071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1072ui_story = arg_81_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1072ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story == nil then
				arg_81_1.var_.characterEffect1072ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1072ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story then
				arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_84_3 = arg_81_1.actors_["1074ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1074ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1074ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1074ui_story == nil then
				arg_81_1.var_.characterEffect1074ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1074ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1074ui_story then
				arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_8 = 0
			local var_84_9 = 1.3

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(221071020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 52 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 52)

				if (52 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 52)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071020", "story_v_out_221071.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_221071", "221071020", "story_v_out_221071.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_221071", "221071020", "story_v_out_221071.awb")

						arg_81_1:RecordAudio("221071020", var_84_15)
						arg_81_1:RecordAudio("221071020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_221071", "221071020", "story_v_out_221071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_221071", "221071020", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play221071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 221071021
		arg_85_1.duration_ = 4.93

		local var_85_0 = {
			ja = 4.933,
			ko = 4.466,
			zh = 4.466
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
				arg_85_0:Play221071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1074ui_story = arg_85_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).z)
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles = arg_85_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).z)
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles = arg_85_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1074ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1074ui_story == nil then
				arg_85_1.var_.characterEffect1074ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1074ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1074ui_story then
				arg_85_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["1072ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1072ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0, -0.71, -6)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["1072ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_8 = 0
			local var_88_9 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(221071021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 20 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 20)

				if (20 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 20)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071021", "story_v_out_221071.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_221071", "221071021", "story_v_out_221071.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_221071", "221071021", "story_v_out_221071.awb")

						arg_85_1:RecordAudio("221071021", var_88_15)
						arg_85_1:RecordAudio("221071021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_221071", "221071021", "story_v_out_221071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_221071", "221071021", "story_v_out_221071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play221071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 221071022
		arg_89_1.duration_ = 12.7

		local var_89_0 = {
			ja = 12.7,
			ko = 11.966,
			zh = 11.966
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
				arg_89_0:Play221071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1072ui_story = arg_89_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).z)
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles = arg_89_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_89_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1072ui_story"].transform.position).z)
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1072ui_story"].transform.localEulerAngles = arg_89_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_1 = 0
			local var_92_2 = 1.025

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(221071022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 41 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 41)

				if (41 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 41)) > 0 and var_92_2 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071022", "story_v_out_221071.awb") ~= 0 then
					local var_92_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071022", "story_v_out_221071.awb") / 1000

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_221071", "221071022", "story_v_out_221071.awb")

						arg_89_1:RecordAudio("221071022", var_92_8)
						arg_89_1:RecordAudio("221071022", var_92_8)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_221071", "221071022", "story_v_out_221071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_221071", "221071022", "story_v_out_221071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_9 and arg_89_1.time_ < var_92_1 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play221071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 221071023
		arg_93_1.duration_ = 8.37

		local var_93_0 = {
			ja = 8.366,
			ko = 8.133,
			zh = 8.133
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
				arg_93_0:Play221071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1072ui_story = arg_93_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).z)
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles = arg_93_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_93_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1072ui_story"].transform.position).z)
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1072ui_story"].transform.localEulerAngles = arg_93_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_1 = 0
			local var_96_2 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(221071023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 35 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 35)

				if (35 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 35)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071023", "story_v_out_221071.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071023", "story_v_out_221071.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_221071", "221071023", "story_v_out_221071.awb")

						arg_93_1:RecordAudio("221071023", var_96_8)
						arg_93_1:RecordAudio("221071023", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_221071", "221071023", "story_v_out_221071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_221071", "221071023", "story_v_out_221071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play221071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 221071024
		arg_97_1.duration_ = 6.93

		local var_97_0 = {
			ja = 6.933,
			ko = 4.233,
			zh = 4.233
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
				arg_97_0:Play221071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1072ui_story"]) and arg_97_1.var_.characterEffect1072ui_story == nil then
				arg_97_1.var_.characterEffect1072ui_story = arg_97_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1072ui_story"]) then
				if arg_97_1.var_.characterEffect1072ui_story and not isNil(arg_97_1.actors_["1072ui_story"]) then
					arg_97_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1072ui_story"]) and arg_97_1.var_.characterEffect1072ui_story then
				arg_97_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.5

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[430].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(221071024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 20 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 20)

				if (20 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 20)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071024", "story_v_out_221071.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071024", "story_v_out_221071.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_221071", "221071024", "story_v_out_221071.awb")

						arg_97_1:RecordAudio("221071024", var_100_8)
						arg_97_1:RecordAudio("221071024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_221071", "221071024", "story_v_out_221071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_221071", "221071024", "story_v_out_221071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play221071025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 221071025
		arg_101_1.duration_ = 2

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play221071026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1072ui_story = arg_101_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).z)
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles = arg_101_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_101_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).z)
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles = arg_101_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1072ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1072ui_story == nil then
				arg_101_1.var_.characterEffect1072ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1072ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1072ui_story then
				arg_101_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(221071025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 2 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 2)

				if (2 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 2)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071025", "story_v_out_221071.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071025", "story_v_out_221071.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_221071", "221071025", "story_v_out_221071.awb")

						arg_101_1:RecordAudio("221071025", var_104_11)
						arg_101_1:RecordAudio("221071025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_221071", "221071025", "story_v_out_221071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_221071", "221071025", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play221071026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 221071026
		arg_105_1.duration_ = 5.3

		local var_105_0 = {
			ja = 4.7,
			ko = 5.3,
			zh = 5.3
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
				arg_105_0:Play221071027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1072ui_story = arg_105_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).z)
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles = arg_105_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_105_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).z)
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles = arg_105_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_108_1 = 0
			local var_108_2 = 0.625

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(221071026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 25 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 25)

				if (25 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 25)) > 0 and var_108_2 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071026", "story_v_out_221071.awb") ~= 0 then
					local var_108_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071026", "story_v_out_221071.awb") / 1000

					if var_108_7 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_1
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_221071", "221071026", "story_v_out_221071.awb")

						arg_105_1:RecordAudio("221071026", var_108_8)
						arg_105_1:RecordAudio("221071026", var_108_8)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_221071", "221071026", "story_v_out_221071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_221071", "221071026", "story_v_out_221071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_9 and arg_105_1.time_ < var_108_1 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 221071027
		arg_109_1.duration_ = 3.3

		local var_109_0 = {
			ja = 3.166,
			ko = 3.3,
			zh = 3.3
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
				arg_109_0:Play221071028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1072ui_story = arg_109_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).z)
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles = arg_109_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).z)
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles = arg_109_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1072ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1072ui_story == nil then
				arg_109_1.var_.characterEffect1072ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1072ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1072ui_story then
				arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_112_3 = arg_109_1.actors_["1074ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1074ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["1074ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1074ui_story == nil then
				arg_109_1.var_.characterEffect1074ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1074ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1074ui_story then
				arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_112_8 = 0
			local var_112_9 = 0.175

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(221071027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 7 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 7)

				if (7 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 7)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071027", "story_v_out_221071.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_221071", "221071027", "story_v_out_221071.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_221071", "221071027", "story_v_out_221071.awb")

						arg_109_1:RecordAudio("221071027", var_112_15)
						arg_109_1:RecordAudio("221071027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_221071", "221071027", "story_v_out_221071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_221071", "221071027", "story_v_out_221071.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play221071028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 221071028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play221071029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1074ui_story = arg_113_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).z)
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles = arg_113_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1074ui_story"].transform.position).z)
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1074ui_story"].transform.localEulerAngles = arg_113_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1074ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1074ui_story == nil then
				arg_113_1.var_.characterEffect1074ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1074ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1074ui_story then
				arg_113_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_116_3 = 0
			local var_116_4 = 0.875

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(221071028).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 35 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 35)

				if (35 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 35)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play221071029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 221071029
		arg_117_1.duration_ = 3.2

		local var_117_0 = {
			ja = 2.933,
			ko = 3.2,
			zh = 3.2
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
				arg_117_0:Play221071030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1072ui_story = arg_117_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).z)
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles = arg_117_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_117_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).z)
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles = arg_117_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1072ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1072ui_story == nil then
				arg_117_1.var_.characterEffect1072ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1072ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1072ui_story then
				arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			local var_120_4 = arg_117_1.actors_["1074ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1074ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_117_1.time_ - 0) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = arg_117_1.actors_["1074ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.0166666666666667

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 and not isNil(var_120_6) then
				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_7)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1074ui_story then
				arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_120_8 = 0
			local var_120_9 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(221071029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 10 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 10)

				if (10 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 10)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071029", "story_v_out_221071.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_221071", "221071029", "story_v_out_221071.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_221071", "221071029", "story_v_out_221071.awb")

						arg_117_1:RecordAudio("221071029", var_120_15)
						arg_117_1:RecordAudio("221071029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_221071", "221071029", "story_v_out_221071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_221071", "221071029", "story_v_out_221071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play221071030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 221071030
		arg_121_1.duration_ = 6.9

		local var_121_0 = {
			ja = 6.9,
			ko = 4.866,
			zh = 4.866
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
				arg_121_0:Play221071031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1072ui_story = arg_121_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).z)
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles = arg_121_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_121_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1072ui_story"].transform.position).z)
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1072ui_story"].transform.localEulerAngles = arg_121_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1072ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1072ui_story == nil then
				arg_121_1.var_.characterEffect1072ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1072ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1072ui_story then
				arg_121_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action427")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.7

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(221071030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 28 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 28)

				if (28 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 28)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071030", "story_v_out_221071.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071030", "story_v_out_221071.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_221071", "221071030", "story_v_out_221071.awb")

						arg_121_1:RecordAudio("221071030", var_124_11)
						arg_121_1:RecordAudio("221071030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_221071", "221071030", "story_v_out_221071.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_221071", "221071030", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
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
	Play221071031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 221071031
		arg_125_1.duration_ = 2

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play221071032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1074ui_story = arg_125_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).z)
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles = arg_125_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_125_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1074ui_story"].transform.position).z)
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1074ui_story"].transform.localEulerAngles = arg_125_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1074ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1074ui_story == nil then
				arg_125_1.var_.characterEffect1074ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1074ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1074ui_story then
				arg_125_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_128_4 = arg_125_1.actors_["1072ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1072ui_story == nil then
				arg_125_1.var_.characterEffect1072ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect1072ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1072ui_story then
				arg_125_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_128_6 = 0
			local var_128_7 = 0.05

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(221071031)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 2 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 2)

				if (2 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 2)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071031", "story_v_out_221071.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071031", "story_v_out_221071.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_221071", "221071031", "story_v_out_221071.awb")

						arg_125_1:RecordAudio("221071031", var_128_13)
						arg_125_1:RecordAudio("221071031", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_221071", "221071031", "story_v_out_221071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_221071", "221071031", "story_v_out_221071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play221071032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 221071032
		arg_129_1.duration_ = 15.93

		local var_129_0 = {
			ja = 15.933,
			ko = 10.666,
			zh = 10.666
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
				arg_129_0:Play221071033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1074ui_story = arg_129_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).z)
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles = arg_129_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_129_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1074ui_story"].transform.position).z)
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1074ui_story"].transform.localEulerAngles = arg_129_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_1 = 0
			local var_132_2 = 1.15

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(221071032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 46 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 46)

				if (46 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 46)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071032", "story_v_out_221071.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071032", "story_v_out_221071.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_221071", "221071032", "story_v_out_221071.awb")

						arg_129_1:RecordAudio("221071032", var_132_8)
						arg_129_1:RecordAudio("221071032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_221071", "221071032", "story_v_out_221071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_221071", "221071032", "story_v_out_221071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play221071033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 221071033
		arg_133_1.duration_ = 16.93

		local var_133_0 = {
			ja = 16.933,
			ko = 16.2,
			zh = 16.2
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
				arg_133_0:Play221071034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1074ui_story = arg_133_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).z)
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles = arg_133_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_133_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1074ui_story"].transform.position).z)
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1074ui_story"].transform.localEulerAngles = arg_133_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			local var_136_1 = 0
			local var_136_2 = 1.925

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(221071033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 77 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 77)

				if (77 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 77)) > 0 and var_136_2 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071033", "story_v_out_221071.awb") ~= 0 then
					local var_136_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071033", "story_v_out_221071.awb") / 1000

					if var_136_7 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_1
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_221071", "221071033", "story_v_out_221071.awb")

						arg_133_1:RecordAudio("221071033", var_136_8)
						arg_133_1:RecordAudio("221071033", var_136_8)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_221071", "221071033", "story_v_out_221071.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_221071", "221071033", "story_v_out_221071.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_9 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_9

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_9 and arg_133_1.time_ < var_136_1 + var_136_9 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play221071034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 221071034
		arg_137_1.duration_ = 10.4

		local var_137_0 = {
			ja = 10.4,
			ko = 8.1,
			zh = 8.1
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
				arg_137_0:Play221071035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1074ui_story = arg_137_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).z)
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles = arg_137_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_137_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1074ui_story"].transform.position).z)
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1074ui_story"].transform.localEulerAngles = arg_137_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_1 = 0
			local var_140_2 = 1.125

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(221071034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 45 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 45)

				if (45 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 45)) > 0 and var_140_2 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071034", "story_v_out_221071.awb") ~= 0 then
					local var_140_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071034", "story_v_out_221071.awb") / 1000

					if var_140_7 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_1
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_221071", "221071034", "story_v_out_221071.awb")

						arg_137_1:RecordAudio("221071034", var_140_8)
						arg_137_1:RecordAudio("221071034", var_140_8)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_221071", "221071034", "story_v_out_221071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_221071", "221071034", "story_v_out_221071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_9 and arg_137_1.time_ < var_140_1 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play221071035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 221071035
		arg_141_1.duration_ = 7.53

		local var_141_0 = {
			ja = 7.533,
			ko = 5.766,
			zh = 5.766
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
				arg_141_0:Play221071036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1074ui_story = arg_141_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).z)
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles = arg_141_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_141_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1074ui_story"].transform.position).z)
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1074ui_story"].transform.localEulerAngles = arg_141_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_1 = 0
			local var_144_2 = 0.55

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(221071035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 22 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 22)

				if (22 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 22)) > 0 and var_144_2 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071035", "story_v_out_221071.awb") ~= 0 then
					local var_144_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071035", "story_v_out_221071.awb") / 1000

					if var_144_7 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_1
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_221071", "221071035", "story_v_out_221071.awb")

						arg_141_1:RecordAudio("221071035", var_144_8)
						arg_141_1:RecordAudio("221071035", var_144_8)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_221071", "221071035", "story_v_out_221071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_221071", "221071035", "story_v_out_221071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_9 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_9 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_9

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_9 and arg_141_1.time_ < var_144_1 + var_144_9 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play221071036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 221071036
		arg_145_1.duration_ = 3.5

		local var_145_0 = {
			ja = 3.366,
			ko = 3.5,
			zh = 3.5
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
				arg_145_0:Play221071037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1072ui_story = arg_145_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).z)
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles = arg_145_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_145_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1072ui_story"].transform.position).z)
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1072ui_story"].transform.localEulerAngles = arg_145_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1072ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1072ui_story == nil then
				arg_145_1.var_.characterEffect1072ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1072ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1072ui_story then
				arg_145_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_148_4 = arg_145_1.actors_["1074ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1074ui_story == nil then
				arg_145_1.var_.characterEffect1074ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect1074ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1074ui_story then
				arg_145_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0
			local var_148_7 = 0.225

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(221071036)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 9 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 9)

				if (9 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 9)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071036", "story_v_out_221071.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071036", "story_v_out_221071.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_221071", "221071036", "story_v_out_221071.awb")

						arg_145_1:RecordAudio("221071036", var_148_13)
						arg_145_1:RecordAudio("221071036", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_221071", "221071036", "story_v_out_221071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_221071", "221071036", "story_v_out_221071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play221071037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 221071037
		arg_149_1.duration_ = 2.37

		local var_149_0 = {
			ja = 2.366,
			ko = 2.133,
			zh = 2.133
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
				arg_149_0:Play221071038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1074ui_story = arg_149_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).z)
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles = arg_149_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_149_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).z)
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles = arg_149_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1074ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1074ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1074ui_story then
				arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_4 = arg_149_1.actors_["1072ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1072ui_story == nil then
				arg_149_1.var_.characterEffect1072ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect1072ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1072ui_story then
				arg_149_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_152_6 = 0
			local var_152_7 = 0.125

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(221071037)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 5 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 5)

				if (5 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 5)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071037", "story_v_out_221071.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071037", "story_v_out_221071.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_221071", "221071037", "story_v_out_221071.awb")

						arg_149_1:RecordAudio("221071037", var_152_13)
						arg_149_1:RecordAudio("221071037", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_221071", "221071037", "story_v_out_221071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_221071", "221071037", "story_v_out_221071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play221071038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 221071038
		arg_153_1.duration_ = 12.4

		local var_153_0 = {
			ja = 11.566,
			ko = 12.4,
			zh = 12.4
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
				arg_153_0:Play221071039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1072ui_story = arg_153_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).z)
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles = arg_153_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_153_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1072ui_story"].transform.position).z)
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1072ui_story"].transform.localEulerAngles = arg_153_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1072ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1072ui_story == nil then
				arg_153_1.var_.characterEffect1072ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1072ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1072ui_story then
				arg_153_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1074ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect1074ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1074ui_story then
				arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_156_6 = 0
			local var_156_7 = 1.2

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(221071038)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 48 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 48)

				if (48 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 48)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071038", "story_v_out_221071.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071038", "story_v_out_221071.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_221071", "221071038", "story_v_out_221071.awb")

						arg_153_1:RecordAudio("221071038", var_156_13)
						arg_153_1:RecordAudio("221071038", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_221071", "221071038", "story_v_out_221071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_221071", "221071038", "story_v_out_221071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play221071039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 221071039
		arg_157_1.duration_ = 12.03

		local var_157_0 = {
			ja = 12.033,
			ko = 7.833,
			zh = 7.833
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
				arg_157_0:Play221071040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1072ui_story = arg_157_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).z)
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles = arg_157_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_157_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1072ui_story"].transform.position).z)
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1072ui_story"].transform.localEulerAngles = arg_157_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_1 = 0
			local var_160_2 = 0.7

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(221071039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 28 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 28)

				if (28 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 28)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071039", "story_v_out_221071.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071039", "story_v_out_221071.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_221071", "221071039", "story_v_out_221071.awb")

						arg_157_1:RecordAudio("221071039", var_160_8)
						arg_157_1:RecordAudio("221071039", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_221071", "221071039", "story_v_out_221071.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_221071", "221071039", "story_v_out_221071.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play221071040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 221071040
		arg_161_1.duration_ = 4.57

		local var_161_0 = {
			ja = 4.566,
			ko = 4.166,
			zh = 4.166
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
				arg_161_0:Play221071041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1074ui_story = arg_161_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).z)
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles = arg_161_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_161_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1074ui_story"].transform.position).z)
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1074ui_story"].transform.localEulerAngles = arg_161_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1074ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1074ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1074ui_story then
				arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["1072ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1072ui_story == nil then
				arg_161_1.var_.characterEffect1072ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_5 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 and not isNil(var_164_4) then
				if arg_161_1.var_.characterEffect1072ui_story and not isNil(var_164_4) then
					arg_161_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_5)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1072ui_story then
				arg_161_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_164_6 = 0
			local var_164_7 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(221071040)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 12 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 12)

				if (12 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 12)) > 0 and var_164_7 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071040", "story_v_out_221071.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071040", "story_v_out_221071.awb") / 1000

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end

					if var_164_8.prefab_name ~= "" and arg_161_1.actors_[var_164_8.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_8.prefab_name].transform, "story_v_out_221071", "221071040", "story_v_out_221071.awb")

						arg_161_1:RecordAudio("221071040", var_164_13)
						arg_161_1:RecordAudio("221071040", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_221071", "221071040", "story_v_out_221071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_221071", "221071040", "story_v_out_221071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play221071041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 221071041
		arg_165_1.duration_ = 4.43

		local var_165_0 = {
			ja = 4.433,
			ko = 2.933,
			zh = 2.933
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
				arg_165_0:Play221071042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1072ui_story = arg_165_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).z)
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles = arg_165_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_165_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1072ui_story"].transform.position).z)
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1072ui_story"].transform.localEulerAngles = arg_165_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1072ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1072ui_story == nil then
				arg_165_1.var_.characterEffect1072ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1072ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1072ui_story then
				arg_165_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_168_4 = arg_165_1.actors_["1074ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect1074ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1074ui_story then
				arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_168_6 = 0
			local var_168_7 = 0.45

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(221071041)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 15 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 15)

				if (15 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 15)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071041", "story_v_out_221071.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071041", "story_v_out_221071.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_221071", "221071041", "story_v_out_221071.awb")

						arg_165_1:RecordAudio("221071041", var_168_13)
						arg_165_1:RecordAudio("221071041", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_221071", "221071041", "story_v_out_221071.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_221071", "221071041", "story_v_out_221071.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play221071042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 221071042
		arg_169_1.duration_ = 9.7

		local var_169_0 = {
			ja = 9.7,
			ko = 6.4,
			zh = 6.4
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
				arg_169_0:Play221071043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1074ui_story = arg_169_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).z)
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles = arg_169_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_169_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).z)
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles = arg_169_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1074ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1074ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1074ui_story then
				arg_169_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action456")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_172_4 = arg_169_1.actors_["1072ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1072ui_story == nil then
				arg_169_1.var_.characterEffect1072ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect1072ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1072ui_story then
				arg_169_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_172_6 = 0
			local var_172_7 = 0.6

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(221071042)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 24 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 24)

				if (24 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 24)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071042", "story_v_out_221071.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071042", "story_v_out_221071.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_221071", "221071042", "story_v_out_221071.awb")

						arg_169_1:RecordAudio("221071042", var_172_13)
						arg_169_1:RecordAudio("221071042", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_221071", "221071042", "story_v_out_221071.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_221071", "221071042", "story_v_out_221071.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play221071043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 221071043
		arg_173_1.duration_ = 4.43

		local var_173_0 = {
			ja = 4.433,
			ko = 3.233,
			zh = 3.233
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
				arg_173_0:Play221071044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1072ui_story = arg_173_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).z)
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles = arg_173_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_173_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1072ui_story"].transform.position).z)
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1072ui_story"].transform.localEulerAngles = arg_173_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1072ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1072ui_story == nil then
				arg_173_1.var_.characterEffect1072ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1072ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1072ui_story then
				arg_173_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = arg_173_1.actors_["1074ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1074ui_story == nil then
				arg_173_1.var_.characterEffect1074ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect1074ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1074ui_story then
				arg_173_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_176_6 = 0
			local var_176_7 = 0.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(221071043)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 14 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 14)

				if (14 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 14)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071043", "story_v_out_221071.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_221071", "221071043", "story_v_out_221071.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_221071", "221071043", "story_v_out_221071.awb")

						arg_173_1:RecordAudio("221071043", var_176_13)
						arg_173_1:RecordAudio("221071043", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_221071", "221071043", "story_v_out_221071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_221071", "221071043", "story_v_out_221071.awb")
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
				actorName = "1072ui_story",
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
	Play221071044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 221071044
		arg_177_1.duration_ = 2.93

		local var_177_0 = {
			ja = 2.933,
			ko = 2.6,
			zh = 2.6
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
				arg_177_0:Play221071045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1072ui_story = arg_177_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).z)
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles = arg_177_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_177_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1072ui_story"].transform.position).z)
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1072ui_story"].transform.localEulerAngles = arg_177_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_1 = 0
			local var_180_2 = 0.3

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(221071044)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 12 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 12)

				if (12 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 12)) > 0 and var_180_2 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071044", "story_v_out_221071.awb") ~= 0 then
					local var_180_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071044", "story_v_out_221071.awb") / 1000

					if var_180_7 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_1
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_221071", "221071044", "story_v_out_221071.awb")

						arg_177_1:RecordAudio("221071044", var_180_8)
						arg_177_1:RecordAudio("221071044", var_180_8)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_221071", "221071044", "story_v_out_221071.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_221071", "221071044", "story_v_out_221071.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_9 and arg_177_1.time_ < var_180_1 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221071045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 221071045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play221071046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1072ui_story"]) and arg_181_1.var_.characterEffect1072ui_story == nil then
				arg_181_1.var_.characterEffect1072ui_story = arg_181_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1072ui_story"]) then
				if arg_181_1.var_.characterEffect1072ui_story and not isNil(arg_181_1.actors_["1072ui_story"]) then
					arg_181_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1072ui_story"]) and arg_181_1.var_.characterEffect1072ui_story then
				arg_181_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_184_1 = arg_181_1.actors_["1072ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1072ui_story = var_184_1.localPosition
			end

			local var_184_2 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 then
				var_184_1.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_2)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 then
				var_184_1.localPosition = Vector3.New(0, 100, 0)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			local var_184_3 = arg_181_1.actors_["1074ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1074ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, 100, 0)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = 0
			local var_184_6 = 1.025

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(221071045).content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 41 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_7) / 41)

				if (41 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_7) / 41)) > 0 and var_184_6 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_10 and arg_181_1.time_ < var_184_5 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play221071046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 221071046
		arg_185_1.duration_ = 8.93

		local var_185_0 = {
			ja = 8.933,
			ko = 7.4,
			zh = 7.4
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
				arg_185_0:Play221071047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.bgs_.XH0405 == nil then
				local var_188_0 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0405")
				var_188_0.name = "XH0405"
				var_188_0.transform.parent = arg_185_1.stage_.transform
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_.XH0405 = var_188_0
			end

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_1 = arg_185_1.bgs_.XH0405

				arg_185_1.bgs_.XH0405.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_2 = var_188_1:GetComponent("SpriteRenderer")

				if var_188_2 and var_188_2.sprite then
					local var_188_3 = 2 * (var_188_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_1.transform.localScale = Vector3.New(var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "XH0405" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_4 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_5 = 2

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_5 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_4) / var_188_5)
				arg_185_1.mask_.color = var_188_6
			end

			if arg_185_1.time_ >= var_188_4 + var_188_5 and arg_185_1.time_ < var_188_4 + var_188_5 + arg_188_0 then
				local var_188_7 = Color.New(0, 0, 0)

				var_188_7.a = 1
				arg_185_1.mask_.color = var_188_7
			end

			local var_188_8 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_9 = 2

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 then
				local var_188_10 = Color.New(0, 0, 0)

				var_188_10.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_8) / var_188_9)
				arg_185_1.mask_.color = var_188_10
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 then
				local var_188_11 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_11.a = 0
				arg_185_1.mask_.color = var_188_11
			end

			local var_188_12 = arg_185_1.bgs_.XH0405.transform

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1.var_.moveOldPosXH0405 = var_188_12.localPosition
			end

			local var_188_13 = 0.001

			if 2 <= arg_185_1.time_ and arg_185_1.time_ < 2 + var_188_13 then
				var_188_12.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosXH0405, Vector3.New(0, 1, 9), (arg_185_1.time_ - 2) / var_188_13)
			end

			if arg_185_1.time_ >= 2 + var_188_13 and arg_185_1.time_ < 2 + var_188_13 + arg_188_0 then
				var_188_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_188_14 = arg_185_1.bgs_.XH0405.transform

			if 2.01666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 2.01666666666667 + arg_188_0 then
				arg_185_1.var_.moveOldPosXH0405 = var_188_14.localPosition
			end

			local var_188_15 = 4

			if 2.01666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 2.01666666666667 + var_188_15 then
				var_188_14.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosXH0405, Vector3.New(0, 1, 10), (arg_185_1.time_ - 2.01666666666667) / var_188_15)
			end

			if arg_185_1.time_ >= 2.01666666666667 + var_188_15 and arg_185_1.time_ < 2.01666666666667 + var_188_15 + arg_188_0 then
				var_188_14.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_16 = 4
			local var_188_17 = 0.275

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_18 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_18:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:GetWordFromCfg(221071046)
				local var_188_20 = arg_185_1:FormatText(var_188_19.content)

				arg_185_1.text_.text = var_188_20

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_22 = 11 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_20) / 11)

				if (11 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_20) / 11)) > 0 and var_188_17 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22
					var_188_16 = var_188_16 + 0.3

					if var_188_22 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_20
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071046", "story_v_out_221071.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_221071", "221071046", "story_v_out_221071.awb") / 1000

					if var_188_23 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_16
					end

					if var_188_19.prefab_name ~= "" and arg_185_1.actors_[var_188_19.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_19.prefab_name].transform, "story_v_out_221071", "221071046", "story_v_out_221071.awb")

						arg_185_1:RecordAudio("221071046", var_188_24)
						arg_185_1:RecordAudio("221071046", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_221071", "221071046", "story_v_out_221071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_221071", "221071046", "story_v_out_221071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = var_188_16 + 0.3
			local var_188_26 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_16 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_25) / var_188_26

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0405",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0405",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play221071047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 221071047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play221071048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.075

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(221071047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 43 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 43)

				if (43 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 43)) > 0 and var_194_0 < var_194_3 then
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
	Play221071048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 221071048
		arg_195_1.duration_ = 9.6

		local var_195_0 = {
			ja = 9.6,
			ko = 7.166,
			zh = 7.166
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
				arg_195_0:Play221071049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.675

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(221071048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)

				if (27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071048", "story_v_out_221071.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071048", "story_v_out_221071.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_221071", "221071048", "story_v_out_221071.awb")

						arg_195_1:RecordAudio("221071048", var_198_6)
						arg_195_1:RecordAudio("221071048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_221071", "221071048", "story_v_out_221071.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_221071", "221071048", "story_v_out_221071.awb")
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
	Play221071049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 221071049
		arg_199_1.duration_ = 11.17

		local var_199_0 = {
			ja = 11.166,
			ko = 9.566,
			zh = 9.566
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
				arg_199_0:Play221071050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.125

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(221071049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)

				if (45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071049", "story_v_out_221071.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071049", "story_v_out_221071.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_221071", "221071049", "story_v_out_221071.awb")

						arg_199_1:RecordAudio("221071049", var_202_6)
						arg_199_1:RecordAudio("221071049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_221071", "221071049", "story_v_out_221071.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_221071", "221071049", "story_v_out_221071.awb")
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
	Play221071050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 221071050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play221071051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_confuse_loop", "")
			end

			local var_206_1 = 0
			local var_206_2 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(221071050).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 32 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 32)

				if (32 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 32)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play221071051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 221071051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play221071052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.85

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(221071051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 34 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 34)

				if (34 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 34)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play221071052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 221071052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play221071053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.25

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

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(221071052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 50 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 50)

				if (50 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 50)) > 0 and var_214_0 < var_214_3 then
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
	Play221071053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 221071053
		arg_215_1.duration_ = 4.2

		local var_215_0 = {
			ja = 4.2,
			ko = 3.466,
			zh = 3.466
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
				arg_215_0:Play221071054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("stop", "effect", "se_story_221_00", "se_story_221_00_confuse_loop", "")
			end

			local var_218_1 = 0
			local var_218_2 = 0.325

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:GetWordFromCfg(221071053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 13 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 13)

				if (13 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 13)) > 0 and var_218_2 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071053", "story_v_out_221071.awb") ~= 0 then
					local var_218_7 = manager.audio:GetVoiceLength("story_v_out_221071", "221071053", "story_v_out_221071.awb") / 1000

					if var_218_7 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_1
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_221071", "221071053", "story_v_out_221071.awb")

						arg_215_1:RecordAudio("221071053", var_218_8)
						arg_215_1:RecordAudio("221071053", var_218_8)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_221071", "221071053", "story_v_out_221071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_221071", "221071053", "story_v_out_221071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_9 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_9 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_9

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_9 and arg_215_1.time_ < var_218_1 + var_218_9 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play221071054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 221071054
		arg_219_1.duration_ = 9.4

		local var_219_0 = {
			ja = 9.4,
			ko = 5.733,
			zh = 5.733
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
				arg_219_0:Play221071055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.775

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(221071054)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 31 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 31)

				if (31 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 31)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071054", "story_v_out_221071.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071054", "story_v_out_221071.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_221071", "221071054", "story_v_out_221071.awb")

						arg_219_1:RecordAudio("221071054", var_222_6)
						arg_219_1:RecordAudio("221071054", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_221071", "221071054", "story_v_out_221071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_221071", "221071054", "story_v_out_221071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play221071055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 221071055
		arg_223_1.duration_ = 12.07

		local var_223_0 = {
			ja = 12.066,
			ko = 8.4,
			zh = 8.4
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play221071056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 1.075

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(221071055)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 42 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 42)

				if (42 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 42)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071055", "story_v_out_221071.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071055", "story_v_out_221071.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_221071", "221071055", "story_v_out_221071.awb")

						arg_223_1:RecordAudio("221071055", var_226_6)
						arg_223_1:RecordAudio("221071055", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_221071", "221071055", "story_v_out_221071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_221071", "221071055", "story_v_out_221071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play221071056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 221071056
		arg_227_1.duration_ = 13.63

		local var_227_0 = {
			ja = 13.633,
			ko = 9.9,
			zh = 9.9
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play221071057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(221071056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 45 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 45)

				if (45 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 45)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071056", "story_v_out_221071.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071056", "story_v_out_221071.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_221071", "221071056", "story_v_out_221071.awb")

						arg_227_1:RecordAudio("221071056", var_230_6)
						arg_227_1:RecordAudio("221071056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_221071", "221071056", "story_v_out_221071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_221071", "221071056", "story_v_out_221071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play221071057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 221071057
		arg_231_1.duration_ = 15.57

		local var_231_0 = {
			ja = 15.566,
			ko = 7.9,
			zh = 7.9
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play221071058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.85

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:GetWordFromCfg(221071057)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 34 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 34)

				if (34 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 34)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071057", "story_v_out_221071.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071057", "story_v_out_221071.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_221071", "221071057", "story_v_out_221071.awb")

						arg_231_1:RecordAudio("221071057", var_234_6)
						arg_231_1:RecordAudio("221071057", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_221071", "221071057", "story_v_out_221071.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_221071", "221071057", "story_v_out_221071.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play221071058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 221071058
		arg_235_1.duration_ = 5.63

		local var_235_0 = {
			ja = 5.633,
			ko = 4,
			zh = 4
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play221071059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(221071058)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 22 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 22)

				if (22 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 22)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071058", "story_v_out_221071.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071058", "story_v_out_221071.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_221071", "221071058", "story_v_out_221071.awb")

						arg_235_1:RecordAudio("221071058", var_238_6)
						arg_235_1:RecordAudio("221071058", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_221071", "221071058", "story_v_out_221071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_221071", "221071058", "story_v_out_221071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play221071059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 221071059
		arg_239_1.duration_ = 15.53

		local var_239_0 = {
			ja = 15.533,
			ko = 13.366,
			zh = 13.366
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play221071060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.65

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(221071059)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 66 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 66)

				if (66 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 66)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071059", "story_v_out_221071.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071059", "story_v_out_221071.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_221071", "221071059", "story_v_out_221071.awb")

						arg_239_1:RecordAudio("221071059", var_242_6)
						arg_239_1:RecordAudio("221071059", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_221071", "221071059", "story_v_out_221071.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_221071", "221071059", "story_v_out_221071.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play221071060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 221071060
		arg_243_1.duration_ = 12.77

		local var_243_0 = {
			ja = 12.766,
			ko = 10.233,
			zh = 10.233
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play221071061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(221071060)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 48 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 48)

				if (48 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 48)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071060", "story_v_out_221071.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071060", "story_v_out_221071.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_221071", "221071060", "story_v_out_221071.awb")

						arg_243_1:RecordAudio("221071060", var_246_6)
						arg_243_1:RecordAudio("221071060", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_221071", "221071060", "story_v_out_221071.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_221071", "221071060", "story_v_out_221071.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play221071061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 221071061
		arg_247_1.duration_ = 15.9

		local var_247_0 = {
			ja = 15.9,
			ko = 13.1,
			zh = 13.1
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play221071062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(221071061)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 62 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 62)

				if (62 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 62)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071061", "story_v_out_221071.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071061", "story_v_out_221071.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_221071", "221071061", "story_v_out_221071.awb")

						arg_247_1:RecordAudio("221071061", var_250_6)
						arg_247_1:RecordAudio("221071061", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_221071", "221071061", "story_v_out_221071.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_221071", "221071061", "story_v_out_221071.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play221071062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 221071062
		arg_251_1.duration_ = 15.27

		local var_251_0 = {
			ja = 15.266,
			ko = 14.733,
			zh = 14.733
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play221071063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.775

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(221071062)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 71 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 71)

				if (71 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 71)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071062", "story_v_out_221071.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071062", "story_v_out_221071.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_221071", "221071062", "story_v_out_221071.awb")

						arg_251_1:RecordAudio("221071062", var_254_6)
						arg_251_1:RecordAudio("221071062", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_221071", "221071062", "story_v_out_221071.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_221071", "221071062", "story_v_out_221071.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play221071063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 221071063
		arg_255_1.duration_ = 13.7

		local var_255_0 = {
			ja = 13.7,
			ko = 12.266,
			zh = 12.266
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play221071064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.325

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(221071063)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 53 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 53)

				if (53 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 53)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071063", "story_v_out_221071.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071063", "story_v_out_221071.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_221071", "221071063", "story_v_out_221071.awb")

						arg_255_1:RecordAudio("221071063", var_258_6)
						arg_255_1:RecordAudio("221071063", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_221071", "221071063", "story_v_out_221071.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_221071", "221071063", "story_v_out_221071.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play221071064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 221071064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play221071065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.75

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(221071064).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 30 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 30)

				if (30 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 30)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play221071065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 221071065
		arg_263_1.duration_ = 17.5

		local var_263_0 = {
			ja = 17.5,
			ko = 14.933,
			zh = 14.933
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play221071066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.875

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(221071065)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 75 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 75)

				if (75 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 75)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071065", "story_v_out_221071.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071065", "story_v_out_221071.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_221071", "221071065", "story_v_out_221071.awb")

						arg_263_1:RecordAudio("221071065", var_266_6)
						arg_263_1:RecordAudio("221071065", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_221071", "221071065", "story_v_out_221071.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_221071", "221071065", "story_v_out_221071.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play221071066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 221071066
		arg_267_1.duration_ = 13.37

		local var_267_0 = {
			ja = 13.366,
			ko = 9.4,
			zh = 9.4
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
				arg_267_0:Play221071067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.125

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(221071066)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 45 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 45)

				if (45 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 45)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071066", "story_v_out_221071.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071066", "story_v_out_221071.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_221071", "221071066", "story_v_out_221071.awb")

						arg_267_1:RecordAudio("221071066", var_270_6)
						arg_267_1:RecordAudio("221071066", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_221071", "221071066", "story_v_out_221071.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_221071", "221071066", "story_v_out_221071.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play221071067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 221071067
		arg_271_1.duration_ = 8.1

		local var_271_0 = {
			ja = 8.1,
			ko = 7.066,
			zh = 7.066
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
				arg_271_0:Play221071068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.85

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(221071067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 34 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 34)

				if (34 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 34)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071067", "story_v_out_221071.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071067", "story_v_out_221071.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_221071", "221071067", "story_v_out_221071.awb")

						arg_271_1:RecordAudio("221071067", var_274_6)
						arg_271_1:RecordAudio("221071067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_221071", "221071067", "story_v_out_221071.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_221071", "221071067", "story_v_out_221071.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play221071068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 221071068
		arg_275_1.duration_ = 6

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play221071069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 2 < arg_275_1.time_ and arg_275_1.time_ <= 2 + arg_278_0 then
				local var_278_0 = arg_275_1.bgs_.ST29

				arg_275_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_278_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_1 = var_278_0:GetComponent("SpriteRenderer")

				if var_278_1 and var_278_1.sprite then
					local var_278_2 = 2 * (var_278_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_278_0.transform.localScale = Vector3.New(var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "ST29" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_3 = 0

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_4 = 2

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_4 then
				local var_278_5 = Color.New(0, 0, 0)

				var_278_5.a = Mathf.Lerp(0, 1, (arg_275_1.time_ - var_278_3) / var_278_4)
				arg_275_1.mask_.color = var_278_5
			end

			if arg_275_1.time_ >= var_278_3 + var_278_4 and arg_275_1.time_ < var_278_3 + var_278_4 + arg_278_0 then
				local var_278_6 = Color.New(0, 0, 0)

				var_278_6.a = 1
				arg_275_1.mask_.color = var_278_6
			end

			local var_278_7 = 2

			if 2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_8 = 2

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_8 then
				local var_278_9 = Color.New(0, 0, 0)

				var_278_9.a = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_7) / var_278_8)
				arg_275_1.mask_.color = var_278_9
			end

			if arg_275_1.time_ >= var_278_7 + var_278_8 and arg_275_1.time_ < var_278_7 + var_278_8 + arg_278_0 then
				local var_278_10 = Color.New(0, 0, 0)

				arg_275_1.mask_.enabled = false
				var_278_10.a = 0
				arg_275_1.mask_.color = var_278_10
			end

			local var_278_11 = arg_275_1.actors_["1074ui_story"].transform

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= 4 + arg_278_0 then
				arg_275_1.var_.moveOldPos1074ui_story = var_278_11.localPosition
			end

			local var_278_12 = 0.001

			if 4 <= arg_275_1.time_ and arg_275_1.time_ < 4 + var_278_12 then
				var_278_11.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_275_1.time_ - 4) / var_278_12)
				var_278_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_11.position).x, (manager.ui.mainCamera.transform.position - var_278_11.position).y, (manager.ui.mainCamera.transform.position - var_278_11.position).z)
				var_278_11.localEulerAngles.z = 0
				var_278_11.localEulerAngles.x = 0
				var_278_11.localEulerAngles = var_278_11.localEulerAngles
			end

			if arg_275_1.time_ >= 4 + var_278_12 and arg_275_1.time_ < 4 + var_278_12 + arg_278_0 then
				var_278_11.localPosition = Vector3.New(0, -1.055, -6.12)
				var_278_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_11.position).x, (manager.ui.mainCamera.transform.position - var_278_11.position).y, (manager.ui.mainCamera.transform.position - var_278_11.position).z)
				var_278_11.localEulerAngles.z = 0
				var_278_11.localEulerAngles.x = 0
				var_278_11.localEulerAngles = var_278_11.localEulerAngles
			end

			local var_278_13 = arg_275_1.actors_["1074ui_story"]

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= 4 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect1074ui_story == nil then
				arg_275_1.var_.characterEffect1074ui_story = var_278_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_14 = 0.200000002980232

			if 4 <= arg_275_1.time_ and arg_275_1.time_ < 4 + var_278_14 and not isNil(var_278_13) then
				if arg_275_1.var_.characterEffect1074ui_story and not isNil(var_278_13) then
					arg_275_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 4 + var_278_14 and arg_275_1.time_ < 4 + var_278_14 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect1074ui_story then
				arg_275_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= 4 + arg_278_0 then
				arg_275_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= 4 + arg_278_0 then
				arg_275_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_16 = 4
			local var_278_17 = 0.05

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_18 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_18:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_19 = arg_275_1:GetWordFromCfg(221071068)
				local var_278_20 = arg_275_1:FormatText(var_278_19.content)

				arg_275_1.text_.text = var_278_20

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_22 = 2 <= 0 and var_278_17 or var_278_17 * (utf8.len(var_278_20) / 2)

				if (2 <= 0 and var_278_17 or var_278_17 * (utf8.len(var_278_20) / 2)) > 0 and var_278_17 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22
					var_278_16 = var_278_16 + 0.3

					if var_278_22 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_20
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071068", "story_v_out_221071.awb") ~= 0 then
					local var_278_23 = manager.audio:GetVoiceLength("story_v_out_221071", "221071068", "story_v_out_221071.awb") / 1000

					if var_278_23 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_16
					end

					if var_278_19.prefab_name ~= "" and arg_275_1.actors_[var_278_19.prefab_name] ~= nil then
						local var_278_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_19.prefab_name].transform, "story_v_out_221071", "221071068", "story_v_out_221071.awb")

						arg_275_1:RecordAudio("221071068", var_278_24)
						arg_275_1:RecordAudio("221071068", var_278_24)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_221071", "221071068", "story_v_out_221071.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_221071", "221071068", "story_v_out_221071.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_25 = var_278_16 + 0.3
			local var_278_26 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 + 0.3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_25 + var_278_26 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_25) / var_278_26

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_25 + var_278_26 and arg_275_1.time_ < var_278_25 + var_278_26 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play221071069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 221071069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play221071070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1074ui_story = arg_281_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).z)
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles = arg_281_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).z)
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles = arg_281_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1074ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1074ui_story == nil then
				arg_281_1.var_.characterEffect1074ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1074ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_2)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1074ui_story then
				arg_281_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_284_3 = 0
			local var_284_4 = 0.825

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(221071069).content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 33 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 33)

				if (33 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 33)) > 0 and var_284_4 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_3 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_3
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_4, arg_281_1.talkMaxDuration)

			if var_284_3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_3 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_3) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_3 + var_284_8 and arg_281_1.time_ < var_284_3 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play221071070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 221071070
		arg_285_1.duration_ = 17.4

		local var_285_0 = {
			ja = 17.4,
			ko = 15.7,
			zh = 15.7
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
				arg_285_0:Play221071071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1072ui_story = arg_285_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).z)
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles = arg_285_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_285_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1072ui_story"].transform.position).z)
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1072ui_story"].transform.localEulerAngles = arg_285_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1072ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1072ui_story == nil then
				arg_285_1.var_.characterEffect1072ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1072ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1072ui_story then
				arg_285_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_4 = 0
			local var_288_5 = 1.95

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(221071070)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 78 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 78)

				if (78 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 78)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071070", "story_v_out_221071.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071070", "story_v_out_221071.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_221071", "221071070", "story_v_out_221071.awb")

						arg_285_1:RecordAudio("221071070", var_288_11)
						arg_285_1:RecordAudio("221071070", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_221071", "221071070", "story_v_out_221071.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_221071", "221071070", "story_v_out_221071.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play221071071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 221071071
		arg_289_1.duration_ = 17.8

		local var_289_0 = {
			ja = 17.8,
			ko = 10.9,
			zh = 10.9
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
				arg_289_0:Play221071072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.375

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(221071071)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 55 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 55)

				if (55 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 55)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071071", "story_v_out_221071.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071071", "story_v_out_221071.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_221071", "221071071", "story_v_out_221071.awb")

						arg_289_1:RecordAudio("221071071", var_292_6)
						arg_289_1:RecordAudio("221071071", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_221071", "221071071", "story_v_out_221071.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_221071", "221071071", "story_v_out_221071.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play221071072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 221071072
		arg_293_1.duration_ = 17.23

		local var_293_0 = {
			ja = 17.233,
			ko = 13.533,
			zh = 13.533
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
				arg_293_0:Play221071073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.675

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(221071072)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 67 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 67)

				if (67 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 67)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071072", "story_v_out_221071.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_221071", "221071072", "story_v_out_221071.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_221071", "221071072", "story_v_out_221071.awb")

						arg_293_1:RecordAudio("221071072", var_296_6)
						arg_293_1:RecordAudio("221071072", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_221071", "221071072", "story_v_out_221071.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_221071", "221071072", "story_v_out_221071.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play221071073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 221071073
		arg_297_1.duration_ = 15.4

		local var_297_0 = {
			ja = 15.4,
			ko = 12.5,
			zh = 12.5
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
				arg_297_0:Play221071074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1072ui_story = arg_297_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).z)
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles = arg_297_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_297_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1072ui_story"].transform.position).z)
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1072ui_story"].transform.localEulerAngles = arg_297_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1072ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1072ui_story == nil then
				arg_297_1.var_.characterEffect1072ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1072ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1072ui_story then
				arg_297_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action426")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_300_4 = 0
			local var_300_5 = 1.65

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(221071073)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 64 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 64)

				if (64 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 64)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071073", "story_v_out_221071.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071073", "story_v_out_221071.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_221071", "221071073", "story_v_out_221071.awb")

						arg_297_1:RecordAudio("221071073", var_300_11)
						arg_297_1:RecordAudio("221071073", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_221071", "221071073", "story_v_out_221071.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_221071", "221071073", "story_v_out_221071.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play221071074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 221071074
		arg_301_1.duration_ = 11.97

		local var_301_0 = {
			ja = 11.966,
			ko = 10.566,
			zh = 10.566
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play221071075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_0 = 0
			local var_304_1 = 1.025

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(221071074)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 41 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 41)

				if (41 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 41)) > 0 and var_304_1 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071074", "story_v_out_221071.awb") ~= 0 then
					local var_304_6 = manager.audio:GetVoiceLength("story_v_out_221071", "221071074", "story_v_out_221071.awb") / 1000

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end

					if var_304_2.prefab_name ~= "" and arg_301_1.actors_[var_304_2.prefab_name] ~= nil then
						local var_304_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_2.prefab_name].transform, "story_v_out_221071", "221071074", "story_v_out_221071.awb")

						arg_301_1:RecordAudio("221071074", var_304_7)
						arg_301_1:RecordAudio("221071074", var_304_7)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_221071", "221071074", "story_v_out_221071.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_221071", "221071074", "story_v_out_221071.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play221071075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 221071075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play221071076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1072ui_story"]) and arg_305_1.var_.characterEffect1072ui_story == nil then
				arg_305_1.var_.characterEffect1072ui_story = arg_305_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1072ui_story"]) then
				if arg_305_1.var_.characterEffect1072ui_story and not isNil(arg_305_1.actors_["1072ui_story"]) then
					arg_305_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1072ui_story"]) and arg_305_1.var_.characterEffect1072ui_story then
				arg_305_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 1.35

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(221071075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 54 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 54)

				if (54 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 54)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play221071076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 221071076
		arg_309_1.duration_ = 10.7

		local var_309_0 = {
			ja = 10.7,
			ko = 8.933,
			zh = 8.933
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
			arg_309_1.auto_ = false
		end

		function arg_309_1.playNext_(arg_311_0)
			arg_309_1.onStoryFinished_()
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1072ui_story = arg_309_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).z)
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles = arg_309_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_309_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1072ui_story"].transform.position).z)
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1072ui_story"].transform.localEulerAngles = arg_309_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1072ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1072ui_story == nil then
				arg_309_1.var_.characterEffect1072ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1072ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1072ui_story then
				arg_309_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.925

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(221071076)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 37 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 37)

				if (37 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 37)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221071", "221071076", "story_v_out_221071.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_221071", "221071076", "story_v_out_221071.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_221071", "221071076", "story_v_out_221071.awb")

						arg_309_1:RecordAudio("221071076", var_312_11)
						arg_309_1:RecordAudio("221071076", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_221071", "221071076", "story_v_out_221071.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_221071", "221071076", "story_v_out_221071.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/XH0405"
	},
	voices = {
		"story_v_out_221071.awb"
	}
}
