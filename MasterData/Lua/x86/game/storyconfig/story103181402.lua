return {
	Play318142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318142001
		arg_1_1.duration_ = 9.37

		local var_1_0 = {
			zh = 6.966,
			ja = 9.366
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
				arg_1_0:Play318142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K14f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K14f")
				var_4_0.name = "K14f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K14f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K14f

				arg_1_1.bgs_.K14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K14f" then
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

			local var_4_8 = "1199ui_story"

			if arg_1_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1199ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1199ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.08, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1199ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1199ui_story == nil then
				arg_1_1.var_.characterEffect1199ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1199ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1199ui_story then
				arg_1_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou")

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(318142001)
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

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142001", "story_v_out_318142.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_318142", "318142001", "story_v_out_318142.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_318142", "318142001", "story_v_out_318142.awb")

						arg_1_1:RecordAudio("318142001", var_4_31)
						arg_1_1:RecordAudio("318142001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_318142", "318142001", "story_v_out_318142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_318142", "318142001", "story_v_out_318142.awb")
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
				actorName = "1199ui_story",
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
	Play318142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318142002
		arg_9_1.duration_ = 4.73

		local var_9_0 = {
			zh = 4.733,
			ja = 1.999999999999
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
				arg_9_0:Play318142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10065ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10065ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10065ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10065ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10065ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10065ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10065ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10065ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10065ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10065ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.81, -6.19)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10065ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10065ui_story == nil then
				arg_9_1.var_.characterEffect10065ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10065ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10065ui_story then
				arg_9_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action7_2")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["1199ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1199ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, 100, 0)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["1199ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1199ui_story == nil then
				arg_9_1.var_.characterEffect1199ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect1199ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1199ui_story then
				arg_9_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(318142002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 7 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 7)

				if (7 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 7)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142002", "story_v_out_318142.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_318142", "318142002", "story_v_out_318142.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_318142", "318142002", "story_v_out_318142.awb")

						arg_9_1:RecordAudio("318142002", var_12_19)
						arg_9_1:RecordAudio("318142002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318142", "318142002", "story_v_out_318142.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318142", "318142002", "story_v_out_318142.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_20 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_20 and arg_9_1.time_ < var_12_12 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318142003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10065ui_story"]) and arg_13_1.var_.characterEffect10065ui_story == nil then
				arg_13_1.var_.characterEffect10065ui_story = arg_13_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10065ui_story"]) then
				if arg_13_1.var_.characterEffect10065ui_story and not isNil(arg_13_1.actors_["10065ui_story"]) then
					arg_13_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10065ui_story"]) and arg_13_1.var_.characterEffect10065ui_story then
				arg_13_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.9

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(318142003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 36 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 36)

				if (36 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 36)) > 0 and var_16_2 < var_16_5 then
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
	Play318142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318142004
		arg_17_1.duration_ = 4.6

		local var_17_0 = {
			zh = 4.6,
			ja = 2.833
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
				arg_17_0:Play318142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10065ui_story"]) and arg_17_1.var_.characterEffect10065ui_story == nil then
				arg_17_1.var_.characterEffect10065ui_story = arg_17_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10065ui_story"]) then
				if arg_17_1.var_.characterEffect10065ui_story and not isNil(arg_17_1.actors_["10065ui_story"]) then
					arg_17_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10065ui_story"]) and arg_17_1.var_.characterEffect10065ui_story then
				arg_17_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			local var_20_2 = 0
			local var_20_3 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(318142004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 19 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 19)

				if (19 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 19)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142004", "story_v_out_318142.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142004", "story_v_out_318142.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_318142", "318142004", "story_v_out_318142.awb")

						arg_17_1:RecordAudio("318142004", var_20_9)
						arg_17_1:RecordAudio("318142004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318142", "318142004", "story_v_out_318142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318142", "318142004", "story_v_out_318142.awb")
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
	Play318142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318142005
		arg_21_1.duration_ = 3.7

		local var_21_0 = {
			zh = 3.6,
			ja = 3.7
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
				arg_21_0:Play318142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1093ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1093ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1093ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1093ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1093ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_24_8 = arg_21_1.actors_["10065ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10065ui_story = var_24_8.localPosition
			end

			local var_24_9 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_9)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, 100, 0)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			local var_24_10 = arg_21_1.actors_["10065ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10065ui_story == nil then
				arg_21_1.var_.characterEffect10065ui_story = var_24_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 and not isNil(var_24_10) then
				if arg_21_1.var_.characterEffect10065ui_story and not isNil(var_24_10) then
					arg_21_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_11)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10065ui_story then
				arg_21_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_24_12 = 0
			local var_24_13 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(318142005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 14 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 14)

				if (14 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 14)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142005", "story_v_out_318142.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_318142", "318142005", "story_v_out_318142.awb") / 1000

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_318142", "318142005", "story_v_out_318142.awb")

						arg_21_1:RecordAudio("318142005", var_24_19)
						arg_21_1:RecordAudio("318142005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318142", "318142005", "story_v_out_318142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318142", "318142005", "story_v_out_318142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_20 and arg_21_1.time_ < var_24_12 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318142006
		arg_25_1.duration_ = 4.9

		local var_25_0 = {
			zh = 4.3,
			ja = 4.9
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
				arg_25_0:Play318142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10065ui_story = arg_25_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).z)
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles = arg_25_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_25_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10065ui_story"].transform.position).z)
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10065ui_story"].transform.localEulerAngles = arg_25_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10065ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10065ui_story == nil then
				arg_25_1.var_.characterEffect10065ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10065ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10065ui_story then
				arg_25_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["1093ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = var_28_4.localPosition
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_5)
				var_28_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_4.position).x, (manager.ui.mainCamera.transform.position - var_28_4.position).y, (manager.ui.mainCamera.transform.position - var_28_4.position).z)
				var_28_4.localEulerAngles.z = 0
				var_28_4.localEulerAngles.x = 0
				var_28_4.localEulerAngles = var_28_4.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(0, 100, 0)
				var_28_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_4.position).x, (manager.ui.mainCamera.transform.position - var_28_4.position).y, (manager.ui.mainCamera.transform.position - var_28_4.position).z)
				var_28_4.localEulerAngles.z = 0
				var_28_4.localEulerAngles.x = 0
				var_28_4.localEulerAngles = var_28_4.localEulerAngles
			end

			local var_28_6 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 and not isNil(var_28_6) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_6) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_7)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_28_8 = 0
			local var_28_9 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(318142006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 13 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 13)

				if (13 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 13)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142006", "story_v_out_318142.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142006", "story_v_out_318142.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_318142", "318142006", "story_v_out_318142.awb")

						arg_25_1:RecordAudio("318142006", var_28_15)
						arg_25_1:RecordAudio("318142006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318142", "318142006", "story_v_out_318142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318142", "318142006", "story_v_out_318142.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318142007
		arg_29_1.duration_ = 12.9

		local var_29_0 = {
			zh = 9.9,
			ja = 12.9
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
				arg_29_0:Play318142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(318142007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 31)

				if (31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 31)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142007", "story_v_out_318142.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_318142", "318142007", "story_v_out_318142.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_318142", "318142007", "story_v_out_318142.awb")

						arg_29_1:RecordAudio("318142007", var_32_6)
						arg_29_1:RecordAudio("318142007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318142", "318142007", "story_v_out_318142.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318142", "318142007", "story_v_out_318142.awb")
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
	Play318142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318142008
		arg_33_1.duration_ = 12.13

		local var_33_0 = {
			zh = 7.2,
			ja = 12.133
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
				arg_33_0:Play318142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(318142008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 15 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 15)

				if (15 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 15)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142008", "story_v_out_318142.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_318142", "318142008", "story_v_out_318142.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_318142", "318142008", "story_v_out_318142.awb")

						arg_33_1:RecordAudio("318142008", var_36_6)
						arg_33_1:RecordAudio("318142008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318142", "318142008", "story_v_out_318142.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318142", "318142008", "story_v_out_318142.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318142009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10065ui_story = arg_37_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).z)
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles = arg_37_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10065ui_story"].transform.position).z)
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10065ui_story"].transform.localEulerAngles = arg_37_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10065ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10065ui_story == nil then
				arg_37_1.var_.characterEffect10065ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10065ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10065ui_story then
				arg_37_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_40_3 = manager.ui.mainCamera.transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_3.localPosition
			end

			local var_40_4 = 0.6

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				local var_40_5, var_40_6 = math.modf((arg_37_1.time_ - 0) / 0.066)

				var_40_3.localPosition = Vector3.New(var_40_6 * 0.13, var_40_6 * 0.13, var_40_6 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_7 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_7 + 0.6 and arg_37_1.time_ < var_40_7 + 0.6 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_127", "se_story_127_thunder", "")
			end

			local var_40_9 = 0
			local var_40_10 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_11 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(318142009).content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 19 <= 0 and var_40_10 or var_40_10 * (utf8.len(var_40_11) / 19)

				if (19 <= 0 and var_40_10 or var_40_10 * (utf8.len(var_40_11) / 19)) > 0 and var_40_10 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_9
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_10, arg_37_1.talkMaxDuration)

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_9) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_9 + var_40_14 and arg_37_1.time_ < var_40_9 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318142010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(318142010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 55 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 55)

				if (55 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 55)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318142011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318142011
		arg_45_1.duration_ = 3.6

		local var_45_0 = {
			zh = 3.6,
			ja = 3.566
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
				arg_45_0:Play318142012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1093ui_story = arg_45_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).z)
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles = arg_45_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_45_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).z)
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles = arg_45_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1093ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1093ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1093ui_story then
				arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(318142011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 15 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 15)

				if (15 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 15)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142011", "story_v_out_318142.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142011", "story_v_out_318142.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_318142", "318142011", "story_v_out_318142.awb")

						arg_45_1:RecordAudio("318142011", var_48_11)
						arg_45_1:RecordAudio("318142011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318142", "318142011", "story_v_out_318142.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318142", "318142011", "story_v_out_318142.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318142012
		arg_49_1.duration_ = 4.97

		local var_49_0 = {
			zh = 4.266,
			ja = 4.966
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
				arg_49_0:Play318142013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "1150ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1150ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["1150ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["1150ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["1150ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1150ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1150ui_story, Vector3.New(0.7, -1.01, -6.2), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0.7, -1.01, -6.2)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1150ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1150ui_story == nil then
				arg_49_1.var_.characterEffect1150ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1150ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1150ui_story then
				arg_49_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_8 = arg_49_1.actors_["1093ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1093ui_story = var_52_8.localPosition
			end

			local var_52_9 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_9 then
				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_49_1.time_ - 0) / var_52_9)
				var_52_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_8.position).x, (manager.ui.mainCamera.transform.position - var_52_8.position).y, (manager.ui.mainCamera.transform.position - var_52_8.position).z)
				var_52_8.localEulerAngles.z = 0
				var_52_8.localEulerAngles.x = 0
				var_52_8.localEulerAngles = var_52_8.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_9 and arg_49_1.time_ < 0 + var_52_9 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_52_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_8.position).x, (manager.ui.mainCamera.transform.position - var_52_8.position).y, (manager.ui.mainCamera.transform.position - var_52_8.position).z)
				var_52_8.localEulerAngles.z = 0
				var_52_8.localEulerAngles.x = 0
				var_52_8.localEulerAngles = var_52_8.localEulerAngles
			end

			local var_52_10 = arg_49_1.actors_["1093ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_10) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = var_52_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_11 and not isNil(var_52_10) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(var_52_10) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_11)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_11 and arg_49_1.time_ < 0 + var_52_11 + arg_52_0 and not isNil(var_52_10) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_52_12 = 0
			local var_52_13 = 0.525

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(318142012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 21 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_15) / 21)

				if (21 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_15) / 21)) > 0 and var_52_13 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142012", "story_v_out_318142.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_318142", "318142012", "story_v_out_318142.awb") / 1000

					if var_52_18 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_12
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_318142", "318142012", "story_v_out_318142.awb")

						arg_49_1:RecordAudio("318142012", var_52_19)
						arg_49_1:RecordAudio("318142012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318142", "318142012", "story_v_out_318142.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318142", "318142012", "story_v_out_318142.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_20 and arg_49_1.time_ < var_52_12 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318142013
		arg_53_1.duration_ = 4.23

		local var_53_0 = {
			zh = 3.2,
			ja = 4.233
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
				arg_53_0:Play318142014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1150ui_story"]) and arg_53_1.var_.characterEffect1150ui_story == nil then
				arg_53_1.var_.characterEffect1150ui_story = arg_53_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1150ui_story"]) then
				if arg_53_1.var_.characterEffect1150ui_story and not isNil(arg_53_1.actors_["1150ui_story"]) then
					arg_53_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1150ui_story"]) and arg_53_1.var_.characterEffect1150ui_story then
				arg_53_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_56_2 = 0
			local var_56_3 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(318142013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 15 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 15)

				if (15 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 15)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142013", "story_v_out_318142.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142013", "story_v_out_318142.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_318142", "318142013", "story_v_out_318142.awb")

						arg_53_1:RecordAudio("318142013", var_56_9)
						arg_53_1:RecordAudio("318142013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318142", "318142013", "story_v_out_318142.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318142", "318142013", "story_v_out_318142.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318142014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318142014
		arg_57_1.duration_ = 3.77

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 3.766
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
				arg_57_0:Play318142015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1199ui_story = arg_57_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).z)
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles = arg_57_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_57_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).z)
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles = arg_57_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1199ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1199ui_story == nil then
				arg_57_1.var_.characterEffect1199ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1199ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1199ui_story then
				arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["1150ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1150ui_story = var_60_4.localPosition
			end

			local var_60_5 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 then
				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_5)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, 100, 0)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			local var_60_6 = arg_57_1.actors_["1150ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1150ui_story == nil then
				arg_57_1.var_.characterEffect1150ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect1150ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1150ui_story then
				arg_57_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_60_8 = arg_57_1.actors_["1093ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1093ui_story = var_60_8.localPosition
			end

			local var_60_9 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 then
				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_9)
				var_60_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_8.position).x, (manager.ui.mainCamera.transform.position - var_60_8.position).y, (manager.ui.mainCamera.transform.position - var_60_8.position).z)
				var_60_8.localEulerAngles.z = 0
				var_60_8.localEulerAngles.x = 0
				var_60_8.localEulerAngles = var_60_8.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, 100, 0)
				var_60_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_8.position).x, (manager.ui.mainCamera.transform.position - var_60_8.position).y, (manager.ui.mainCamera.transform.position - var_60_8.position).z)
				var_60_8.localEulerAngles.z = 0
				var_60_8.localEulerAngles.x = 0
				var_60_8.localEulerAngles = var_60_8.localEulerAngles
			end

			local var_60_10 = 0
			local var_60_11 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_12 = arg_57_1:GetWordFromCfg(318142014)
				local var_60_13 = arg_57_1:FormatText(var_60_12.content)

				arg_57_1.text_.text = var_60_13

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_15 = 7 <= 0 and var_60_11 or var_60_11 * (utf8.len(var_60_13) / 7)

				if (7 <= 0 and var_60_11 or var_60_11 * (utf8.len(var_60_13) / 7)) > 0 and var_60_11 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_10
					end
				end

				arg_57_1.text_.text = var_60_13
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142014", "story_v_out_318142.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_318142", "318142014", "story_v_out_318142.awb") / 1000

					if var_60_16 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_10
					end

					if var_60_12.prefab_name ~= "" and arg_57_1.actors_[var_60_12.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_12.prefab_name].transform, "story_v_out_318142", "318142014", "story_v_out_318142.awb")

						arg_57_1:RecordAudio("318142014", var_60_17)
						arg_57_1:RecordAudio("318142014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318142", "318142014", "story_v_out_318142.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318142", "318142014", "story_v_out_318142.awb")
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
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318142015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play318142016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1199ui_story"]) and arg_61_1.var_.characterEffect1199ui_story == nil then
				arg_61_1.var_.characterEffect1199ui_story = arg_61_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1199ui_story"]) then
				if arg_61_1.var_.characterEffect1199ui_story and not isNil(arg_61_1.actors_["1199ui_story"]) then
					arg_61_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1199ui_story"]) and arg_61_1.var_.characterEffect1199ui_story then
				arg_61_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 1.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(318142015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 56 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 56)

				if (56 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 56)) > 0 and var_64_2 < var_64_5 then
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
	Play318142016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318142016
		arg_65_1.duration_ = 8.73

		local var_65_0 = {
			zh = 8.733,
			ja = 6.8
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
				arg_65_0:Play318142017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) and arg_65_1.var_.characterEffect1199ui_story == nil then
				arg_65_1.var_.characterEffect1199ui_story = arg_65_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) then
				if arg_65_1.var_.characterEffect1199ui_story and not isNil(arg_65_1.actors_["1199ui_story"]) then
					arg_65_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) and arg_65_1.var_.characterEffect1199ui_story then
				arg_65_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_2 = 0
			local var_68_3 = 1.025

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(318142016)
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

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142016", "story_v_out_318142.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142016", "story_v_out_318142.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_318142", "318142016", "story_v_out_318142.awb")

						arg_65_1:RecordAudio("318142016", var_68_9)
						arg_65_1:RecordAudio("318142016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318142", "318142016", "story_v_out_318142.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318142", "318142016", "story_v_out_318142.awb")
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
	Play318142017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318142017
		arg_69_1.duration_ = 5.53

		local var_69_0 = {
			zh = 3.2,
			ja = 5.533
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
				arg_69_0:Play318142018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1199ui_story"]) and arg_69_1.var_.characterEffect1199ui_story == nil then
				arg_69_1.var_.characterEffect1199ui_story = arg_69_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1199ui_story"]) then
				if arg_69_1.var_.characterEffect1199ui_story and not isNil(arg_69_1.actors_["1199ui_story"]) then
					arg_69_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1199ui_story"]) and arg_69_1.var_.characterEffect1199ui_story then
				arg_69_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_72_2 = 0
			local var_72_3 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(318142017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 16 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 16)

				if (16 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 16)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142017", "story_v_out_318142.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142017", "story_v_out_318142.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_318142", "318142017", "story_v_out_318142.awb")

						arg_69_1:RecordAudio("318142017", var_72_9)
						arg_69_1:RecordAudio("318142017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_318142", "318142017", "story_v_out_318142.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_318142", "318142017", "story_v_out_318142.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318142018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318142018
		arg_73_1.duration_ = 6.57

		local var_73_0 = {
			zh = 4.066,
			ja = 6.566
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
				arg_73_0:Play318142019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1150ui_story = arg_73_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).z)
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles = arg_73_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_73_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1150ui_story"].transform.position).z)
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1150ui_story"].transform.localEulerAngles = arg_73_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1150ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1150ui_story == nil then
				arg_73_1.var_.characterEffect1150ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1150ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1150ui_story then
				arg_73_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = arg_73_1.actors_["1199ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1199ui_story = var_76_4.localPosition
			end

			local var_76_5 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 then
				var_76_4.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_5)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				var_76_4.localPosition = Vector3.New(0, 100, 0)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			local var_76_6 = arg_73_1.actors_["1199ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1199ui_story == nil then
				arg_73_1.var_.characterEffect1199ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_7 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 and not isNil(var_76_6) then
				if arg_73_1.var_.characterEffect1199ui_story and not isNil(var_76_6) then
					arg_73_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_7)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1199ui_story then
				arg_73_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_76_8 = 0
			local var_76_9 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(318142018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 20 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 20)

				if (20 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 20)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142018", "story_v_out_318142.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142018", "story_v_out_318142.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_318142", "318142018", "story_v_out_318142.awb")

						arg_73_1:RecordAudio("318142018", var_76_15)
						arg_73_1:RecordAudio("318142018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318142", "318142018", "story_v_out_318142.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318142", "318142018", "story_v_out_318142.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318142019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318142019
		arg_77_1.duration_ = 8.53

		local var_77_0 = {
			zh = 7.366,
			ja = 8.533
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
				arg_77_0:Play318142020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1093ui_story = arg_77_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1093ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["1150ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1150ui_story = var_80_4.localPosition
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1150ui_story, Vector3.New(-0.7, -1.01, -6.2), (arg_77_1.time_ - 0) / var_80_5)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(-0.7, -1.01, -6.2)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			local var_80_6 = arg_77_1.actors_["1150ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1150ui_story == nil then
				arg_77_1.var_.characterEffect1150ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect1150ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1150ui_story then
				arg_77_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_80_8 = 0
			local var_80_9 = 0.85

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(318142019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 34 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 34)

				if (34 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 34)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142019", "story_v_out_318142.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142019", "story_v_out_318142.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_318142", "318142019", "story_v_out_318142.awb")

						arg_77_1:RecordAudio("318142019", var_80_15)
						arg_77_1:RecordAudio("318142019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318142", "318142019", "story_v_out_318142.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318142", "318142019", "story_v_out_318142.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318142020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318142020
		arg_81_1.duration_ = 12.9

		local var_81_0 = {
			zh = 12.9,
			ja = 10.766
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
				arg_81_0:Play318142021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1199ui_story = arg_81_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).z)
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles = arg_81_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_81_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1199ui_story"].transform.position).z)
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1199ui_story"].transform.localEulerAngles = arg_81_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1199ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1199ui_story == nil then
				arg_81_1.var_.characterEffect1199ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1199ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1199ui_story then
				arg_81_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["1093ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(0, 100, 0)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			local var_84_6 = arg_81_1.actors_["1093ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_7 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 and not isNil(var_84_6) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_6) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_7)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_84_8 = arg_81_1.actors_["1150ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1150ui_story = var_84_8.localPosition
			end

			local var_84_9 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_9)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, 100, 0)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			local var_84_10 = 0
			local var_84_11 = 1.225

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_12 = arg_81_1:GetWordFromCfg(318142020)
				local var_84_13 = arg_81_1:FormatText(var_84_12.content)

				arg_81_1.text_.text = var_84_13

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 49 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 49)

				if (49 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 49)) > 0 and var_84_11 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_13
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142020", "story_v_out_318142.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_318142", "318142020", "story_v_out_318142.awb") / 1000

					if var_84_16 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_10
					end

					if var_84_12.prefab_name ~= "" and arg_81_1.actors_[var_84_12.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_12.prefab_name].transform, "story_v_out_318142", "318142020", "story_v_out_318142.awb")

						arg_81_1:RecordAudio("318142020", var_84_17)
						arg_81_1:RecordAudio("318142020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318142", "318142020", "story_v_out_318142.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318142", "318142020", "story_v_out_318142.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_18 and arg_81_1.time_ < var_84_10 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318142021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318142021
		arg_85_1.duration_ = 10.4

		local var_85_0 = {
			zh = 10.4,
			ja = 4
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
				arg_85_0:Play318142022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_88_0 = 0
			local var_88_1 = 1.3

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(318142021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 52 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 52)

				if (52 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 52)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142021", "story_v_out_318142.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_out_318142", "318142021", "story_v_out_318142.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_out_318142", "318142021", "story_v_out_318142.awb")

						arg_85_1:RecordAudio("318142021", var_88_7)
						arg_85_1:RecordAudio("318142021", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_318142", "318142021", "story_v_out_318142.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_318142", "318142021", "story_v_out_318142.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play318142022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318142022
		arg_89_1.duration_ = 7.57

		local var_89_0 = {
			zh = 4.9,
			ja = 7.566
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
				arg_89_0:Play318142023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1150ui_story = arg_89_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).z)
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles = arg_89_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_89_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1150ui_story"].transform.position).z)
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1150ui_story"].transform.localEulerAngles = arg_89_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1150ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1150ui_story == nil then
				arg_89_1.var_.characterEffect1150ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1150ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1150ui_story then
				arg_89_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["1199ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1199ui_story = var_92_4.localPosition
			end

			local var_92_5 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_4.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_5)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_4.localPosition = Vector3.New(0, 100, 0)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			local var_92_6 = arg_89_1.actors_["1199ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1199ui_story == nil then
				arg_89_1.var_.characterEffect1199ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 and not isNil(var_92_6) then
				if arg_89_1.var_.characterEffect1199ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_7)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1199ui_story then
				arg_89_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_92_8 = 0
			local var_92_9 = 0.55

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(318142022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 22 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 22)

				if (22 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 22)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142022", "story_v_out_318142.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142022", "story_v_out_318142.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_318142", "318142022", "story_v_out_318142.awb")

						arg_89_1:RecordAudio("318142022", var_92_15)
						arg_89_1:RecordAudio("318142022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318142", "318142022", "story_v_out_318142.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318142", "318142022", "story_v_out_318142.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318142023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318142023
		arg_93_1.duration_ = 6.2

		local var_93_0 = {
			zh = 4.066,
			ja = 6.2
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
				arg_93_0:Play318142024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = arg_93_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).z)
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles = arg_93_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_93_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).z)
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles = arg_93_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1093ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["1150ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1150ui_story = var_96_4.localPosition
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_4.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_4.localPosition = Vector3.New(0, 100, 0)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			local var_96_6 = arg_93_1.actors_["1150ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1150ui_story == nil then
				arg_93_1.var_.characterEffect1150ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect1150ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1150ui_story then
				arg_93_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_96_8 = 0
			local var_96_9 = 0.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(318142023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 22 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 22)

				if (22 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 22)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142023", "story_v_out_318142.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142023", "story_v_out_318142.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_318142", "318142023", "story_v_out_318142.awb")

						arg_93_1:RecordAudio("318142023", var_96_15)
						arg_93_1:RecordAudio("318142023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318142", "318142023", "story_v_out_318142.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318142", "318142023", "story_v_out_318142.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318142024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318142024
		arg_97_1.duration_ = 10.1

		local var_97_0 = {
			zh = 4.866,
			ja = 10.1
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
				arg_97_0:Play318142025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1199ui_story = arg_97_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).z)
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles = arg_97_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_97_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1199ui_story"].transform.position).z)
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1199ui_story"].transform.localEulerAngles = arg_97_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1199ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1199ui_story == nil then
				arg_97_1.var_.characterEffect1199ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1199ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1199ui_story then
				arg_97_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = arg_97_1.actors_["1093ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1093ui_story = var_100_4.localPosition
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_4.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_4.localPosition = Vector3.New(0, 100, 0)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			local var_100_6 = arg_97_1.actors_["1093ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect1093ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1093ui_story then
				arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_100_8 = 0
			local var_100_9 = 0.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(318142024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 24 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 24)

				if (24 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 24)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142024", "story_v_out_318142.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142024", "story_v_out_318142.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_318142", "318142024", "story_v_out_318142.awb")

						arg_97_1:RecordAudio("318142024", var_100_15)
						arg_97_1:RecordAudio("318142024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318142", "318142024", "story_v_out_318142.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318142", "318142024", "story_v_out_318142.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318142025
		arg_101_1.duration_ = 9.43

		local var_101_0 = {
			zh = 9.433,
			ja = 7.6
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
				arg_101_0:Play318142026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.125

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(318142025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 46 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 46)

				if (46 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 46)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142025", "story_v_out_318142.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_318142", "318142025", "story_v_out_318142.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_318142", "318142025", "story_v_out_318142.awb")

						arg_101_1:RecordAudio("318142025", var_104_6)
						arg_101_1:RecordAudio("318142025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318142", "318142025", "story_v_out_318142.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318142", "318142025", "story_v_out_318142.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318142026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318142026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318142027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) and arg_105_1.var_.characterEffect1199ui_story == nil then
				arg_105_1.var_.characterEffect1199ui_story = arg_105_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) then
				if arg_105_1.var_.characterEffect1199ui_story and not isNil(arg_105_1.actors_["1199ui_story"]) then
					arg_105_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) and arg_105_1.var_.characterEffect1199ui_story then
				arg_105_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.925

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(318142026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 37 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 37)

				if (37 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 37)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318142027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318142027
		arg_109_1.duration_ = 5.97

		local var_109_0 = {
			zh = 2.666,
			ja = 5.966
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
				arg_109_0:Play318142028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_112_0 = arg_109_1.actors_["1199ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1199ui_story == nil then
				arg_109_1.var_.characterEffect1199ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_1 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(var_112_0) then
				if arg_109_1.var_.characterEffect1199ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1199ui_story then
				arg_109_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_112_3 = 0
			local var_112_4 = 0.275

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(318142027)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 11 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 11)

				if (11 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 11)) > 0 and var_112_4 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142027", "story_v_out_318142.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_318142", "318142027", "story_v_out_318142.awb") / 1000

					if var_112_9 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_3
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_318142", "318142027", "story_v_out_318142.awb")

						arg_109_1:RecordAudio("318142027", var_112_10)
						arg_109_1:RecordAudio("318142027", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318142", "318142027", "story_v_out_318142.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318142", "318142027", "story_v_out_318142.awb")
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
	Play318142028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318142028
		arg_113_1.duration_ = 4.3

		local var_113_0 = {
			zh = 4.233,
			ja = 4.3
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
				arg_113_0:Play318142029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1150ui_story = arg_113_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1150ui_story, Vector3.New(0.7, -1.01, -6.2), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).z)
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles = arg_113_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.2)
				arg_113_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1150ui_story"].transform.position).z)
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1150ui_story"].transform.localEulerAngles = arg_113_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1150ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1150ui_story == nil then
				arg_113_1.var_.characterEffect1150ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1150ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1150ui_story then
				arg_113_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_4 = arg_113_1.actors_["1199ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1199ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			local var_116_6 = arg_113_1.actors_["1199ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1199ui_story == nil then
				arg_113_1.var_.characterEffect1199ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect1199ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1199ui_story then
				arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_116_8 = 0
			local var_116_9 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(318142028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)

				if (22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142028", "story_v_out_318142.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142028", "story_v_out_318142.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_318142", "318142028", "story_v_out_318142.awb")

						arg_113_1:RecordAudio("318142028", var_116_15)
						arg_113_1:RecordAudio("318142028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318142", "318142028", "story_v_out_318142.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318142", "318142028", "story_v_out_318142.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318142029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318142029
		arg_117_1.duration_ = 11.8

		local var_117_0 = {
			zh = 6.633,
			ja = 11.8
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
				arg_117_0:Play318142030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1199ui_story"]) and arg_117_1.var_.characterEffect1199ui_story == nil then
				arg_117_1.var_.characterEffect1199ui_story = arg_117_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1199ui_story"]) then
				if arg_117_1.var_.characterEffect1199ui_story and not isNil(arg_117_1.actors_["1199ui_story"]) then
					arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1199ui_story"]) and arg_117_1.var_.characterEffect1199ui_story then
				arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1150ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1150ui_story == nil then
				arg_117_1.var_.characterEffect1150ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1150ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1150ui_story then
				arg_117_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.825

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(318142029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 33 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 33)

				if (33 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 33)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142029", "story_v_out_318142.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142029", "story_v_out_318142.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_318142", "318142029", "story_v_out_318142.awb")

						arg_117_1:RecordAudio("318142029", var_120_11)
						arg_117_1:RecordAudio("318142029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318142", "318142029", "story_v_out_318142.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318142", "318142029", "story_v_out_318142.awb")
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

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play318142030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318142030
		arg_121_1.duration_ = 3.33

		local var_121_0 = {
			zh = 1.6,
			ja = 3.333
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
				arg_121_0:Play318142031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1150ui_story"]) and arg_121_1.var_.characterEffect1150ui_story == nil then
				arg_121_1.var_.characterEffect1150ui_story = arg_121_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1150ui_story"]) then
				if arg_121_1.var_.characterEffect1150ui_story and not isNil(arg_121_1.actors_["1150ui_story"]) then
					arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1150ui_story"]) and arg_121_1.var_.characterEffect1150ui_story then
				arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1199ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1199ui_story then
				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(318142030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 8 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 8)

				if (8 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 8)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142030", "story_v_out_318142.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142030", "story_v_out_318142.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_318142", "318142030", "story_v_out_318142.awb")

						arg_121_1:RecordAudio("318142030", var_124_11)
						arg_121_1:RecordAudio("318142030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318142", "318142030", "story_v_out_318142.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318142", "318142030", "story_v_out_318142.awb")
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

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play318142031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318142031
		arg_125_1.duration_ = 7.97

		local var_125_0 = {
			zh = 7.966,
			ja = 4.533
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
				arg_125_0:Play318142032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) and arg_125_1.var_.characterEffect1199ui_story == nil then
				arg_125_1.var_.characterEffect1199ui_story = arg_125_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) then
				if arg_125_1.var_.characterEffect1199ui_story and not isNil(arg_125_1.actors_["1199ui_story"]) then
					arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) and arg_125_1.var_.characterEffect1199ui_story then
				arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1150ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1150ui_story == nil then
				arg_125_1.var_.characterEffect1150ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1150ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1150ui_story then
				arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_128_4 = 0
			local var_128_5 = 0.825

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(318142031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 33 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 33)

				if (33 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 33)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142031", "story_v_out_318142.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142031", "story_v_out_318142.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_318142", "318142031", "story_v_out_318142.awb")

						arg_125_1:RecordAudio("318142031", var_128_11)
						arg_125_1:RecordAudio("318142031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318142", "318142031", "story_v_out_318142.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318142", "318142031", "story_v_out_318142.awb")
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
	Play318142032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318142032
		arg_129_1.duration_ = 1.43

		local var_129_0 = {
			zh = 1.433,
			ja = 1.066
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
				arg_129_0:Play318142033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1150ui_story"]) and arg_129_1.var_.characterEffect1150ui_story == nil then
				arg_129_1.var_.characterEffect1150ui_story = arg_129_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1150ui_story"]) then
				if arg_129_1.var_.characterEffect1150ui_story and not isNil(arg_129_1.actors_["1150ui_story"]) then
					arg_129_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1150ui_story"]) and arg_129_1.var_.characterEffect1150ui_story then
				arg_129_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["1199ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1199ui_story == nil then
				arg_129_1.var_.characterEffect1199ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1199ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1199ui_story then
				arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(318142032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 5 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 5)

				if (5 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 5)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142032", "story_v_out_318142.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142032", "story_v_out_318142.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_318142", "318142032", "story_v_out_318142.awb")

						arg_129_1:RecordAudio("318142032", var_132_11)
						arg_129_1:RecordAudio("318142032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318142", "318142032", "story_v_out_318142.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318142", "318142032", "story_v_out_318142.awb")
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
	Play318142033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318142033
		arg_133_1.duration_ = 8.37

		local var_133_0 = {
			zh = 5.366,
			ja = 8.366
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
				arg_133_0:Play318142034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1199ui_story"]) and arg_133_1.var_.characterEffect1199ui_story == nil then
				arg_133_1.var_.characterEffect1199ui_story = arg_133_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1199ui_story"]) then
				if arg_133_1.var_.characterEffect1199ui_story and not isNil(arg_133_1.actors_["1199ui_story"]) then
					arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1199ui_story"]) and arg_133_1.var_.characterEffect1199ui_story then
				arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action6_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_136_2 = arg_133_1.actors_["1150ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1150ui_story == nil then
				arg_133_1.var_.characterEffect1150ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1150ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1150ui_story then
				arg_133_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.45

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(318142033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 18 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 18)

				if (18 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 18)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142033", "story_v_out_318142.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142033", "story_v_out_318142.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_318142", "318142033", "story_v_out_318142.awb")

						arg_133_1:RecordAudio("318142033", var_136_11)
						arg_133_1:RecordAudio("318142033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318142", "318142033", "story_v_out_318142.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318142", "318142033", "story_v_out_318142.awb")
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
	Play318142034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318142034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318142035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1199ui_story"]) and arg_137_1.var_.characterEffect1199ui_story == nil then
				arg_137_1.var_.characterEffect1199ui_story = arg_137_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1199ui_story"]) then
				if arg_137_1.var_.characterEffect1199ui_story and not isNil(arg_137_1.actors_["1199ui_story"]) then
					arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1199ui_story"]) and arg_137_1.var_.characterEffect1199ui_story then
				arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.925

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(318142034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 37 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 37)

				if (37 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 37)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play318142035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318142035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318142036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(318142035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 74 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 74)

				if (74 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 74)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play318142036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318142036
		arg_145_1.duration_ = 4.27

		local var_145_0 = {
			zh = 3.1,
			ja = 4.266
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
				arg_145_0:Play318142037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1150ui_story"]) and arg_145_1.var_.characterEffect1150ui_story == nil then
				arg_145_1.var_.characterEffect1150ui_story = arg_145_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1150ui_story"]) then
				if arg_145_1.var_.characterEffect1150ui_story and not isNil(arg_145_1.actors_["1150ui_story"]) then
					arg_145_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1150ui_story"]) and arg_145_1.var_.characterEffect1150ui_story then
				arg_145_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(318142036)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 16 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 16)

				if (16 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 16)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142036", "story_v_out_318142.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142036", "story_v_out_318142.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_318142", "318142036", "story_v_out_318142.awb")

						arg_145_1:RecordAudio("318142036", var_148_9)
						arg_145_1:RecordAudio("318142036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318142", "318142036", "story_v_out_318142.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318142", "318142036", "story_v_out_318142.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play318142037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318142037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318142038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1150ui_story"]) and arg_149_1.var_.characterEffect1150ui_story == nil then
				arg_149_1.var_.characterEffect1150ui_story = arg_149_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1150ui_story"]) then
				if arg_149_1.var_.characterEffect1150ui_story and not isNil(arg_149_1.actors_["1150ui_story"]) then
					arg_149_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1150ui_story"]) and arg_149_1.var_.characterEffect1150ui_story then
				arg_149_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_2")
			end

			local var_152_1 = 0
			local var_152_2 = 1.125

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(318142037).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 45 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 45)

				if (45 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 45)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318142038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318142038
		arg_153_1.duration_ = 8.73

		local var_153_0 = {
			zh = 8.733,
			ja = 7.1
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
				arg_153_0:Play318142039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1150ui_story"]) and arg_153_1.var_.characterEffect1150ui_story == nil then
				arg_153_1.var_.characterEffect1150ui_story = arg_153_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1150ui_story"]) then
				if arg_153_1.var_.characterEffect1150ui_story and not isNil(arg_153_1.actors_["1150ui_story"]) then
					arg_153_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1150ui_story"]) and arg_153_1.var_.characterEffect1150ui_story then
				arg_153_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_156_2 = 0
			local var_156_3 = 0.875

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(318142038)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 35 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 35)

				if (35 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 35)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142038", "story_v_out_318142.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142038", "story_v_out_318142.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_318142", "318142038", "story_v_out_318142.awb")

						arg_153_1:RecordAudio("318142038", var_156_9)
						arg_153_1:RecordAudio("318142038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318142", "318142038", "story_v_out_318142.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318142", "318142038", "story_v_out_318142.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318142039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318142039
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318142040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1199ui_story"]) and arg_157_1.var_.characterEffect1199ui_story == nil then
				arg_157_1.var_.characterEffect1199ui_story = arg_157_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1199ui_story"]) then
				if arg_157_1.var_.characterEffect1199ui_story and not isNil(arg_157_1.actors_["1199ui_story"]) then
					arg_157_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1199ui_story"]) and arg_157_1.var_.characterEffect1199ui_story then
				arg_157_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action6_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_160_2 = arg_157_1.actors_["1150ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1150ui_story == nil then
				arg_157_1.var_.characterEffect1150ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect1150ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1150ui_story then
				arg_157_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_160_4 = 0
			local var_160_5 = 0.075

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(318142039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 3 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 3)

				if (3 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 3)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142039", "story_v_out_318142.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142039", "story_v_out_318142.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_318142", "318142039", "story_v_out_318142.awb")

						arg_157_1:RecordAudio("318142039", var_160_11)
						arg_157_1:RecordAudio("318142039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_318142", "318142039", "story_v_out_318142.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_318142", "318142039", "story_v_out_318142.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318142040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318142040
		arg_161_1.duration_ = 11.33

		local var_161_0 = {
			zh = 7.033,
			ja = 11.333
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
				arg_161_0:Play318142041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1093ui_story = arg_161_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1093ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story == nil then
				arg_161_1.var_.characterEffect1093ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1093ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story then
				arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["1199ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1199ui_story = var_164_4.localPosition
			end

			local var_164_5 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 then
				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_5)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0, 100, 0)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			local var_164_6 = arg_161_1.actors_["1199ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1199ui_story == nil then
				arg_161_1.var_.characterEffect1199ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect1199ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1199ui_story then
				arg_161_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_164_8 = arg_161_1.actors_["1150ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1150ui_story = var_164_8.localPosition
			end

			local var_164_9 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 then
				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1150ui_story, Vector3.New(-0.7, -1.01, -6.2), (arg_161_1.time_ - 0) / var_164_9)
				var_164_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_8.position).x, (manager.ui.mainCamera.transform.position - var_164_8.position).y, (manager.ui.mainCamera.transform.position - var_164_8.position).z)
				var_164_8.localEulerAngles.z = 0
				var_164_8.localEulerAngles.x = 0
				var_164_8.localEulerAngles = var_164_8.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(-0.7, -1.01, -6.2)
				var_164_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_8.position).x, (manager.ui.mainCamera.transform.position - var_164_8.position).y, (manager.ui.mainCamera.transform.position - var_164_8.position).z)
				var_164_8.localEulerAngles.z = 0
				var_164_8.localEulerAngles.x = 0
				var_164_8.localEulerAngles = var_164_8.localEulerAngles
			end

			local var_164_10 = 0
			local var_164_11 = 0.925

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_12 = arg_161_1:GetWordFromCfg(318142040)
				local var_164_13 = arg_161_1:FormatText(var_164_12.content)

				arg_161_1.text_.text = var_164_13

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 37 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 37)

				if (37 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 37)) > 0 and var_164_11 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_13
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142040", "story_v_out_318142.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_318142", "318142040", "story_v_out_318142.awb") / 1000

					if var_164_16 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_10
					end

					if var_164_12.prefab_name ~= "" and arg_161_1.actors_[var_164_12.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_12.prefab_name].transform, "story_v_out_318142", "318142040", "story_v_out_318142.awb")

						arg_161_1:RecordAudio("318142040", var_164_17)
						arg_161_1:RecordAudio("318142040", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318142", "318142040", "story_v_out_318142.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318142", "318142040", "story_v_out_318142.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_18 and arg_161_1.time_ < var_164_10 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318142041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318142041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318142042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story == nil then
				arg_165_1.var_.characterEffect1093ui_story = arg_165_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) then
				if arg_165_1.var_.characterEffect1093ui_story and not isNil(arg_165_1.actors_["1093ui_story"]) then
					arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story then
				arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 1.325

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

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(318142041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 53 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 53)

				if (53 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 53)) > 0 and var_168_2 < var_168_5 then
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
	Play318142042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318142042
		arg_169_1.duration_ = 5.83

		local var_169_0 = {
			zh = 4.233,
			ja = 5.833
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
				arg_169_0:Play318142043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1150ui_story"]) and arg_169_1.var_.characterEffect1150ui_story == nil then
				arg_169_1.var_.characterEffect1150ui_story = arg_169_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1150ui_story"]) then
				if arg_169_1.var_.characterEffect1150ui_story and not isNil(arg_169_1.actors_["1150ui_story"]) then
					arg_169_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1150ui_story"]) and arg_169_1.var_.characterEffect1150ui_story then
				arg_169_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_172_2 = 0
			local var_172_3 = 0.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(318142042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 20 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 20)

				if (20 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 20)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142042", "story_v_out_318142.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142042", "story_v_out_318142.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_318142", "318142042", "story_v_out_318142.awb")

						arg_169_1:RecordAudio("318142042", var_172_9)
						arg_169_1:RecordAudio("318142042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_318142", "318142042", "story_v_out_318142.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_318142", "318142042", "story_v_out_318142.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play318142043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318142043
		arg_173_1.duration_ = 7.97

		local var_173_0 = {
			zh = 5.866,
			ja = 7.966
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
				arg_173_0:Play318142044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = arg_173_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) then
				if arg_173_1.var_.characterEffect1093ui_story and not isNil(arg_173_1.actors_["1093ui_story"]) then
					arg_173_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) and arg_173_1.var_.characterEffect1093ui_story then
				arg_173_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_176_2 = "1050ui_story"

			if arg_173_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_176_3 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_173_1.stage_.transform)

				var_176_3.name = var_176_2
				var_176_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_[var_176_2] = var_176_3

				local var_176_4 = var_176_3:GetComponentInChildren(typeof(CharacterEffect))

				var_176_4.enabled = true

				local var_176_5 = GameObjectTools.GetOrAddComponent(var_176_3, typeof(DynamicBoneHelper))

				if var_176_5 then
					var_176_5:EnableDynamicBone(false)
				end

				arg_173_1:ShowWeapon(var_176_4.transform, false)

				arg_173_1.var_[var_176_2 .. "Animator"] = var_176_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_173_1.var_[var_176_2 .. "Animator"].applyRootMotion = true
				arg_173_1.var_[var_176_2 .. "LipSync"] = var_176_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_176_6 = arg_173_1.actors_["1050ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1050ui_story == nil then
				arg_173_1.var_.characterEffect1050ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect1050ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1050ui_story then
				arg_173_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_176_8 = 0
			local var_176_9 = 0.7

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(318142043)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 28 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 28)

				if (28 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 28)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142043", "story_v_out_318142.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142043", "story_v_out_318142.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_318142", "318142043", "story_v_out_318142.awb")

						arg_173_1:RecordAudio("318142043", var_176_15)
						arg_173_1:RecordAudio("318142043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318142", "318142043", "story_v_out_318142.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318142", "318142043", "story_v_out_318142.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play318142044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318142044
		arg_177_1.duration_ = 8.9

		local var_177_0 = {
			zh = 6.9,
			ja = 8.9
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
				arg_177_0:Play318142045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1150ui_story = arg_177_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).z)
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles = arg_177_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_177_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1150ui_story"].transform.position).z)
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1150ui_story"].transform.localEulerAngles = arg_177_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1150ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1150ui_story == nil then
				arg_177_1.var_.characterEffect1150ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1150ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1150ui_story then
				arg_177_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_180_4 = arg_177_1.actors_["1093ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1093ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(0, 100, 0)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			local var_180_6 = arg_177_1.actors_["1093ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1093ui_story == nil then
				arg_177_1.var_.characterEffect1093ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect1093ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1093ui_story then
				arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_180_8 = 0
			local var_180_9 = 0.85

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(318142044)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 34 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 34)

				if (34 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 34)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142044", "story_v_out_318142.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_318142", "318142044", "story_v_out_318142.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_318142", "318142044", "story_v_out_318142.awb")

						arg_177_1:RecordAudio("318142044", var_180_15)
						arg_177_1:RecordAudio("318142044", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_318142", "318142044", "story_v_out_318142.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_318142", "318142044", "story_v_out_318142.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318142045
		arg_181_1.duration_ = 5.2

		local var_181_0 = {
			zh = 2.6,
			ja = 5.2
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
				arg_181_0:Play318142046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1199ui_story = arg_181_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1199ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story == nil then
				arg_181_1.var_.characterEffect1199ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1199ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story then
				arg_181_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_4 = arg_181_1.actors_["1150ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1150ui_story = var_184_4.localPosition
			end

			local var_184_5 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 then
				var_184_4.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1150ui_story, Vector3.New(-0.7, -1.01, -6.2), (arg_181_1.time_ - 0) / var_184_5)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 then
				var_184_4.localPosition = Vector3.New(-0.7, -1.01, -6.2)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			local var_184_6 = arg_181_1.actors_["1150ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1150ui_story == nil then
				arg_181_1.var_.characterEffect1150ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_7 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 and not isNil(var_184_6) then
				if arg_181_1.var_.characterEffect1150ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_7)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1150ui_story then
				arg_181_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_184_8 = "1093ui_tpose"

			if arg_181_1.actors_["1093ui_tpose"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_tpose"))) then
				local var_184_9 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_tpose"), arg_181_1.stage_.transform)

				var_184_9.name = var_184_8
				var_184_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_[var_184_8] = var_184_9

				local var_184_10 = var_184_9:GetComponentInChildren(typeof(CharacterEffect))

				var_184_10.enabled = true

				local var_184_11 = GameObjectTools.GetOrAddComponent(var_184_9, typeof(DynamicBoneHelper))

				if var_184_11 then
					var_184_11:EnableDynamicBone(false)
				end

				arg_181_1:ShowWeapon(var_184_10.transform, false)

				arg_181_1.var_[var_184_8 .. "Animator"] = var_184_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_181_1.var_[var_184_8 .. "Animator"].applyRootMotion = true
				arg_181_1.var_[var_184_8 .. "LipSync"] = var_184_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_184_12 = arg_181_1.actors_["1093ui_tpose"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1093ui_tpose = var_184_12.localPosition
			end

			local var_184_13 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_13 then
				var_184_12.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1093ui_tpose, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_13)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_13 and arg_181_1.time_ < 0 + var_184_13 + arg_184_0 then
				var_184_12.localPosition = Vector3.New(0, 100, 0)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			local var_184_14 = 0
			local var_184_15 = 0.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_16 = arg_181_1:GetWordFromCfg(318142045)
				local var_184_17 = arg_181_1:FormatText(var_184_16.content)

				arg_181_1.text_.text = var_184_17

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_19 = 7 <= 0 and var_184_15 or var_184_15 * (utf8.len(var_184_17) / 7)

				if (7 <= 0 and var_184_15 or var_184_15 * (utf8.len(var_184_17) / 7)) > 0 and var_184_15 < var_184_19 then
					arg_181_1.talkMaxDuration = var_184_19

					if var_184_19 + var_184_14 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_14
					end
				end

				arg_181_1.text_.text = var_184_17
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142045", "story_v_out_318142.awb") ~= 0 then
					local var_184_20 = manager.audio:GetVoiceLength("story_v_out_318142", "318142045", "story_v_out_318142.awb") / 1000

					if var_184_20 + var_184_14 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_20 + var_184_14
					end

					if var_184_16.prefab_name ~= "" and arg_181_1.actors_[var_184_16.prefab_name] ~= nil then
						local var_184_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_16.prefab_name].transform, "story_v_out_318142", "318142045", "story_v_out_318142.awb")

						arg_181_1:RecordAudio("318142045", var_184_21)
						arg_181_1:RecordAudio("318142045", var_184_21)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_318142", "318142045", "story_v_out_318142.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_318142", "318142045", "story_v_out_318142.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = math.max(var_184_15, arg_181_1.talkMaxDuration)

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_22 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_14) / var_184_22

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_14 + var_184_22 and arg_181_1.time_ < var_184_14 + var_184_22 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_tpose",
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
	Play318142046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318142046
		arg_185_1.duration_ = 7.1

		local var_185_0 = {
			zh = 7.1,
			ja = 6.3
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
				arg_185_0:Play318142047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(318142046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 35 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 35)

				if (35 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 35)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142046", "story_v_out_318142.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_318142", "318142046", "story_v_out_318142.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_318142", "318142046", "story_v_out_318142.awb")

						arg_185_1:RecordAudio("318142046", var_188_6)
						arg_185_1:RecordAudio("318142046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_318142", "318142046", "story_v_out_318142.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_318142", "318142046", "story_v_out_318142.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play318142047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318142047
		arg_189_1.duration_ = 7.7

		local var_189_0 = {
			zh = 3.7,
			ja = 7.7
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
				arg_189_0:Play318142048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.55

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(318142047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 22 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 22)

				if (22 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 22)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142047", "story_v_out_318142.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_318142", "318142047", "story_v_out_318142.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_318142", "318142047", "story_v_out_318142.awb")

						arg_189_1:RecordAudio("318142047", var_192_6)
						arg_189_1:RecordAudio("318142047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318142", "318142047", "story_v_out_318142.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318142", "318142047", "story_v_out_318142.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play318142048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318142048
		arg_193_1.duration_ = 4

		local var_193_0 = {
			zh = 2.733,
			ja = 4
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
				arg_193_0:Play318142049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1150ui_story"]) and arg_193_1.var_.characterEffect1150ui_story == nil then
				arg_193_1.var_.characterEffect1150ui_story = arg_193_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1150ui_story"]) then
				if arg_193_1.var_.characterEffect1150ui_story and not isNil(arg_193_1.actors_["1150ui_story"]) then
					arg_193_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1150ui_story"]) and arg_193_1.var_.characterEffect1150ui_story then
				arg_193_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_196_2 = arg_193_1.actors_["1199ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1199ui_story == nil then
				arg_193_1.var_.characterEffect1199ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect1199ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1199ui_story then
				arg_193_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(318142048)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 14 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 14)

				if (14 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 14)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142048", "story_v_out_318142.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142048", "story_v_out_318142.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_318142", "318142048", "story_v_out_318142.awb")

						arg_193_1:RecordAudio("318142048", var_196_11)
						arg_193_1:RecordAudio("318142048", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_318142", "318142048", "story_v_out_318142.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_318142", "318142048", "story_v_out_318142.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play318142049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318142049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318142050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1150ui_story = arg_197_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).z)
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles = arg_197_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1150ui_story"].transform.position).z)
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1150ui_story"].transform.localEulerAngles = arg_197_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1150ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1150ui_story == nil then
				arg_197_1.var_.characterEffect1150ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1150ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_2)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1150ui_story then
				arg_197_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_200_3 = arg_197_1.actors_["1199ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1199ui_story = var_200_3.localPosition
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_3.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_4)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = Vector3.New(0, 100, 0)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			local var_200_5 = arg_197_1.actors_["1093ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1093ui_story = var_200_5.localPosition
			end

			local var_200_6 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 then
				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_197_1.time_ - 0) / var_200_6)
				var_200_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_5.position).x, (manager.ui.mainCamera.transform.position - var_200_5.position).y, (manager.ui.mainCamera.transform.position - var_200_5.position).z)
				var_200_5.localEulerAngles.z = 0
				var_200_5.localEulerAngles.x = 0
				var_200_5.localEulerAngles = var_200_5.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(0, -1.11, -5.88)
				var_200_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_5.position).x, (manager.ui.mainCamera.transform.position - var_200_5.position).y, (manager.ui.mainCamera.transform.position - var_200_5.position).z)
				var_200_5.localEulerAngles.z = 0
				var_200_5.localEulerAngles.x = 0
				var_200_5.localEulerAngles = var_200_5.localEulerAngles
			end

			local var_200_7 = arg_197_1.actors_["1093ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.characterEffect1093ui_story == nil then
				arg_197_1.var_.characterEffect1093ui_story = var_200_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_8 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_8 and not isNil(var_200_7) then
				if arg_197_1.var_.characterEffect1093ui_story and not isNil(var_200_7) then
					arg_197_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_8)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_8 and arg_197_1.time_ < 0 + var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.characterEffect1093ui_story then
				arg_197_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_200_9 = 0
			local var_200_10 = 0.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_11 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(318142049).content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 22 <= 0 and var_200_10 or var_200_10 * (utf8.len(var_200_11) / 22)

				if (22 <= 0 and var_200_10 or var_200_10 * (utf8.len(var_200_11) / 22)) > 0 and var_200_10 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_9 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_9
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_10, arg_197_1.talkMaxDuration)

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_9) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_9 + var_200_14 and arg_197_1.time_ < var_200_9 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318142050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318142050
		arg_201_1.duration_ = 7.47

		local var_201_0 = {
			zh = 3.3,
			ja = 7.466
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
				arg_201_0:Play318142051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1093ui_story"]) and arg_201_1.var_.characterEffect1093ui_story == nil then
				arg_201_1.var_.characterEffect1093ui_story = arg_201_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1093ui_story"]) then
				if arg_201_1.var_.characterEffect1093ui_story and not isNil(arg_201_1.actors_["1093ui_story"]) then
					arg_201_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1093ui_story"]) and arg_201_1.var_.characterEffect1093ui_story then
				arg_201_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_204_2 = 0
			local var_204_3 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(318142050)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 21 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 21)

				if (21 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 21)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142050", "story_v_out_318142.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_318142", "318142050", "story_v_out_318142.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_out_318142", "318142050", "story_v_out_318142.awb")

						arg_201_1:RecordAudio("318142050", var_204_9)
						arg_201_1:RecordAudio("318142050", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_318142", "318142050", "story_v_out_318142.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_318142", "318142050", "story_v_out_318142.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play318142051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318142051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play318142052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1093ui_story = arg_205_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).z)
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles = arg_205_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).z)
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles = arg_205_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1093ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1093ui_story == nil then
				arg_205_1.var_.characterEffect1093ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1093ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_2)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1093ui_story then
				arg_205_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_208_3 = 0
			local var_208_4 = 0.375

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

				local var_208_5 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(318142051).content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 15 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 15)

				if (15 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 15)) > 0 and var_208_4 < var_208_7 then
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play318142052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 318142052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play318142053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.125

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

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(318142052).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 45 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 45)

				if (45 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 45)) > 0 and var_212_0 < var_212_3 then
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
	Play318142053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 318142053
		arg_213_1.duration_ = 5

		local var_213_0 = {
			zh = 2.5,
			ja = 5
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
			arg_213_1.auto_ = false
		end

		function arg_213_1.playNext_(arg_215_0)
			arg_213_1.onStoryFinished_()
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1150ui_story = arg_213_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).z)
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles = arg_213_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_213_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1150ui_story"].transform.position).z)
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1150ui_story"].transform.localEulerAngles = arg_213_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1150ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1150ui_story == nil then
				arg_213_1.var_.characterEffect1150ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1150ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1150ui_story then
				arg_213_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.175

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(318142053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)

				if (7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318142", "318142053", "story_v_out_318142.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_318142", "318142053", "story_v_out_318142.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_318142", "318142053", "story_v_out_318142.awb")

						arg_213_1:RecordAudio("318142053", var_216_11)
						arg_213_1:RecordAudio("318142053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_318142", "318142053", "story_v_out_318142.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_318142", "318142053", "story_v_out_318142.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	assets = {
		"TextureConfig/Background/K14f"
	},
	voices = {
		"story_v_out_318142.awb"
	}
}
