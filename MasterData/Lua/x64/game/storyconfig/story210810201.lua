return {
	Play1108102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108102001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"

			SetActive(arg_1_1.choicesGo_, true)

			for iter_2_0, iter_2_1 in ipairs(arg_1_1.choices_) do
				SetActive(iter_2_1.go, iter_2_0 <= 1)
			end

			arg_1_1.choices_[1].txt.text = arg_1_1:FormatText(StoryChoiceCfg[467].name)
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108102002(arg_1_1)
			end

			arg_1_1:RecordChoiceLog(1108102001, 467)
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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

			local var_4_8 = "1081ui_story"

			if arg_1_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1081ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1081ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_1_1.time_ - 0) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1081ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1081ui_story == nil then
				arg_1_1.var_.characterEffect1081ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.0166666666666667

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1081ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 0) / var_4_15)
				end
			end

			if arg_1_1.time_ >= 0 + var_4_15 and arg_1_1.time_ < 0 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1081ui_story then
				arg_1_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108102002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1108102002
		arg_7_1.duration_ = 13.47

		local var_7_0 = {
			ja = 13.466,
			ko = 9.2,
			zh = 9.2
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1108102003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1081ui_story = arg_7_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_10_0 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				arg_7_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).z)
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles = arg_7_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				arg_7_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_7_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1081ui_story"].transform.position).z)
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["1081ui_story"].transform.localEulerAngles = arg_7_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_10_1 = arg_7_1.actors_["1081ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect1081ui_story == nil then
				arg_7_1.var_.characterEffect1081ui_story = var_10_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.0166666666666667

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_2 and not isNil(var_10_1) then
				if arg_7_1.var_.characterEffect1081ui_story and not isNil(var_10_1) then
					arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_2 and arg_7_1.time_ < 0 + var_10_2 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect1081ui_story then
				arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_10_4 = 0
			local var_10_5 = 1.25

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_6 = arg_7_1:GetWordFromCfg(1108102002)
				local var_10_7 = arg_7_1:FormatText(var_10_6.content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 50 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 50)

				if (50 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 50)) > 0 and var_10_5 < var_10_9 then
					arg_7_1.talkMaxDuration = var_10_9

					if var_10_9 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_9 + var_10_4
					end
				end

				arg_7_1.text_.text = var_10_7
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102002", "story_v_side_new_1108102.awb") ~= 0 then
					local var_10_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102002", "story_v_side_new_1108102.awb") / 1000

					if var_10_10 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_10 + var_10_4
					end

					if var_10_6.prefab_name ~= "" and arg_7_1.actors_[var_10_6.prefab_name] ~= nil then
						local var_10_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_6.prefab_name].transform, "story_v_side_new_1108102", "1108102002", "story_v_side_new_1108102.awb")

						arg_7_1:RecordAudio("1108102002", var_10_11)
						arg_7_1:RecordAudio("1108102002", var_10_11)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102002", "story_v_side_new_1108102.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102002", "story_v_side_new_1108102.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_12 = math.max(var_10_5, arg_7_1.talkMaxDuration)

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_12 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_4) / var_10_12

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_4 + var_10_12 and arg_7_1.time_ < var_10_4 + var_10_12 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play1108102003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1108102003
		arg_11_1.duration_ = 10.6

		local var_11_0 = {
			ja = 10.6,
			ko = 7.4,
			zh = 7.4
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1108102004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1081ui_story = arg_11_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).z)
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles = arg_11_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_11_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).z)
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles = arg_11_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1081ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1081ui_story == nil then
				arg_11_1.var_.characterEffect1081ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.0166666666666667

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect1081ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1081ui_story then
				arg_11_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_14_4 = 0
			local var_14_5 = 1.05

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:GetWordFromCfg(1108102003)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 42 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 42)

				if (42 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 42)) > 0 and var_14_5 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102003", "story_v_side_new_1108102.awb") ~= 0 then
					local var_14_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102003", "story_v_side_new_1108102.awb") / 1000

					if var_14_10 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_4
					end

					if var_14_6.prefab_name ~= "" and arg_11_1.actors_[var_14_6.prefab_name] ~= nil then
						local var_14_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_6.prefab_name].transform, "story_v_side_new_1108102", "1108102003", "story_v_side_new_1108102.awb")

						arg_11_1:RecordAudio("1108102003", var_14_11)
						arg_11_1:RecordAudio("1108102003", var_14_11)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102003", "story_v_side_new_1108102.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102003", "story_v_side_new_1108102.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_12 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_12 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_12

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_12 and arg_11_1.time_ < var_14_4 + var_14_12 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play1108102004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1108102004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1108102005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1081ui_story"]) and arg_15_1.var_.characterEffect1081ui_story == nil then
				arg_15_1.var_.characterEffect1081ui_story = arg_15_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.0166666666666667

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1081ui_story"]) then
				if arg_15_1.var_.characterEffect1081ui_story and not isNil(arg_15_1.actors_["1081ui_story"]) then
					arg_15_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1081ui_story"]) and arg_15_1.var_.characterEffect1081ui_story then
				arg_15_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 0.725

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(1108102004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 29 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 29)

				if (29 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 29)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play1108102005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1108102005
		arg_19_1.duration_ = 6.73

		local var_19_0 = {
			ja = 6.733,
			ko = 2.9,
			zh = 2.9
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1108102006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1081ui_story = arg_19_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).z)
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles = arg_19_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_19_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1081ui_story"].transform.position).z)
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1081ui_story"].transform.localEulerAngles = arg_19_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1081ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1081ui_story == nil then
				arg_19_1.var_.characterEffect1081ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.0166666666666667

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1081ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1081ui_story then
				arg_19_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_4 = 0
			local var_22_5 = 0.175

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(1108102005)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 7 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 7)

				if (7 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 7)) > 0 and var_22_5 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102005", "story_v_side_new_1108102.awb") ~= 0 then
					local var_22_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102005", "story_v_side_new_1108102.awb") / 1000

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end

					if var_22_6.prefab_name ~= "" and arg_19_1.actors_[var_22_6.prefab_name] ~= nil then
						local var_22_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_6.prefab_name].transform, "story_v_side_new_1108102", "1108102005", "story_v_side_new_1108102.awb")

						arg_19_1:RecordAudio("1108102005", var_22_11)
						arg_19_1:RecordAudio("1108102005", var_22_11)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102005", "story_v_side_new_1108102.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102005", "story_v_side_new_1108102.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_12 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_12 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_12

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_12 and arg_19_1.time_ < var_22_4 + var_22_12 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play1108102006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1108102006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1108102007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) and arg_23_1.var_.characterEffect1081ui_story == nil then
				arg_23_1.var_.characterEffect1081ui_story = arg_23_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.0166666666666667

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) then
				if arg_23_1.var_.characterEffect1081ui_story and not isNil(arg_23_1.actors_["1081ui_story"]) then
					arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) and arg_23_1.var_.characterEffect1081ui_story then
				arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_26_1 = 0
			local var_26_2 = 0.075

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(1108102006).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 3 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 3)

				if (3 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 3)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play1108102007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1108102007
		arg_27_1.duration_ = 2.4

		local var_27_0 = {
			ja = 2.366,
			ko = 2.4,
			zh = 2.4
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
				arg_27_0:Play1108102008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1081ui_story = arg_27_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).z)
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles = arg_27_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_27_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1081ui_story"].transform.position).z)
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1081ui_story"].transform.localEulerAngles = arg_27_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1081ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1081ui_story == nil then
				arg_27_1.var_.characterEffect1081ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.0166666666666667

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1081ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1081ui_story then
				arg_27_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_30_4 = 0
			local var_30_5 = 0.225

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(1108102007)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 9 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 9)

				if (9 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 9)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102007", "story_v_side_new_1108102.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102007", "story_v_side_new_1108102.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_side_new_1108102", "1108102007", "story_v_side_new_1108102.awb")

						arg_27_1:RecordAudio("1108102007", var_30_11)
						arg_27_1:RecordAudio("1108102007", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102007", "story_v_side_new_1108102.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102007", "story_v_side_new_1108102.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1108102008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1108102009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) and arg_31_1.var_.characterEffect1081ui_story == nil then
				arg_31_1.var_.characterEffect1081ui_story = arg_31_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.0166666666666667

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) then
				if arg_31_1.var_.characterEffect1081ui_story and not isNil(arg_31_1.actors_["1081ui_story"]) then
					arg_31_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) and arg_31_1.var_.characterEffect1081ui_story then
				arg_31_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.05

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(1108102008).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 2 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 2)

				if (2 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 2)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1108102009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1108102009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1108102010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(1108102009).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 18)

				if (18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 18)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1108102010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1108102010
		arg_39_1.duration_ = 4.03

		local var_39_0 = {
			ja = 4.033,
			ko = 3.966,
			zh = 3.966
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
				arg_39_0:Play1108102011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1081ui_story = arg_39_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).z)
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles = arg_39_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_39_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1081ui_story"].transform.position).z)
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1081ui_story"].transform.localEulerAngles = arg_39_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1081ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1081ui_story == nil then
				arg_39_1.var_.characterEffect1081ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.0166666666666667

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1081ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1081ui_story then
				arg_39_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_4 = 0
			local var_42_5 = 0.525

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(1108102010)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 21 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 21)

				if (21 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 21)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102010", "story_v_side_new_1108102.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102010", "story_v_side_new_1108102.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_side_new_1108102", "1108102010", "story_v_side_new_1108102.awb")

						arg_39_1:RecordAudio("1108102010", var_42_11)
						arg_39_1:RecordAudio("1108102010", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102010", "story_v_side_new_1108102.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102010", "story_v_side_new_1108102.awb")
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

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play1108102011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1108102011
		arg_43_1.duration_ = 5.6

		local var_43_0 = {
			ja = 5.2,
			ko = 5.6,
			zh = 5.6
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
				arg_43_0:Play1108102012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1081ui_story = arg_43_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).z)
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles = arg_43_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_43_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1081ui_story"].transform.position).z)
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1081ui_story"].transform.localEulerAngles = arg_43_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_46_1 = 0
			local var_46_2 = 0.85

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(1108102011)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 34 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 34)

				if (34 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 34)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102011", "story_v_side_new_1108102.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102011", "story_v_side_new_1108102.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_side_new_1108102", "1108102011", "story_v_side_new_1108102.awb")

						arg_43_1:RecordAudio("1108102011", var_46_8)
						arg_43_1:RecordAudio("1108102011", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102011", "story_v_side_new_1108102.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102011", "story_v_side_new_1108102.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play1108102012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1108102012
		arg_47_1.duration_ = 9.07

		local var_47_0 = {
			ja = 9.066,
			ko = 5.733,
			zh = 5.733
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
				arg_47_0:Play1108102013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1081ui_story = arg_47_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).z)
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles = arg_47_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_47_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1081ui_story"].transform.position).z)
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1081ui_story"].transform.localEulerAngles = arg_47_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_50_1 = 0
			local var_50_2 = 0.9

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(1108102012)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 36 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 36)

				if (36 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 36)) > 0 and var_50_2 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102012", "story_v_side_new_1108102.awb") ~= 0 then
					local var_50_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102012", "story_v_side_new_1108102.awb") / 1000

					if var_50_7 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_1
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_side_new_1108102", "1108102012", "story_v_side_new_1108102.awb")

						arg_47_1:RecordAudio("1108102012", var_50_8)
						arg_47_1:RecordAudio("1108102012", var_50_8)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102012", "story_v_side_new_1108102.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102012", "story_v_side_new_1108102.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_9 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_9

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_9 and arg_47_1.time_ < var_50_1 + var_50_9 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1108102013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1108102013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1108102014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1081ui_story"]) and arg_51_1.var_.characterEffect1081ui_story == nil then
				arg_51_1.var_.characterEffect1081ui_story = arg_51_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.0166666666666667

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1081ui_story"]) then
				if arg_51_1.var_.characterEffect1081ui_story and not isNil(arg_51_1.actors_["1081ui_story"]) then
					arg_51_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1081ui_story"]) and arg_51_1.var_.characterEffect1081ui_story then
				arg_51_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.275

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1108102013).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 11 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 11)

				if (11 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 11)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1108102014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1108102014
		arg_55_1.duration_ = 7.1

		local var_55_0 = {
			ja = 7.1,
			ko = 5.8,
			zh = 5.8
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
				arg_55_0:Play1108102015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1081ui_story = arg_55_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).z)
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles = arg_55_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_55_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1081ui_story"].transform.position).z)
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1081ui_story"].transform.localEulerAngles = arg_55_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1081ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1081ui_story == nil then
				arg_55_1.var_.characterEffect1081ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.0166666666666667

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1081ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1081ui_story then
				arg_55_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.7

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(1108102014)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 28 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 28)

				if (28 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 28)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102014", "story_v_side_new_1108102.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102014", "story_v_side_new_1108102.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_side_new_1108102", "1108102014", "story_v_side_new_1108102.awb")

						arg_55_1:RecordAudio("1108102014", var_58_11)
						arg_55_1:RecordAudio("1108102014", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102014", "story_v_side_new_1108102.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102014", "story_v_side_new_1108102.awb")
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

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play1108102015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1108102015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1108102016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1081ui_story"]) and arg_59_1.var_.characterEffect1081ui_story == nil then
				arg_59_1.var_.characterEffect1081ui_story = arg_59_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.0166666666666667

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1081ui_story"]) then
				if arg_59_1.var_.characterEffect1081ui_story and not isNil(arg_59_1.actors_["1081ui_story"]) then
					arg_59_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1081ui_story"]) and arg_59_1.var_.characterEffect1081ui_story then
				arg_59_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_62_1 = 0
			local var_62_2 = 0.3

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1108102015).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 12 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 12)

				if (12 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 12)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1108102016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1108102016
		arg_63_1.duration_ = 4.6

		local var_63_0 = {
			ja = 4.033,
			ko = 4.6,
			zh = 4.6
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1108102017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1081ui_story = arg_63_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).z)
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles = arg_63_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_63_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1081ui_story"].transform.position).z)
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1081ui_story"].transform.localEulerAngles = arg_63_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1081ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1081ui_story == nil then
				arg_63_1.var_.characterEffect1081ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.0166666666666667

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1081ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1081ui_story then
				arg_63_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_66_4 = 0
			local var_66_5 = 0.525

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(1108102016)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 21 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 21)

				if (21 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 21)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102016", "story_v_side_new_1108102.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102016", "story_v_side_new_1108102.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_side_new_1108102", "1108102016", "story_v_side_new_1108102.awb")

						arg_63_1:RecordAudio("1108102016", var_66_11)
						arg_63_1:RecordAudio("1108102016", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102016", "story_v_side_new_1108102.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102016", "story_v_side_new_1108102.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play1108102017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1108102017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1108102018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) and arg_67_1.var_.characterEffect1081ui_story == nil then
				arg_67_1.var_.characterEffect1081ui_story = arg_67_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.0166666666666667

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) then
				if arg_67_1.var_.characterEffect1081ui_story and not isNil(arg_67_1.actors_["1081ui_story"]) then
					arg_67_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) and arg_67_1.var_.characterEffect1081ui_story then
				arg_67_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.25

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1108102017).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 10 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 10)

				if (10 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 10)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1108102018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1108102018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1108102019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1081ui_story = arg_71_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).z)
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles = arg_71_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1081ui_story"].transform.position).z)
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1081ui_story"].transform.localEulerAngles = arg_71_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1081ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1081ui_story == nil then
				arg_71_1.var_.characterEffect1081ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.0166666666666667

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1081ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_2)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1081ui_story then
				arg_71_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_74_3 = 0
			local var_74_4 = 0.825

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1108102018).content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 33 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 33)

				if (33 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 33)) > 0 and var_74_4 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_8 and arg_71_1.time_ < var_74_3 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1108102019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1108102019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1108102020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.975

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1108102019).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 39 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 39)

				if (39 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 39)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1108102020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1108102020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1108102021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1108102020).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 51 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 51)

				if (51 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 51)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1108102021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1108102021
		arg_83_1.duration_ = 2.1

		local var_83_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 2.1
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1108102022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1081ui_story = arg_83_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).z)
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles = arg_83_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_83_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1081ui_story"].transform.position).z)
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1081ui_story"].transform.localEulerAngles = arg_83_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1081ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1081ui_story == nil then
				arg_83_1.var_.characterEffect1081ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.0166666666666667

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1081ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1081ui_story then
				arg_83_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_86_4 = 0
			local var_86_5 = 0.225

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(1108102021)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 9 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 9)

				if (9 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 9)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102021", "story_v_side_new_1108102.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102021", "story_v_side_new_1108102.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_side_new_1108102", "1108102021", "story_v_side_new_1108102.awb")

						arg_83_1:RecordAudio("1108102021", var_86_11)
						arg_83_1:RecordAudio("1108102021", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102021", "story_v_side_new_1108102.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102021", "story_v_side_new_1108102.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play1108102022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1108102022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1108102023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081ui_story = arg_87_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).z)
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles = arg_87_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).z)
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles = arg_87_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 0.3

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1108102022).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 12 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 12)

				if (12 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 12)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1108102023
		arg_91_1.duration_ = 7.9

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1108102024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if arg_91_1.bgs_.SA0201 == nil then
				local var_94_0 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0201")
				var_94_0.name = "SA0201"
				var_94_0.transform.parent = arg_91_1.stage_.transform
				var_94_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_.SA0201 = var_94_0
			end

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				local var_94_1 = arg_91_1.bgs_.SA0201

				arg_91_1.bgs_.SA0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_2 = var_94_1:GetComponent("SpriteRenderer")

				if var_94_2 and var_94_2.sprite then
					local var_94_3 = 2 * (var_94_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_1.transform.localScale = Vector3.New(var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "SA0201" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0
				arg_91_1.fswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1108102023).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_4 = 4

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_5 = 14
			local var_94_6 = 0.933333333333333
			local var_94_7, var_94_8 = arg_91_1:GetPercentByPara(arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1108102023).content), 1)

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_9 = var_94_5 <= 0 and var_94_6 or var_94_6 * ((var_94_8 - arg_91_1.typewritterCharCountI18N) / var_94_5)

				if (var_94_5 <= 0 and var_94_6 or var_94_6 * ((var_94_8 - arg_91_1.typewritterCharCountI18N) / var_94_5)) > 0 and var_94_6 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end
			end

			local var_94_10 = math.max(0.933333333333333, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_10 then
				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_7, (arg_91_1.time_ - var_94_4) / var_94_10)
				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_10 and arg_91_1.time_ < var_94_4 + var_94_10 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_7

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_8
			end

			local var_94_11 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_12 = 2

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_12 then
				local var_94_13 = Color.New(0, 0, 0)

				var_94_13.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - var_94_11) / var_94_12)
				arg_91_1.mask_.color = var_94_13
			end

			if arg_91_1.time_ >= var_94_11 + var_94_12 and arg_91_1.time_ < var_94_11 + var_94_12 + arg_94_0 then
				local var_94_14 = Color.New(0, 0, 0)

				var_94_14.a = 1
				arg_91_1.mask_.color = var_94_14
			end

			local var_94_15 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_16 = 2

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_16 then
				local var_94_17 = Color.New(0, 0, 0)

				var_94_17.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_15) / var_94_16)
				arg_91_1.mask_.color = var_94_17
			end

			if arg_91_1.time_ >= var_94_15 + var_94_16 and arg_91_1.time_ < var_94_15 + var_94_16 + arg_94_0 then
				local var_94_18 = Color.New(0, 0, 0)

				arg_91_1.mask_.enabled = false
				var_94_18.a = 0
				arg_91_1.mask_.color = var_94_18
			end

			local var_94_19 = 4
			local var_94_20 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102023", "story_v_out_1108102.awb") / 1000

			if var_94_20 > 0 and 3.9 < var_94_20 and var_94_20 + var_94_19 > arg_91_1.duration_ then
				arg_91_1.duration_ = var_94_20 + var_94_19
			end

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 then
				arg_91_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102023", "story_v_out_1108102.awb")
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1108102024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1108102024
		arg_95_1.duration_ = 5.87

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1108102025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_0 = 31
			local var_98_1 = 2.06666666666667
			local var_98_2, var_98_3 = arg_95_1:GetPercentByPara(arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1108102023).content), 2)

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_4 = var_98_0 <= 0 and var_98_1 or var_98_1 * ((var_98_3 - arg_95_1.typewritterCharCountI18N) / var_98_0)

				if (var_98_0 <= 0 and var_98_1 or var_98_1 * ((var_98_3 - arg_95_1.typewritterCharCountI18N) / var_98_0)) > 0 and var_98_1 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end
			end

			local var_98_5 = math.max(2.06666666666667, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_5 then
				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_2, (arg_95_1.time_ - 0) / var_98_5)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_5 and arg_95_1.time_ < 0 + var_98_5 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_2

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_3
			end

			local var_98_6 = 0
			local var_98_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102024", "story_v_out_1108102.awb") / 1000

			if var_98_7 > 0 and 5.866 < var_98_7 and var_98_7 + var_98_6 > arg_95_1.duration_ then
				arg_95_1.duration_ = var_98_7 + var_98_6
			end

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102024", "story_v_out_1108102.awb")
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1108102025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1108102025
		arg_99_1.duration_ = 10.2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1108102026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_0 = 59
			local var_102_1 = 3.93333333333333
			local var_102_2, var_102_3 = arg_99_1:GetPercentByPara(arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1108102023).content), 3)

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_4 = var_102_0 <= 0 and var_102_1 or var_102_1 * ((var_102_3 - arg_99_1.typewritterCharCountI18N) / var_102_0)

				if (var_102_0 <= 0 and var_102_1 or var_102_1 * ((var_102_3 - arg_99_1.typewritterCharCountI18N) / var_102_0)) > 0 and var_102_1 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end
			end

			local var_102_5 = math.max(3.93333333333333, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_2, (arg_99_1.time_ - 0) / var_102_5)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_2

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_3
			end

			local var_102_6 = 0
			local var_102_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102025", "story_v_out_1108102.awb") / 1000

			if var_102_7 > 0 and 10.2 < var_102_7 and var_102_7 + var_102_6 > arg_99_1.duration_ then
				arg_99_1.duration_ = var_102_7 + var_102_6
			end

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102025", "story_v_out_1108102.awb")
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1108102026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1108102026
		arg_103_1.duration_ = 7.47

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1108102027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_0 = 38
			local var_106_1 = 2.53333333333333
			local var_106_2, var_106_3 = arg_103_1:GetPercentByPara(arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1108102023).content), 4)

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_4 = var_106_0 <= 0 and var_106_1 or var_106_1 * ((var_106_3 - arg_103_1.typewritterCharCountI18N) / var_106_0)

				if (var_106_0 <= 0 and var_106_1 or var_106_1 * ((var_106_3 - arg_103_1.typewritterCharCountI18N) / var_106_0)) > 0 and var_106_1 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end
			end

			local var_106_5 = math.max(2.53333333333333, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_2, (arg_103_1.time_ - 0) / var_106_5)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_2

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_3
			end

			local var_106_6 = 0
			local var_106_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102026", "story_v_out_1108102.awb") / 1000

			if var_106_7 > 0 and 7.466 < var_106_7 and var_106_7 + var_106_6 > arg_103_1.duration_ then
				arg_103_1.duration_ = var_106_7 + var_106_6
			end

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102026", "story_v_out_1108102.awb")
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1108102027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1108102027
		arg_107_1.duration_ = 7.6

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1108102028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_0 = 39
			local var_110_1 = 2.6
			local var_110_2, var_110_3 = arg_107_1:GetPercentByPara(arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1108102023).content), 5)

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_4 = var_110_0 <= 0 and var_110_1 or var_110_1 * ((var_110_3 - arg_107_1.typewritterCharCountI18N) / var_110_0)

				if (var_110_0 <= 0 and var_110_1 or var_110_1 * ((var_110_3 - arg_107_1.typewritterCharCountI18N) / var_110_0)) > 0 and var_110_1 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end
			end

			local var_110_5 = math.max(2.6, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_2, (arg_107_1.time_ - 0) / var_110_5)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_2

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_3
			end

			local var_110_6 = 0
			local var_110_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102027", "story_v_out_1108102.awb") / 1000

			if var_110_7 > 0 and 7.6 < var_110_7 and var_110_7 + var_110_6 > arg_107_1.duration_ then
				arg_107_1.duration_ = var_110_7 + var_110_6
			end

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102027", "story_v_out_1108102.awb")
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1108102028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1108102028
		arg_111_1.duration_ = 7.9

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1108102029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_0 = 23
			local var_114_1 = 1.53333333333333
			local var_114_2, var_114_3 = arg_111_1:GetPercentByPara(arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1108102023).content), 6)

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_4 = var_114_0 <= 0 and var_114_1 or var_114_1 * ((var_114_3 - arg_111_1.typewritterCharCountI18N) / var_114_0)

				if (var_114_0 <= 0 and var_114_1 or var_114_1 * ((var_114_3 - arg_111_1.typewritterCharCountI18N) / var_114_0)) > 0 and var_114_1 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end
			end

			local var_114_5 = math.max(1.53333333333333, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_2, (arg_111_1.time_ - 0) / var_114_5)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_2

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_3
			end

			local var_114_6 = 0
			local var_114_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102028", "story_v_out_1108102.awb") / 1000

			if var_114_7 > 0 and 7.9 < var_114_7 and var_114_7 + var_114_6 > arg_111_1.duration_ then
				arg_111_1.duration_ = var_114_7 + var_114_6
			end

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102028", "story_v_out_1108102.awb")
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1108102029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1108102029
		arg_115_1.duration_ = 1

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1108102030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_0 = 2
			local var_118_1 = 0.133333333333333
			local var_118_2, var_118_3 = arg_115_1:GetPercentByPara(arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1108102023).content), 7)

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_4 = var_118_0 <= 0 and var_118_1 or var_118_1 * ((var_118_3 - arg_115_1.typewritterCharCountI18N) / var_118_0)

				if (var_118_0 <= 0 and var_118_1 or var_118_1 * ((var_118_3 - arg_115_1.typewritterCharCountI18N) / var_118_0)) > 0 and var_118_1 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end
			end

			local var_118_5 = math.max(0.133333333333333, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_2, (arg_115_1.time_ - 0) / var_118_5)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_2

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_3
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1108102030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1108102030
		arg_119_1.duration_ = 5.57

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1108102031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.fswbg_:SetActive(true)
				arg_119_1.dialog_:SetActive(false)

				arg_119_1.fswtw_.percent = 0
				arg_119_1.fswt_.text = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1108102030).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.fswt_)

				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_119_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_119_1.fswtw_:SetDirty()

				arg_119_1.typewritterCharCountI18N = 0

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.var_.oldValueTypewriter = arg_119_1.fswtw_.percent

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_1 = 17
			local var_122_2 = 1.13333333333333
			local var_122_3, var_122_4 = arg_119_1:GetPercentByPara(arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1108102030).content), 1)

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

			local var_122_7 = 0
			local var_122_8 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102030", "story_v_out_1108102.awb") / 1000

			if var_122_8 > 0 and 5.566 < var_122_8 and var_122_8 + var_122_7 > arg_119_1.duration_ then
				arg_119_1.duration_ = var_122_8 + var_122_7
			end

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102030", "story_v_out_1108102.awb")
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1108102031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1108102031
		arg_123_1.duration_ = 6.23

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1108102032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.oldValueTypewriter = arg_123_1.fswtw_.percent

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_0 = 32
			local var_126_1 = 2.13333333333333
			local var_126_2, var_126_3 = arg_123_1:GetPercentByPara(arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1108102030).content), 2)

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				local var_126_4 = var_126_0 <= 0 and var_126_1 or var_126_1 * ((var_126_3 - arg_123_1.typewritterCharCountI18N) / var_126_0)

				if (var_126_0 <= 0 and var_126_1 or var_126_1 * ((var_126_3 - arg_123_1.typewritterCharCountI18N) / var_126_0)) > 0 and var_126_1 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end
			end

			local var_126_5 = math.max(2.13333333333333, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				arg_123_1.fswtw_.percent = Mathf.Lerp(arg_123_1.var_.oldValueTypewriter, var_126_2, (arg_123_1.time_ - 0) / var_126_5)
				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_123_1.fswtw_:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				arg_123_1.fswtw_.percent = var_126_2

				arg_123_1.fswtw_:SetDirty()
				arg_123_1:ShowNextGo(true)

				arg_123_1.typewritterCharCountI18N = var_126_3
			end

			local var_126_6 = 0
			local var_126_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102031", "story_v_out_1108102.awb") / 1000

			if var_126_7 > 0 and 6.233 < var_126_7 and var_126_7 + var_126_6 > arg_123_1.duration_ then
				arg_123_1.duration_ = var_126_7 + var_126_6
			end

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102031", "story_v_out_1108102.awb")
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1108102032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1108102032
		arg_127_1.duration_ = 4.73

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1108102033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.oldValueTypewriter = arg_127_1.fswtw_.percent

				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_0 = 26
			local var_130_1 = 1.73333333333333
			local var_130_2, var_130_3 = arg_127_1:GetPercentByPara(arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1108102030).content), 3)

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				local var_130_4 = var_130_0 <= 0 and var_130_1 or var_130_1 * ((var_130_3 - arg_127_1.typewritterCharCountI18N) / var_130_0)

				if (var_130_0 <= 0 and var_130_1 or var_130_1 * ((var_130_3 - arg_127_1.typewritterCharCountI18N) / var_130_0)) > 0 and var_130_1 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end
			end

			local var_130_5 = math.max(1.73333333333333, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				arg_127_1.fswtw_.percent = Mathf.Lerp(arg_127_1.var_.oldValueTypewriter, var_130_2, (arg_127_1.time_ - 0) / var_130_5)
				arg_127_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_127_1.fswtw_:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				arg_127_1.fswtw_.percent = var_130_2

				arg_127_1.fswtw_:SetDirty()
				arg_127_1:ShowNextGo(true)

				arg_127_1.typewritterCharCountI18N = var_130_3
			end

			local var_130_6 = 0
			local var_130_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102032", "story_v_out_1108102.awb") / 1000

			if var_130_7 > 0 and 4.733 < var_130_7 and var_130_7 + var_130_6 > arg_127_1.duration_ then
				arg_127_1.duration_ = var_130_7 + var_130_6
			end

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102032", "story_v_out_1108102.awb")
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1108102033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1108102033
		arg_131_1.duration_ = 9.3

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1108102034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.oldValueTypewriter = arg_131_1.fswtw_.percent

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_0 = 30
			local var_134_1 = 2
			local var_134_2, var_134_3 = arg_131_1:GetPercentByPara(arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1108102030).content), 4)

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				local var_134_4 = var_134_0 <= 0 and var_134_1 or var_134_1 * ((var_134_3 - arg_131_1.typewritterCharCountI18N) / var_134_0)

				if (var_134_0 <= 0 and var_134_1 or var_134_1 * ((var_134_3 - arg_131_1.typewritterCharCountI18N) / var_134_0)) > 0 and var_134_1 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end
			end

			local var_134_5 = math.max(2, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 then
				arg_131_1.fswtw_.percent = Mathf.Lerp(arg_131_1.var_.oldValueTypewriter, var_134_2, (arg_131_1.time_ - 0) / var_134_5)
				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_131_1.fswtw_:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 then
				arg_131_1.fswtw_.percent = var_134_2

				arg_131_1.fswtw_:SetDirty()
				arg_131_1:ShowNextGo(true)

				arg_131_1.typewritterCharCountI18N = var_134_3
			end

			local var_134_6 = 0
			local var_134_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102033", "story_v_out_1108102.awb") / 1000

			if var_134_7 > 0 and 9.3 < var_134_7 and var_134_7 + var_134_6 > arg_131_1.duration_ then
				arg_131_1.duration_ = var_134_7 + var_134_6
			end

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102033", "story_v_out_1108102.awb")
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1108102034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1108102034
		arg_135_1.duration_ = 6.77

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1108102035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_0 = 33
			local var_138_1 = 2.2
			local var_138_2, var_138_3 = arg_135_1:GetPercentByPara(arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1108102030).content), 5)

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_4 = var_138_0 <= 0 and var_138_1 or var_138_1 * ((var_138_3 - arg_135_1.typewritterCharCountI18N) / var_138_0)

				if (var_138_0 <= 0 and var_138_1 or var_138_1 * ((var_138_3 - arg_135_1.typewritterCharCountI18N) / var_138_0)) > 0 and var_138_1 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end
			end

			local var_138_5 = math.max(2.2, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_2, (arg_135_1.time_ - 0) / var_138_5)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_2

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_3
			end

			local var_138_6 = 0
			local var_138_7 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102034", "story_v_out_1108102.awb") / 1000

			if var_138_7 > 0 and 6.766 < var_138_7 and var_138_7 + var_138_6 > arg_135_1.duration_ then
				arg_135_1.duration_ = var_138_7 + var_138_6
			end

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102034", "story_v_out_1108102.awb")
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1108102035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1108102035
		arg_139_1.duration_ = 1

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1108102036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.oldValueTypewriter = arg_139_1.fswtw_.percent

				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_0 = 2
			local var_142_1 = 0.133333333333333
			local var_142_2, var_142_3 = arg_139_1:GetPercentByPara(arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1108102030).content), 6)

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				local var_142_4 = var_142_0 <= 0 and var_142_1 or var_142_1 * ((var_142_3 - arg_139_1.typewritterCharCountI18N) / var_142_0)

				if (var_142_0 <= 0 and var_142_1 or var_142_1 * ((var_142_3 - arg_139_1.typewritterCharCountI18N) / var_142_0)) > 0 and var_142_1 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end
			end

			local var_142_5 = math.max(0.133333333333333, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				arg_139_1.fswtw_.percent = Mathf.Lerp(arg_139_1.var_.oldValueTypewriter, var_142_2, (arg_139_1.time_ - 0) / var_142_5)
				arg_139_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_139_1.fswtw_:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				arg_139_1.fswtw_.percent = var_142_2

				arg_139_1.fswtw_:SetDirty()
				arg_139_1:ShowNextGo(true)

				arg_139_1.typewritterCharCountI18N = var_142_3
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1108102036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108102036
		arg_143_1.duration_ = 9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1108102037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 4 < arg_143_1.time_ and arg_143_1.time_ <= 4 + arg_146_0 then
				arg_143_1.var_.moveOldPos1081ui_story = arg_143_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 4 <= arg_143_1.time_ and arg_143_1.time_ < 4 + var_146_0 then
				arg_143_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_143_1.time_ - 4) / var_146_0)
				arg_143_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).z)
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles = arg_143_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 4 + var_146_0 and arg_143_1.time_ < 4 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_143_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1081ui_story"].transform.position).z)
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1081ui_story"].transform.localEulerAngles = arg_143_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= 4 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= 4 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_146_1 = arg_143_1.actors_["1081ui_story"]

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= 4 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1081ui_story == nil then
				arg_143_1.var_.characterEffect1081ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.0166666666666667

			if 4 <= arg_143_1.time_ and arg_143_1.time_ < 4 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1081ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 4) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 4 + var_146_2 and arg_143_1.time_ < 4 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1081ui_story then
				arg_143_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= 2 + arg_146_0 then
				local var_146_3 = arg_143_1.bgs_.ST12

				arg_143_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_146_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_4 = var_146_3:GetComponent("SpriteRenderer")

				if var_146_4 and var_146_4.sprite then
					local var_146_5 = 2 * (var_146_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_146_3.transform.localScale = Vector3.New(var_146_5 / var_146_4.sprite.bounds.size.y < var_146_5 * manager.ui.mainCameraCom_.aspect / var_146_4.sprite.bounds.size.x and var_146_5 * manager.ui.mainCameraCom_.aspect / var_146_4.sprite.bounds.size.x or var_146_5 / var_146_4.sprite.bounds.size.y, var_146_5 / var_146_4.sprite.bounds.size.y < var_146_5 * manager.ui.mainCameraCom_.aspect / var_146_4.sprite.bounds.size.x and var_146_5 * manager.ui.mainCameraCom_.aspect / var_146_4.sprite.bounds.size.x or var_146_5 / var_146_4.sprite.bounds.size.y, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "ST12" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= 2 + arg_146_0 then
				arg_143_1.fswbg_:SetActive(false)
				arg_143_1.dialog_:SetActive(false)
				SetActive(arg_143_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_143_1:ShowNextGo(false)
			end

			local var_146_6 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_7 = 2

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_7 then
				local var_146_8 = Color.New(0, 0, 0)

				var_146_8.a = Mathf.Lerp(0, 1, (arg_143_1.time_ - var_146_6) / var_146_7)
				arg_143_1.mask_.color = var_146_8
			end

			if arg_143_1.time_ >= var_146_6 + var_146_7 and arg_143_1.time_ < var_146_6 + var_146_7 + arg_146_0 then
				local var_146_9 = Color.New(0, 0, 0)

				var_146_9.a = 1
				arg_143_1.mask_.color = var_146_9
			end

			local var_146_10 = 2

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_11 = 2

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 then
				local var_146_12 = Color.New(0, 0, 0)

				var_146_12.a = Mathf.Lerp(1, 0, (arg_143_1.time_ - var_146_10) / var_146_11)
				arg_143_1.mask_.color = var_146_12
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 then
				local var_146_13 = Color.New(0, 0, 0)

				arg_143_1.mask_.enabled = false
				var_146_13.a = 0
				arg_143_1.mask_.color = var_146_13
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_14 = 4
			local var_146_15 = 0.275

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_16 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_16:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

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

				local var_146_17 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1108102036).content)

				arg_143_1.text_.text = var_146_17

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_19 = 11 <= 0 and var_146_15 or var_146_15 * (utf8.len(var_146_17) / 11)

				if (11 <= 0 and var_146_15 or var_146_15 * (utf8.len(var_146_17) / 11)) > 0 and var_146_15 < var_146_19 then
					arg_143_1.talkMaxDuration = var_146_19
					var_146_14 = var_146_14 + 0.3

					if var_146_19 + var_146_14 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_14
					end
				end

				arg_143_1.text_.text = var_146_17
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_20 = var_146_14 + 0.3
			local var_146_21 = math.max(var_146_15, arg_143_1.talkMaxDuration)

			if var_146_14 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_20 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_20) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_20 + var_146_21 and arg_143_1.time_ < var_146_20 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1108102037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1108102037
		arg_149_1.duration_ = 2.67

		local var_149_0 = {
			ja = 1.999999999999,
			ko = 2.666,
			zh = 2.666
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
				arg_149_0:Play1108102038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1081ui_story = arg_149_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).z)
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles = arg_149_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_149_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1081ui_story"].transform.position).z)
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1081ui_story"].transform.localEulerAngles = arg_149_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1081ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1081ui_story == nil then
				arg_149_1.var_.characterEffect1081ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.0166666666666667

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1081ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1081ui_story then
				arg_149_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(1108102037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)

				if (12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102037", "story_v_side_new_1108102.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102037", "story_v_side_new_1108102.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_side_new_1108102", "1108102037", "story_v_side_new_1108102.awb")

						arg_149_1:RecordAudio("1108102037", var_152_11)
						arg_149_1:RecordAudio("1108102037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102037", "story_v_side_new_1108102.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102037", "story_v_side_new_1108102.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108102038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1108102039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1081ui_story"]) and arg_153_1.var_.characterEffect1081ui_story == nil then
				arg_153_1.var_.characterEffect1081ui_story = arg_153_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.0166666666666667

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1081ui_story"]) then
				if arg_153_1.var_.characterEffect1081ui_story and not isNil(arg_153_1.actors_["1081ui_story"]) then
					arg_153_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1081ui_story"]) and arg_153_1.var_.characterEffect1081ui_story then
				arg_153_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.825

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1108102038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 33 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 33)

				if (33 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 33)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1108102039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108102039
		arg_157_1.duration_ = 2.77

		local var_157_0 = {
			ja = 2.7,
			ko = 2.766,
			zh = 2.766
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
				arg_157_0:Play1108102040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1081ui_story = arg_157_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).z)
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles = arg_157_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_157_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1081ui_story"].transform.position).z)
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1081ui_story"].transform.localEulerAngles = arg_157_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1081ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1081ui_story == nil then
				arg_157_1.var_.characterEffect1081ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.0166666666666667

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1081ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1081ui_story then
				arg_157_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(1108102039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 10 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 10)

				if (10 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 10)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102039", "story_v_side_new_1108102.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102039", "story_v_side_new_1108102.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_side_new_1108102", "1108102039", "story_v_side_new_1108102.awb")

						arg_157_1:RecordAudio("1108102039", var_160_11)
						arg_157_1:RecordAudio("1108102039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102039", "story_v_side_new_1108102.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102039", "story_v_side_new_1108102.awb")
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

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108102040
		arg_161_1.duration_ = 9.8

		local var_161_0 = {
			ja = 9.8,
			ko = 5.733,
			zh = 5.733
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
				arg_161_0:Play1108102041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1081ui_story = arg_161_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1081ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1081ui_story == nil then
				arg_161_1.var_.characterEffect1081ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.0166666666666667

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1081ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1081ui_story then
				arg_161_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.875

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(1108102040)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 35 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 35)

				if (35 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 35)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102040", "story_v_side_new_1108102.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102040", "story_v_side_new_1108102.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_new_1108102", "1108102040", "story_v_side_new_1108102.awb")

						arg_161_1:RecordAudio("1108102040", var_164_11)
						arg_161_1:RecordAudio("1108102040", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102040", "story_v_side_new_1108102.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102040", "story_v_side_new_1108102.awb")
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
				actorName = "1081ui_story",
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
	Play1108102041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108102041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1108102042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) and arg_165_1.var_.characterEffect1081ui_story == nil then
				arg_165_1.var_.characterEffect1081ui_story = arg_165_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.0166666666666667

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) then
				if arg_165_1.var_.characterEffect1081ui_story and not isNil(arg_165_1.actors_["1081ui_story"]) then
					arg_165_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1081ui_story"]) and arg_165_1.var_.characterEffect1081ui_story then
				arg_165_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1108102041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 5 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 5)

				if (5 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 5)) > 0 and var_168_2 < var_168_5 then
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
	Play1108102042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108102042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1108102043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.675

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1108102042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 27 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 27)

				if (27 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 27)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1108102043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108102043
		arg_173_1.duration_ = 6.97

		local var_173_0 = {
			ja = 6.9,
			ko = 6.966,
			zh = 6.966
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
				arg_173_0:Play1108102044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if arg_173_1.bgs_.ST14 == nil then
				local var_176_0 = Object.Instantiate(arg_173_1.paintGo_)

				var_176_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST14")
				var_176_0.name = "ST14"
				var_176_0.transform.parent = arg_173_1.stage_.transform
				var_176_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.bgs_.ST14 = var_176_0
			end

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				local var_176_1 = arg_173_1.bgs_.ST14

				arg_173_1.bgs_.ST14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_2 = var_176_1:GetComponent("SpriteRenderer")

				if var_176_2 and var_176_2.sprite then
					local var_176_3 = 2 * (var_176_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_1.transform.localScale = Vector3.New(var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "ST14" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_4 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_5 = 2

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_5 then
				local var_176_6 = Color.New(0, 0, 0)

				var_176_6.a = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_4) / var_176_5)
				arg_173_1.mask_.color = var_176_6
			end

			if arg_173_1.time_ >= var_176_4 + var_176_5 and arg_173_1.time_ < var_176_4 + var_176_5 + arg_176_0 then
				local var_176_7 = Color.New(0, 0, 0)

				var_176_7.a = 1
				arg_173_1.mask_.color = var_176_7
			end

			local var_176_8 = 2

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_9 = 2

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 then
				local var_176_10 = Color.New(0, 0, 0)

				var_176_10.a = Mathf.Lerp(1, 0, (arg_173_1.time_ - var_176_8) / var_176_9)
				arg_173_1.mask_.color = var_176_10
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 then
				local var_176_11 = Color.New(0, 0, 0)

				arg_173_1.mask_.enabled = false
				var_176_11.a = 0
				arg_173_1.mask_.color = var_176_11
			end

			local var_176_12 = arg_173_1.actors_["1081ui_story"].transform

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1.var_.moveOldPos1081ui_story = var_176_12.localPosition
			end

			local var_176_13 = 0.001

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_13 then
				var_176_12.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_173_1.time_ - 4) / var_176_13)
				var_176_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_12.position).x, (manager.ui.mainCamera.transform.position - var_176_12.position).y, (manager.ui.mainCamera.transform.position - var_176_12.position).z)
				var_176_12.localEulerAngles.z = 0
				var_176_12.localEulerAngles.x = 0
				var_176_12.localEulerAngles = var_176_12.localEulerAngles
			end

			if arg_173_1.time_ >= 4 + var_176_13 and arg_173_1.time_ < 4 + var_176_13 + arg_176_0 then
				var_176_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_176_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_12.position).x, (manager.ui.mainCamera.transform.position - var_176_12.position).y, (manager.ui.mainCamera.transform.position - var_176_12.position).z)
				var_176_12.localEulerAngles.z = 0
				var_176_12.localEulerAngles.x = 0
				var_176_12.localEulerAngles = var_176_12.localEulerAngles
			end

			local var_176_14 = arg_173_1.actors_["1081ui_story"]

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 and not isNil(var_176_14) and arg_173_1.var_.characterEffect1081ui_story == nil then
				arg_173_1.var_.characterEffect1081ui_story = var_176_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_15 = 0.0166666666666667

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_15 and not isNil(var_176_14) then
				if arg_173_1.var_.characterEffect1081ui_story and not isNil(var_176_14) then
					arg_173_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 4 + var_176_15 and arg_173_1.time_ < 4 + var_176_15 + arg_176_0 and not isNil(var_176_14) and arg_173_1.var_.characterEffect1081ui_story then
				arg_173_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_176_17 = arg_173_1.actors_["1081ui_story"].transform

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				arg_173_1.var_.moveOldPos1081ui_story = var_176_17.localPosition
			end

			local var_176_18 = 0.001

			if 2 <= arg_173_1.time_ and arg_173_1.time_ < 2 + var_176_18 then
				var_176_17.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 2) / var_176_18)
				var_176_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_17.position).x, (manager.ui.mainCamera.transform.position - var_176_17.position).y, (manager.ui.mainCamera.transform.position - var_176_17.position).z)
				var_176_17.localEulerAngles.z = 0
				var_176_17.localEulerAngles.x = 0
				var_176_17.localEulerAngles = var_176_17.localEulerAngles
			end

			if arg_173_1.time_ >= 2 + var_176_18 and arg_173_1.time_ < 2 + var_176_18 + arg_176_0 then
				var_176_17.localPosition = Vector3.New(0, 100, 0)
				var_176_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_17.position).x, (manager.ui.mainCamera.transform.position - var_176_17.position).y, (manager.ui.mainCamera.transform.position - var_176_17.position).z)
				var_176_17.localEulerAngles.z = 0
				var_176_17.localEulerAngles.x = 0
				var_176_17.localEulerAngles = var_176_17.localEulerAngles
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_19 = 4
			local var_176_20 = 0.3

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_21 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_21:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_22 = arg_173_1:GetWordFromCfg(1108102043)
				local var_176_23 = arg_173_1:FormatText(var_176_22.content)

				arg_173_1.text_.text = var_176_23

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_25 = 12 <= 0 and var_176_20 or var_176_20 * (utf8.len(var_176_23) / 12)

				if (12 <= 0 and var_176_20 or var_176_20 * (utf8.len(var_176_23) / 12)) > 0 and var_176_20 < var_176_25 then
					arg_173_1.talkMaxDuration = var_176_25
					var_176_19 = var_176_19 + 0.3

					if var_176_25 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_25 + var_176_19
					end
				end

				arg_173_1.text_.text = var_176_23
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102043", "story_v_side_new_1108102.awb") ~= 0 then
					local var_176_26 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102043", "story_v_side_new_1108102.awb") / 1000

					if var_176_26 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_26 + var_176_19
					end

					if var_176_22.prefab_name ~= "" and arg_173_1.actors_[var_176_22.prefab_name] ~= nil then
						local var_176_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_22.prefab_name].transform, "story_v_side_new_1108102", "1108102043", "story_v_side_new_1108102.awb")

						arg_173_1:RecordAudio("1108102043", var_176_27)
						arg_173_1:RecordAudio("1108102043", var_176_27)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102043", "story_v_side_new_1108102.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102043", "story_v_side_new_1108102.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_28 = var_176_19 + 0.3
			local var_176_29 = math.max(var_176_20, arg_173_1.talkMaxDuration)

			if var_176_19 + 0.3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_28 + var_176_29 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_28) / var_176_29

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_28 + var_176_29 and arg_173_1.time_ < var_176_28 + var_176_29 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108102044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1108102044
		arg_179_1.duration_ = 9.7

		local var_179_0 = {
			ja = 9.7,
			ko = 6.7,
			zh = 6.7
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
				arg_179_0:Play1108102045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.8

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(1108102044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 32 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 32)

				if (32 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 32)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102044", "story_v_side_new_1108102.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102044", "story_v_side_new_1108102.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_side_new_1108102", "1108102044", "story_v_side_new_1108102.awb")

						arg_179_1:RecordAudio("1108102044", var_182_6)
						arg_179_1:RecordAudio("1108102044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102044", "story_v_side_new_1108102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102044", "story_v_side_new_1108102.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1108102045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1108102045
		arg_183_1.duration_ = 4.77

		local var_183_0 = {
			ja = 3.266,
			ko = 4.766,
			zh = 4.766
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
				arg_183_0:Play1108102046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_186_0 = 0
			local var_186_1 = 0.5

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(1108102045)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 20 <= 0 and var_186_1 or var_186_1 * (utf8.len(var_186_3) / 20)

				if (20 <= 0 and var_186_1 or var_186_1 * (utf8.len(var_186_3) / 20)) > 0 and var_186_1 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102045", "story_v_side_new_1108102.awb") ~= 0 then
					local var_186_6 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102045", "story_v_side_new_1108102.awb") / 1000

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end

					if var_186_2.prefab_name ~= "" and arg_183_1.actors_[var_186_2.prefab_name] ~= nil then
						local var_186_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_2.prefab_name].transform, "story_v_side_new_1108102", "1108102045", "story_v_side_new_1108102.awb")

						arg_183_1:RecordAudio("1108102045", var_186_7)
						arg_183_1:RecordAudio("1108102045", var_186_7)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102045", "story_v_side_new_1108102.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102045", "story_v_side_new_1108102.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1108102046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1108102046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1108102047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1081ui_story"]) and arg_187_1.var_.characterEffect1081ui_story == nil then
				arg_187_1.var_.characterEffect1081ui_story = arg_187_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.0166666666666667

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1081ui_story"]) then
				if arg_187_1.var_.characterEffect1081ui_story and not isNil(arg_187_1.actors_["1081ui_story"]) then
					arg_187_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1081ui_story"]) and arg_187_1.var_.characterEffect1081ui_story then
				arg_187_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1108102046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 5 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 5)

				if (5 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 5)) > 0 and var_190_2 < var_190_5 then
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
	Play1108102047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1108102047
		arg_191_1.duration_ = 10.33

		local var_191_0 = {
			ja = 10.333,
			ko = 9.833,
			zh = 9.833
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
				arg_191_0:Play1108102048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.bgs_.ST03 == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_194_0.name = "ST03"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.ST03 = var_194_0
			end

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.ST03

				arg_191_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST03" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_5 = 2

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_5 then
				local var_194_6 = Color.New(0, 0, 0)

				var_194_6.a = Mathf.Lerp(0, 1, (arg_191_1.time_ - var_194_4) / var_194_5)
				arg_191_1.mask_.color = var_194_6
			end

			if arg_191_1.time_ >= var_194_4 + var_194_5 and arg_191_1.time_ < var_194_4 + var_194_5 + arg_194_0 then
				local var_194_7 = Color.New(0, 0, 0)

				var_194_7.a = 1
				arg_191_1.mask_.color = var_194_7
			end

			local var_194_8 = 2

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 then
				local var_194_10 = Color.New(0, 0, 0)

				var_194_10.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_8) / var_194_9)
				arg_191_1.mask_.color = var_194_10
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 then
				local var_194_11 = Color.New(0, 0, 0)

				arg_191_1.mask_.enabled = false
				var_194_11.a = 0
				arg_191_1.mask_.color = var_194_11
			end

			local var_194_12 = arg_191_1.actors_["1081ui_story"].transform

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= 4 + arg_194_0 then
				arg_191_1.var_.moveOldPos1081ui_story = var_194_12.localPosition
			end

			local var_194_13 = 0.001

			if 4 <= arg_191_1.time_ and arg_191_1.time_ < 4 + var_194_13 then
				var_194_12.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_191_1.time_ - 4) / var_194_13)
				var_194_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_12.position).x, (manager.ui.mainCamera.transform.position - var_194_12.position).y, (manager.ui.mainCamera.transform.position - var_194_12.position).z)
				var_194_12.localEulerAngles.z = 0
				var_194_12.localEulerAngles.x = 0
				var_194_12.localEulerAngles = var_194_12.localEulerAngles
			end

			if arg_191_1.time_ >= 4 + var_194_13 and arg_191_1.time_ < 4 + var_194_13 + arg_194_0 then
				var_194_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_194_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_12.position).x, (manager.ui.mainCamera.transform.position - var_194_12.position).y, (manager.ui.mainCamera.transform.position - var_194_12.position).z)
				var_194_12.localEulerAngles.z = 0
				var_194_12.localEulerAngles.x = 0
				var_194_12.localEulerAngles = var_194_12.localEulerAngles
			end

			local var_194_14 = arg_191_1.actors_["1081ui_story"]

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= 4 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect1081ui_story == nil then
				arg_191_1.var_.characterEffect1081ui_story = var_194_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_15 = 0.0166666666666667

			if 4 <= arg_191_1.time_ and arg_191_1.time_ < 4 + var_194_15 and not isNil(var_194_14) then
				if arg_191_1.var_.characterEffect1081ui_story and not isNil(var_194_14) then
					arg_191_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 4 + var_194_15 and arg_191_1.time_ < 4 + var_194_15 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect1081ui_story then
				arg_191_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= 4 + arg_194_0 then
				arg_191_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= 4 + arg_194_0 then
				arg_191_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_194_17 = arg_191_1.actors_["1081ui_story"].transform

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				arg_191_1.var_.moveOldPos1081ui_story = var_194_17.localPosition
			end

			local var_194_18 = 0.001

			if 2 <= arg_191_1.time_ and arg_191_1.time_ < 2 + var_194_18 then
				var_194_17.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 2) / var_194_18)
				var_194_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_17.position).x, (manager.ui.mainCamera.transform.position - var_194_17.position).y, (manager.ui.mainCamera.transform.position - var_194_17.position).z)
				var_194_17.localEulerAngles.z = 0
				var_194_17.localEulerAngles.x = 0
				var_194_17.localEulerAngles = var_194_17.localEulerAngles
			end

			if arg_191_1.time_ >= 2 + var_194_18 and arg_191_1.time_ < 2 + var_194_18 + arg_194_0 then
				var_194_17.localPosition = Vector3.New(0, 100, 0)
				var_194_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_17.position).x, (manager.ui.mainCamera.transform.position - var_194_17.position).y, (manager.ui.mainCamera.transform.position - var_194_17.position).z)
				var_194_17.localEulerAngles.z = 0
				var_194_17.localEulerAngles.x = 0
				var_194_17.localEulerAngles = var_194_17.localEulerAngles
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_19 = 4
			local var_194_20 = 0.6

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_21 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_21:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_22 = arg_191_1:GetWordFromCfg(1108102047)
				local var_194_23 = arg_191_1:FormatText(var_194_22.content)

				arg_191_1.text_.text = var_194_23

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_25 = 24 <= 0 and var_194_20 or var_194_20 * (utf8.len(var_194_23) / 24)

				if (24 <= 0 and var_194_20 or var_194_20 * (utf8.len(var_194_23) / 24)) > 0 and var_194_20 < var_194_25 then
					arg_191_1.talkMaxDuration = var_194_25
					var_194_19 = var_194_19 + 0.3

					if var_194_25 + var_194_19 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_25 + var_194_19
					end
				end

				arg_191_1.text_.text = var_194_23
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102047", "story_v_side_new_1108102.awb") ~= 0 then
					local var_194_26 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102047", "story_v_side_new_1108102.awb") / 1000

					if var_194_26 + var_194_19 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_26 + var_194_19
					end

					if var_194_22.prefab_name ~= "" and arg_191_1.actors_[var_194_22.prefab_name] ~= nil then
						local var_194_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_22.prefab_name].transform, "story_v_side_new_1108102", "1108102047", "story_v_side_new_1108102.awb")

						arg_191_1:RecordAudio("1108102047", var_194_27)
						arg_191_1:RecordAudio("1108102047", var_194_27)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102047", "story_v_side_new_1108102.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102047", "story_v_side_new_1108102.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_28 = var_194_19 + 0.3
			local var_194_29 = math.max(var_194_20, arg_191_1.talkMaxDuration)

			if var_194_19 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_28 + var_194_29 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_28) / var_194_29

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_28 + var_194_29 and arg_191_1.time_ < var_194_28 + var_194_29 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1108102048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1108102048
		arg_197_1.duration_ = 10.1

		local var_197_0 = {
			ja = 10.1,
			ko = 6.333,
			zh = 6.333
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
				arg_197_0:Play1108102049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1081ui_story = arg_197_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).z)
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles = arg_197_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_197_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1081ui_story"].transform.position).z)
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1081ui_story"].transform.localEulerAngles = arg_197_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1081ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1081ui_story == nil then
				arg_197_1.var_.characterEffect1081ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.0166666666666667

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1081ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1081ui_story then
				arg_197_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_200_4 = 0
			local var_200_5 = 0.825

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(1108102048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 33 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 33)

				if (33 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 33)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102048", "story_v_side_new_1108102.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102048", "story_v_side_new_1108102.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_side_new_1108102", "1108102048", "story_v_side_new_1108102.awb")

						arg_197_1:RecordAudio("1108102048", var_200_11)
						arg_197_1:RecordAudio("1108102048", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102048", "story_v_side_new_1108102.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102048", "story_v_side_new_1108102.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1108102049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1108102050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1081ui_story"]) and arg_201_1.var_.characterEffect1081ui_story == nil then
				arg_201_1.var_.characterEffect1081ui_story = arg_201_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.0166666666666667

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1081ui_story"]) then
				if arg_201_1.var_.characterEffect1081ui_story and not isNil(arg_201_1.actors_["1081ui_story"]) then
					arg_201_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1081ui_story"]) and arg_201_1.var_.characterEffect1081ui_story then
				arg_201_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1108102049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 5 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 5)

				if (5 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 5)) > 0 and var_204_2 < var_204_5 then
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
	Play1108102050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1108102050
		arg_205_1.duration_ = 7.47

		local var_205_0 = {
			ja = 7.466,
			ko = 4.833,
			zh = 4.833
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
				arg_205_0:Play1108102051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1081ui_story = arg_205_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1081ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story == nil then
				arg_205_1.var_.characterEffect1081ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.0166666666666667

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1081ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story then
				arg_205_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_208_4 = 0
			local var_208_5 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(1108102050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 22 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 22)

				if (22 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 22)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102050", "story_v_side_new_1108102.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102050", "story_v_side_new_1108102.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_side_new_1108102", "1108102050", "story_v_side_new_1108102.awb")

						arg_205_1:RecordAudio("1108102050", var_208_11)
						arg_205_1:RecordAudio("1108102050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102050", "story_v_side_new_1108102.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102050", "story_v_side_new_1108102.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108102051
		arg_209_1.duration_ = 2.4

		local var_209_0 = {
			ja = 2.266,
			ko = 2.4,
			zh = 2.4
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
				arg_209_0:Play1108102052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1081ui_story = arg_209_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1081ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story == nil then
				arg_209_1.var_.characterEffect1081ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.0166666666666667

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1081ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story then
				arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.35

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(1108102051)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 14 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 14)

				if (14 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 14)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102051", "story_v_side_new_1108102.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102051", "story_v_side_new_1108102.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_side_new_1108102", "1108102051", "story_v_side_new_1108102.awb")

						arg_209_1:RecordAudio("1108102051", var_212_11)
						arg_209_1:RecordAudio("1108102051", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102051", "story_v_side_new_1108102.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102051", "story_v_side_new_1108102.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1108102052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108102052
		arg_213_1.duration_ = 7.8

		local var_213_0 = {
			ja = 7.8,
			ko = 7.4,
			zh = 7.4
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
				arg_213_0:Play1108102053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.ST04b == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04b")
				var_216_0.name = "ST04b"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.ST04b = var_216_0
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.ST04b

				arg_213_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "ST04b" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_5 = 2

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_5 then
				local var_216_6 = Color.New(0, 0, 0)

				var_216_6.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_4) / var_216_5)
				arg_213_1.mask_.color = var_216_6
			end

			if arg_213_1.time_ >= var_216_4 + var_216_5 and arg_213_1.time_ < var_216_4 + var_216_5 + arg_216_0 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = 1
				arg_213_1.mask_.color = var_216_7
			end

			local var_216_8 = 2

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_9 = 2

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 then
				local var_216_10 = Color.New(0, 0, 0)

				var_216_10.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_8) / var_216_9)
				arg_213_1.mask_.color = var_216_10
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 then
				local var_216_11 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_11.a = 0
				arg_213_1.mask_.color = var_216_11
			end

			local var_216_12 = arg_213_1.actors_["1081ui_story"].transform

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= 4 + arg_216_0 then
				arg_213_1.var_.moveOldPos1081ui_story = var_216_12.localPosition
			end

			local var_216_13 = 0.001

			if 4 <= arg_213_1.time_ and arg_213_1.time_ < 4 + var_216_13 then
				var_216_12.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_213_1.time_ - 4) / var_216_13)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			if arg_213_1.time_ >= 4 + var_216_13 and arg_213_1.time_ < 4 + var_216_13 + arg_216_0 then
				var_216_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			local var_216_14 = arg_213_1.actors_["1081ui_story"]

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= 4 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.characterEffect1081ui_story == nil then
				arg_213_1.var_.characterEffect1081ui_story = var_216_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_15 = 0.0166666666666667

			if 4 <= arg_213_1.time_ and arg_213_1.time_ < 4 + var_216_15 and not isNil(var_216_14) then
				if arg_213_1.var_.characterEffect1081ui_story and not isNil(var_216_14) then
					arg_213_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 4 + var_216_15 and arg_213_1.time_ < 4 + var_216_15 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.characterEffect1081ui_story then
				arg_213_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_216_17 = arg_213_1.actors_["1081ui_story"].transform

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				arg_213_1.var_.moveOldPos1081ui_story = var_216_17.localPosition
			end

			local var_216_18 = 0.001

			if 2 <= arg_213_1.time_ and arg_213_1.time_ < 2 + var_216_18 then
				var_216_17.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 2) / var_216_18)
				var_216_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_17.position).x, (manager.ui.mainCamera.transform.position - var_216_17.position).y, (manager.ui.mainCamera.transform.position - var_216_17.position).z)
				var_216_17.localEulerAngles.z = 0
				var_216_17.localEulerAngles.x = 0
				var_216_17.localEulerAngles = var_216_17.localEulerAngles
			end

			if arg_213_1.time_ >= 2 + var_216_18 and arg_213_1.time_ < 2 + var_216_18 + arg_216_0 then
				var_216_17.localPosition = Vector3.New(0, 100, 0)
				var_216_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_17.position).x, (manager.ui.mainCamera.transform.position - var_216_17.position).y, (manager.ui.mainCamera.transform.position - var_216_17.position).z)
				var_216_17.localEulerAngles.z = 0
				var_216_17.localEulerAngles.x = 0
				var_216_17.localEulerAngles = var_216_17.localEulerAngles
			end

			if 1.6 < arg_213_1.time_ and arg_213_1.time_ <= 1.6 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_20 = 4
			local var_216_21 = 0.15

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_20 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_22 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_22:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_23 = arg_213_1:GetWordFromCfg(1108102052)
				local var_216_24 = arg_213_1:FormatText(var_216_23.content)

				arg_213_1.text_.text = var_216_24

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_26 = 6 <= 0 and var_216_21 or var_216_21 * (utf8.len(var_216_24) / 6)

				if (6 <= 0 and var_216_21 or var_216_21 * (utf8.len(var_216_24) / 6)) > 0 and var_216_21 < var_216_26 then
					arg_213_1.talkMaxDuration = var_216_26
					var_216_20 = var_216_20 + 0.3

					if var_216_26 + var_216_20 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_26 + var_216_20
					end
				end

				arg_213_1.text_.text = var_216_24
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102052", "story_v_side_new_1108102.awb") ~= 0 then
					local var_216_27 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102052", "story_v_side_new_1108102.awb") / 1000

					if var_216_27 + var_216_20 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_27 + var_216_20
					end

					if var_216_23.prefab_name ~= "" and arg_213_1.actors_[var_216_23.prefab_name] ~= nil then
						local var_216_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_23.prefab_name].transform, "story_v_side_new_1108102", "1108102052", "story_v_side_new_1108102.awb")

						arg_213_1:RecordAudio("1108102052", var_216_28)
						arg_213_1:RecordAudio("1108102052", var_216_28)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102052", "story_v_side_new_1108102.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102052", "story_v_side_new_1108102.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_29 = var_216_20 + 0.3
			local var_216_30 = math.max(var_216_21, arg_213_1.talkMaxDuration)

			if var_216_20 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_29 + var_216_30 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_29) / var_216_30

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_29 + var_216_30 and arg_213_1.time_ < var_216_29 + var_216_30 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1108102053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1108102053
		arg_219_1.duration_ = 5.7

		local var_219_0 = {
			ja = 5.7,
			ko = 2.933,
			zh = 2.933
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
				arg_219_0:Play1108102054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(1108102053)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 15 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 15)

				if (15 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 15)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102053", "story_v_side_new_1108102.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102053", "story_v_side_new_1108102.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_side_new_1108102", "1108102053", "story_v_side_new_1108102.awb")

						arg_219_1:RecordAudio("1108102053", var_222_6)
						arg_219_1:RecordAudio("1108102053", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102053", "story_v_side_new_1108102.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102053", "story_v_side_new_1108102.awb")
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
	Play1108102054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1108102054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1108102055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1081ui_story"]) and arg_223_1.var_.characterEffect1081ui_story == nil then
				arg_223_1.var_.characterEffect1081ui_story = arg_223_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.0166666666666667

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1081ui_story"]) then
				if arg_223_1.var_.characterEffect1081ui_story and not isNil(arg_223_1.actors_["1081ui_story"]) then
					arg_223_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1081ui_story"]) and arg_223_1.var_.characterEffect1081ui_story then
				arg_223_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_226_1 = arg_223_1.actors_["1081ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1081ui_story = var_226_1.localPosition
			end

			local var_226_2 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 then
				var_226_1.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_2)
				var_226_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_1.position).x, (manager.ui.mainCamera.transform.position - var_226_1.position).y, (manager.ui.mainCamera.transform.position - var_226_1.position).z)
				var_226_1.localEulerAngles.z = 0
				var_226_1.localEulerAngles.x = 0
				var_226_1.localEulerAngles = var_226_1.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 then
				var_226_1.localPosition = Vector3.New(0, 100, 0)
				var_226_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_1.position).x, (manager.ui.mainCamera.transform.position - var_226_1.position).y, (manager.ui.mainCamera.transform.position - var_226_1.position).z)
				var_226_1.localEulerAngles.z = 0
				var_226_1.localEulerAngles.x = 0
				var_226_1.localEulerAngles = var_226_1.localEulerAngles
			end

			local var_226_3 = 0
			local var_226_4 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_3 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_5 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1108102054).content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 27 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 27)

				if (27 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 27)) > 0 and var_226_4 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_3 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_3
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_4, arg_223_1.talkMaxDuration)

			if var_226_3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_3 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_3) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_3 + var_226_8 and arg_223_1.time_ < var_226_3 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1108102055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1108102055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1108102056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.925

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1108102055).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 37 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 37)

				if (37 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 37)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1108102056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1108102056
		arg_231_1.duration_ = 7.13

		local var_231_0 = {
			ja = 7.133,
			ko = 5.333,
			zh = 5.333
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
				arg_231_0:Play1108102057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1081ui_story = arg_231_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).z)
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles = arg_231_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_231_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1081ui_story"].transform.position).z)
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1081ui_story"].transform.localEulerAngles = arg_231_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1081ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1081ui_story == nil then
				arg_231_1.var_.characterEffect1081ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.0166666666666667

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1081ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1081ui_story then
				arg_231_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_234_4 = 0
			local var_234_5 = 0.625

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(1108102056)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 25 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 25)

				if (25 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 25)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102056", "story_v_side_new_1108102.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102056", "story_v_side_new_1108102.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_side_new_1108102", "1108102056", "story_v_side_new_1108102.awb")

						arg_231_1:RecordAudio("1108102056", var_234_11)
						arg_231_1:RecordAudio("1108102056", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102056", "story_v_side_new_1108102.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102056", "story_v_side_new_1108102.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1108102057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1108102057
		arg_235_1.duration_ = 6.73

		local var_235_0 = {
			ja = 6.266,
			ko = 6.733,
			zh = 6.733
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
				arg_235_0:Play1108102058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.725

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(1108102057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 29 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 29)

				if (29 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 29)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102057", "story_v_side_new_1108102.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102057", "story_v_side_new_1108102.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_side_new_1108102", "1108102057", "story_v_side_new_1108102.awb")

						arg_235_1:RecordAudio("1108102057", var_238_6)
						arg_235_1:RecordAudio("1108102057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102057", "story_v_side_new_1108102.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102057", "story_v_side_new_1108102.awb")
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
	Play1108102058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1108102058
		arg_239_1.duration_ = 4.3

		local var_239_0 = {
			ja = 4.3,
			ko = 2,
			zh = 2
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
				arg_239_0:Play1108102059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(1108102058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 9)

				if (9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 9)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102058", "story_v_side_new_1108102.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102058", "story_v_side_new_1108102.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_side_new_1108102", "1108102058", "story_v_side_new_1108102.awb")

						arg_239_1:RecordAudio("1108102058", var_242_6)
						arg_239_1:RecordAudio("1108102058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102058", "story_v_side_new_1108102.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102058", "story_v_side_new_1108102.awb")
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
	Play1108102059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1108102059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1108102060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1081ui_story = arg_243_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).z)
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles = arg_243_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1081ui_story"].transform.position).z)
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1081ui_story"].transform.localEulerAngles = arg_243_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_246_1 = 0
			local var_246_2 = 1.125

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1108102059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 45 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 45)

				if (45 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 45)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1108102060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1108102060
		arg_247_1.duration_ = 7.5

		local var_247_0 = {
			ja = 7.5,
			ko = 4.3,
			zh = 4.3
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
				arg_247_0:Play1108102061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1081ui_story = arg_247_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).z)
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles = arg_247_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_247_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1081ui_story"].transform.position).z)
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1081ui_story"].transform.localEulerAngles = arg_247_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1081ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1081ui_story == nil then
				arg_247_1.var_.characterEffect1081ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1081ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1081ui_story then
				arg_247_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.5

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(1108102060)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 20 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 20)

				if (20 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 20)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102060", "story_v_side_new_1108102.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102060", "story_v_side_new_1108102.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_side_new_1108102", "1108102060", "story_v_side_new_1108102.awb")

						arg_247_1:RecordAudio("1108102060", var_250_11)
						arg_247_1:RecordAudio("1108102060", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102060", "story_v_side_new_1108102.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102060", "story_v_side_new_1108102.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1108102061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1108102061
		arg_251_1.duration_ = 9.03

		local var_251_0 = {
			ja = 9.033,
			ko = 8.833,
			zh = 8.833
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
				arg_251_0:Play1108102062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_254_0 = 0
			local var_254_1 = 0.9

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(1108102061)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 36 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 36)

				if (36 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 36)) > 0 and var_254_1 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102061", "story_v_side_new_1108102.awb") ~= 0 then
					local var_254_6 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102061", "story_v_side_new_1108102.awb") / 1000

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_side_new_1108102", "1108102061", "story_v_side_new_1108102.awb")

						arg_251_1:RecordAudio("1108102061", var_254_7)
						arg_251_1:RecordAudio("1108102061", var_254_7)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102061", "story_v_side_new_1108102.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102061", "story_v_side_new_1108102.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1108102062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1108102062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1108102063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1081ui_story"]) and arg_255_1.var_.characterEffect1081ui_story == nil then
				arg_255_1.var_.characterEffect1081ui_story = arg_255_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.0166666666666667

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1081ui_story"]) then
				if arg_255_1.var_.characterEffect1081ui_story and not isNil(arg_255_1.actors_["1081ui_story"]) then
					arg_255_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1081ui_story"]) and arg_255_1.var_.characterEffect1081ui_story then
				arg_255_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.375

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1108102062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 15 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 15)

				if (15 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 15)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1108102063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1108102063
		arg_259_1.duration_ = 2.63

		local var_259_0 = {
			ja = 2.633,
			ko = 2.1,
			zh = 2.1
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1108102064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1081ui_story = arg_259_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).z)
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles = arg_259_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_259_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1081ui_story"].transform.position).z)
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1081ui_story"].transform.localEulerAngles = arg_259_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1081ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1081ui_story == nil then
				arg_259_1.var_.characterEffect1081ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.0166666666666667

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1081ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1081ui_story then
				arg_259_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.175

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(1108102063)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 7 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 7)

				if (7 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 7)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102063", "story_v_side_new_1108102.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102063", "story_v_side_new_1108102.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_side_new_1108102", "1108102063", "story_v_side_new_1108102.awb")

						arg_259_1:RecordAudio("1108102063", var_262_11)
						arg_259_1:RecordAudio("1108102063", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102063", "story_v_side_new_1108102.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102063", "story_v_side_new_1108102.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play1108102064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1108102064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1108102065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1081ui_story"]) and arg_263_1.var_.characterEffect1081ui_story == nil then
				arg_263_1.var_.characterEffect1081ui_story = arg_263_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.0166666666666667

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1081ui_story"]) then
				if arg_263_1.var_.characterEffect1081ui_story and not isNil(arg_263_1.actors_["1081ui_story"]) then
					arg_263_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1081ui_story"]) and arg_263_1.var_.characterEffect1081ui_story then
				arg_263_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.475

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1108102064).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 19 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 19)

				if (19 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 19)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1108102065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1108102065
		arg_267_1.duration_ = 8.53

		local var_267_0 = {
			ja = 7.366,
			ko = 8.533,
			zh = 8.533
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
				arg_267_0:Play1108102066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1081ui_story = arg_267_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).z)
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles = arg_267_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_267_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1081ui_story"].transform.position).z)
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1081ui_story"].transform.localEulerAngles = arg_267_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1081ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1081ui_story == nil then
				arg_267_1.var_.characterEffect1081ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.0166666666666667

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1081ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1081ui_story then
				arg_267_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_270_4 = 0
			local var_270_5 = 1.125

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(1108102065)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 45 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 45)

				if (45 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 45)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102065", "story_v_side_new_1108102.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102065", "story_v_side_new_1108102.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_side_new_1108102", "1108102065", "story_v_side_new_1108102.awb")

						arg_267_1:RecordAudio("1108102065", var_270_11)
						arg_267_1:RecordAudio("1108102065", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102065", "story_v_side_new_1108102.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102065", "story_v_side_new_1108102.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1108102066
		arg_271_1.duration_ = 13

		local var_271_0 = {
			ja = 9.5,
			ko = 13,
			zh = 13
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
				arg_271_0:Play1108102067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1081ui_story = arg_271_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).z)
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles = arg_271_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_271_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1081ui_story"].transform.position).z)
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1081ui_story"].transform.localEulerAngles = arg_271_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1081ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1081ui_story == nil then
				arg_271_1.var_.characterEffect1081ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.0166666666666667

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1081ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1081ui_story then
				arg_271_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_274_4 = 0
			local var_274_5 = 1.625

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(1108102066)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 65 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 65)

				if (65 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 65)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102066", "story_v_side_new_1108102.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102066", "story_v_side_new_1108102.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_side_new_1108102", "1108102066", "story_v_side_new_1108102.awb")

						arg_271_1:RecordAudio("1108102066", var_274_11)
						arg_271_1:RecordAudio("1108102066", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102066", "story_v_side_new_1108102.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102066", "story_v_side_new_1108102.awb")
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

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play1108102067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1108102067
		arg_275_1.duration_ = 5.9

		local var_275_0 = {
			ja = 5.9,
			ko = 3.3,
			zh = 3.3
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
				arg_275_0:Play1108102068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1081ui_story = arg_275_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).z)
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles = arg_275_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_275_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1081ui_story"].transform.position).z)
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1081ui_story"].transform.localEulerAngles = arg_275_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1081ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1081ui_story == nil then
				arg_275_1.var_.characterEffect1081ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.0166666666666667

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1081ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1081ui_story then
				arg_275_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_278_4 = 0
			local var_278_5 = 0.5

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(1108102067)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 20 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 20)

				if (20 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 20)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102067", "story_v_side_new_1108102.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102067", "story_v_side_new_1108102.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_side_new_1108102", "1108102067", "story_v_side_new_1108102.awb")

						arg_275_1:RecordAudio("1108102067", var_278_11)
						arg_275_1:RecordAudio("1108102067", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102067", "story_v_side_new_1108102.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102067", "story_v_side_new_1108102.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108102068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1108102068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1108102069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1081ui_story"]) and arg_279_1.var_.characterEffect1081ui_story == nil then
				arg_279_1.var_.characterEffect1081ui_story = arg_279_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.0166666666666667

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1081ui_story"]) then
				if arg_279_1.var_.characterEffect1081ui_story and not isNil(arg_279_1.actors_["1081ui_story"]) then
					arg_279_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1081ui_story"]) and arg_279_1.var_.characterEffect1081ui_story then
				arg_279_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_282_1 = 0
			local var_282_2 = 0.775

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1108102068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 31 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 31)

				if (31 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 31)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1108102069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1108102069
		arg_283_1.duration_ = 2

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1108102070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1081ui_story = arg_283_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).z)
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles = arg_283_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_283_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1081ui_story"].transform.position).z)
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1081ui_story"].transform.localEulerAngles = arg_283_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1081ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1081ui_story == nil then
				arg_283_1.var_.characterEffect1081ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.0166666666666667

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1081ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1081ui_story then
				arg_283_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.25

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(1108102069)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 10 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 10)

				if (10 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 10)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102069", "story_v_side_new_1108102.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102069", "story_v_side_new_1108102.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_side_new_1108102", "1108102069", "story_v_side_new_1108102.awb")

						arg_283_1:RecordAudio("1108102069", var_286_11)
						arg_283_1:RecordAudio("1108102069", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102069", "story_v_side_new_1108102.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102069", "story_v_side_new_1108102.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play1108102070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1108102070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1108102071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1081ui_story"]) and arg_287_1.var_.characterEffect1081ui_story == nil then
				arg_287_1.var_.characterEffect1081ui_story = arg_287_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.0166666666666667

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1081ui_story"]) then
				if arg_287_1.var_.characterEffect1081ui_story and not isNil(arg_287_1.actors_["1081ui_story"]) then
					arg_287_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1081ui_story"]) and arg_287_1.var_.characterEffect1081ui_story then
				arg_287_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.5

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1108102070).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 20 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 20)

				if (20 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 20)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1108102071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1108102071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1108102072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.9

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1108102071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 36 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 36)

				if (36 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 36)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1108102072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1108102072
		arg_295_1.duration_ = 12.1

		local var_295_0 = {
			ja = 12.1,
			ko = 5.466,
			zh = 5.466
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1108102073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1081ui_story = arg_295_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).z)
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles = arg_295_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_295_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1081ui_story"].transform.position).z)
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1081ui_story"].transform.localEulerAngles = arg_295_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1081ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1081ui_story == nil then
				arg_295_1.var_.characterEffect1081ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.0166666666666667

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1081ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1081ui_story then
				arg_295_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.85

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(1108102072)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 34 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 34)

				if (34 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 34)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102072", "story_v_side_new_1108102.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102072", "story_v_side_new_1108102.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_side_new_1108102", "1108102072", "story_v_side_new_1108102.awb")

						arg_295_1:RecordAudio("1108102072", var_298_11)
						arg_295_1:RecordAudio("1108102072", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102072", "story_v_side_new_1108102.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102072", "story_v_side_new_1108102.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play1108102073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1108102073
		arg_299_1.duration_ = 8.5

		local var_299_0 = {
			ja = 2.9,
			ko = 8.5,
			zh = 8.5
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1108102074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.05

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(1108102073)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 42 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 42)

				if (42 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 42)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102073", "story_v_side_new_1108102.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102073", "story_v_side_new_1108102.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_side_new_1108102", "1108102073", "story_v_side_new_1108102.awb")

						arg_299_1:RecordAudio("1108102073", var_302_6)
						arg_299_1:RecordAudio("1108102073", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102073", "story_v_side_new_1108102.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102073", "story_v_side_new_1108102.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1108102074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1108102074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1108102075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1081ui_story"]) and arg_303_1.var_.characterEffect1081ui_story == nil then
				arg_303_1.var_.characterEffect1081ui_story = arg_303_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.0166666666666667

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1081ui_story"]) then
				if arg_303_1.var_.characterEffect1081ui_story and not isNil(arg_303_1.actors_["1081ui_story"]) then
					arg_303_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1081ui_story"]) and arg_303_1.var_.characterEffect1081ui_story then
				arg_303_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.075

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1108102074).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 3 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 3)

				if (3 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 3)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1108102075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1108102075
		arg_307_1.duration_ = 15.67

		local var_307_0 = {
			ja = 15.666,
			ko = 10.1,
			zh = 10.1
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1108102076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1081ui_story = arg_307_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).z)
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles = arg_307_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_307_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1081ui_story"].transform.position).z)
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1081ui_story"].transform.localEulerAngles = arg_307_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1081ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1081ui_story == nil then
				arg_307_1.var_.characterEffect1081ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.0166666666666667

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1081ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1081ui_story then
				arg_307_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action467")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_310_4 = 0
			local var_310_5 = 1.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(1108102075)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 45 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 45)

				if (45 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 45)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102075", "story_v_side_new_1108102.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102075", "story_v_side_new_1108102.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_side_new_1108102", "1108102075", "story_v_side_new_1108102.awb")

						arg_307_1:RecordAudio("1108102075", var_310_11)
						arg_307_1:RecordAudio("1108102075", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102075", "story_v_side_new_1108102.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102075", "story_v_side_new_1108102.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1108102076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1108102076
		arg_311_1.duration_ = 7.3

		local var_311_0 = {
			ja = 7.3,
			ko = 5.433,
			zh = 5.433
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1108102077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.675

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(1108102076)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 27)

				if (27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 27)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102076", "story_v_side_new_1108102.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102076", "story_v_side_new_1108102.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_side_new_1108102", "1108102076", "story_v_side_new_1108102.awb")

						arg_311_1:RecordAudio("1108102076", var_314_6)
						arg_311_1:RecordAudio("1108102076", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102076", "story_v_side_new_1108102.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102076", "story_v_side_new_1108102.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1108102077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1108102077
		arg_315_1.duration_ = 10.73

		local var_315_0 = {
			ja = 10.733,
			ko = 7.133,
			zh = 7.133
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1108102078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.95

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(1108102077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 38 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 38)

				if (38 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 38)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102077", "story_v_side_new_1108102.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102077", "story_v_side_new_1108102.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_side_new_1108102", "1108102077", "story_v_side_new_1108102.awb")

						arg_315_1:RecordAudio("1108102077", var_318_6)
						arg_315_1:RecordAudio("1108102077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102077", "story_v_side_new_1108102.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102077", "story_v_side_new_1108102.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1108102078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1108102078
		arg_319_1.duration_ = 14.4

		local var_319_0 = {
			ja = 14.4,
			ko = 9.866,
			zh = 9.866
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1108102079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1081ui_story = arg_319_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).z)
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles = arg_319_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_319_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1081ui_story"].transform.position).z)
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1081ui_story"].transform.localEulerAngles = arg_319_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1081ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1081ui_story == nil then
				arg_319_1.var_.characterEffect1081ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.0166666666666667

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1081ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1081ui_story then
				arg_319_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_322_4 = 0
			local var_322_5 = 1.375

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(1108102078)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 55 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 55)

				if (55 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 55)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102078", "story_v_side_new_1108102.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102078", "story_v_side_new_1108102.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_side_new_1108102", "1108102078", "story_v_side_new_1108102.awb")

						arg_319_1:RecordAudio("1108102078", var_322_11)
						arg_319_1:RecordAudio("1108102078", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102078", "story_v_side_new_1108102.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102078", "story_v_side_new_1108102.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play1108102079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1108102079
		arg_323_1.duration_ = 7.43

		local var_323_0 = {
			ja = 4.233,
			ko = 7.433,
			zh = 7.433
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1108102080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1081ui_story = arg_323_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).z)
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles = arg_323_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_323_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1081ui_story"].transform.position).z)
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1081ui_story"].transform.localEulerAngles = arg_323_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1081ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1081ui_story == nil then
				arg_323_1.var_.characterEffect1081ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.0166666666666667

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1081ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1081ui_story then
				arg_323_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_326_4 = 0
			local var_326_5 = 0.75

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(1108102079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 30 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 30)

				if (30 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 30)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102079", "story_v_side_new_1108102.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102079", "story_v_side_new_1108102.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_side_new_1108102", "1108102079", "story_v_side_new_1108102.awb")

						arg_323_1:RecordAudio("1108102079", var_326_11)
						arg_323_1:RecordAudio("1108102079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102079", "story_v_side_new_1108102.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102079", "story_v_side_new_1108102.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1108102080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1108102080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1108102081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1081ui_story"]) and arg_327_1.var_.characterEffect1081ui_story == nil then
				arg_327_1.var_.characterEffect1081ui_story = arg_327_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.0166666666666667

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1081ui_story"]) then
				if arg_327_1.var_.characterEffect1081ui_story and not isNil(arg_327_1.actors_["1081ui_story"]) then
					arg_327_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1081ui_story"]) and arg_327_1.var_.characterEffect1081ui_story then
				arg_327_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.8

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1108102080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 32 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 32)

				if (32 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 32)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1108102081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1108102081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1108102082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.525

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1108102081).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 21 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 21)

				if (21 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 21)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1108102082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1108102082
		arg_335_1.duration_ = 3.9

		local var_335_0 = {
			ja = 3.233,
			ko = 3.9,
			zh = 3.9
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1108102083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1081ui_story = arg_335_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).z)
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles = arg_335_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_335_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1081ui_story"].transform.position).z)
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1081ui_story"].transform.localEulerAngles = arg_335_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1081ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1081ui_story == nil then
				arg_335_1.var_.characterEffect1081ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.0166666666666667

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1081ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1081ui_story then
				arg_335_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_338_4 = 0
			local var_338_5 = 0.5

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:GetWordFromCfg(1108102082)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 20 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 20)

				if (20 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 20)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102082", "story_v_side_new_1108102.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102082", "story_v_side_new_1108102.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_side_new_1108102", "1108102082", "story_v_side_new_1108102.awb")

						arg_335_1:RecordAudio("1108102082", var_338_11)
						arg_335_1:RecordAudio("1108102082", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102082", "story_v_side_new_1108102.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102082", "story_v_side_new_1108102.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1108102083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1108102083
		arg_339_1.duration_ = 5.73

		local var_339_0 = {
			ja = 5.733,
			ko = 2.9,
			zh = 2.9
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1108102084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1081ui_story = arg_339_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).z)
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles = arg_339_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_339_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1081ui_story"].transform.position).z)
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1081ui_story"].transform.localEulerAngles = arg_339_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1081ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1081ui_story == nil then
				arg_339_1.var_.characterEffect1081ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.0166666666666667

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1081ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1081ui_story then
				arg_339_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.4

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(1108102083)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 16 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 16)

				if (16 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 16)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102083", "story_v_side_new_1108102.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102083", "story_v_side_new_1108102.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_side_new_1108102", "1108102083", "story_v_side_new_1108102.awb")

						arg_339_1:RecordAudio("1108102083", var_342_11)
						arg_339_1:RecordAudio("1108102083", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102083", "story_v_side_new_1108102.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102083", "story_v_side_new_1108102.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play1108102084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1108102084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1108102085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1081ui_story"]) and arg_343_1.var_.characterEffect1081ui_story == nil then
				arg_343_1.var_.characterEffect1081ui_story = arg_343_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.0166666666666667

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1081ui_story"]) then
				if arg_343_1.var_.characterEffect1081ui_story and not isNil(arg_343_1.actors_["1081ui_story"]) then
					arg_343_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1081ui_story"]) and arg_343_1.var_.characterEffect1081ui_story then
				arg_343_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.225

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1108102084).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 9 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 9)

				if (9 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 9)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1108102085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1108102085
		arg_347_1.duration_ = 2

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1108102086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1081ui_story = arg_347_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).z)
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles = arg_347_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_347_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1081ui_story"].transform.position).z)
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1081ui_story"].transform.localEulerAngles = arg_347_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["1081ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1081ui_story == nil then
				arg_347_1.var_.characterEffect1081ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.0166666666666667

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect1081ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1081ui_story then
				arg_347_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_350_4 = 0
			local var_350_5 = 0.1

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(1108102085)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 4 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 4)

				if (4 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 4)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102085", "story_v_side_new_1108102.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102085", "story_v_side_new_1108102.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_side_new_1108102", "1108102085", "story_v_side_new_1108102.awb")

						arg_347_1:RecordAudio("1108102085", var_350_11)
						arg_347_1:RecordAudio("1108102085", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102085", "story_v_side_new_1108102.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102085", "story_v_side_new_1108102.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play1108102086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1108102086
		arg_351_1.duration_ = 9

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1108102087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if arg_351_1.bgs_.ST15 == nil then
				local var_354_0 = Object.Instantiate(arg_351_1.paintGo_)

				var_354_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_354_0.name = "ST15"
				var_354_0.transform.parent = arg_351_1.stage_.transform
				var_354_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.bgs_.ST15 = var_354_0
			end

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= 2 + arg_354_0 then
				local var_354_1 = arg_351_1.bgs_.ST15

				arg_351_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_354_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_2 = var_354_1:GetComponent("SpriteRenderer")

				if var_354_2 and var_354_2.sprite then
					local var_354_3 = 2 * (var_354_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_354_1.transform.localScale = Vector3.New(var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "ST15" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_4 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_5 = 2

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_5 then
				local var_354_6 = Color.New(0, 0, 0)

				var_354_6.a = Mathf.Lerp(0, 1, (arg_351_1.time_ - var_354_4) / var_354_5)
				arg_351_1.mask_.color = var_354_6
			end

			if arg_351_1.time_ >= var_354_4 + var_354_5 and arg_351_1.time_ < var_354_4 + var_354_5 + arg_354_0 then
				local var_354_7 = Color.New(0, 0, 0)

				var_354_7.a = 1
				arg_351_1.mask_.color = var_354_7
			end

			local var_354_8 = 2

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_9 = 2

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_9 then
				local var_354_10 = Color.New(0, 0, 0)

				var_354_10.a = Mathf.Lerp(1, 0, (arg_351_1.time_ - var_354_8) / var_354_9)
				arg_351_1.mask_.color = var_354_10
			end

			if arg_351_1.time_ >= var_354_8 + var_354_9 and arg_351_1.time_ < var_354_8 + var_354_9 + arg_354_0 then
				local var_354_11 = Color.New(0, 0, 0)

				arg_351_1.mask_.enabled = false
				var_354_11.a = 0
				arg_351_1.mask_.color = var_354_11
			end

			local var_354_12 = arg_351_1.actors_["1081ui_story"].transform

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= 2 + arg_354_0 then
				arg_351_1.var_.moveOldPos1081ui_story = var_354_12.localPosition
			end

			local var_354_13 = 0.001

			if 2 <= arg_351_1.time_ and arg_351_1.time_ < 2 + var_354_13 then
				var_354_12.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 2) / var_354_13)
				var_354_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_12.position).x, (manager.ui.mainCamera.transform.position - var_354_12.position).y, (manager.ui.mainCamera.transform.position - var_354_12.position).z)
				var_354_12.localEulerAngles.z = 0
				var_354_12.localEulerAngles.x = 0
				var_354_12.localEulerAngles = var_354_12.localEulerAngles
			end

			if arg_351_1.time_ >= 2 + var_354_13 and arg_351_1.time_ < 2 + var_354_13 + arg_354_0 then
				var_354_12.localPosition = Vector3.New(0, 100, 0)
				var_354_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_12.position).x, (manager.ui.mainCamera.transform.position - var_354_12.position).y, (manager.ui.mainCamera.transform.position - var_354_12.position).z)
				var_354_12.localEulerAngles.z = 0
				var_354_12.localEulerAngles.x = 0
				var_354_12.localEulerAngles = var_354_12.localEulerAngles
			end

			local var_354_14 = arg_351_1.actors_["1081ui_story"]

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= 2 + arg_354_0 and not isNil(var_354_14) and arg_351_1.var_.characterEffect1081ui_story == nil then
				arg_351_1.var_.characterEffect1081ui_story = var_354_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_15 = 0.0166666666666667

			if 2 <= arg_351_1.time_ and arg_351_1.time_ < 2 + var_354_15 and not isNil(var_354_14) then
				if arg_351_1.var_.characterEffect1081ui_story and not isNil(var_354_14) then
					arg_351_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 2) / var_354_15)
				end
			end

			if arg_351_1.time_ >= 2 + var_354_15 and arg_351_1.time_ < 2 + var_354_15 + arg_354_0 and not isNil(var_354_14) and arg_351_1.var_.characterEffect1081ui_story then
				arg_351_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 1.6 < arg_351_1.time_ and arg_351_1.time_ <= 1.6 + arg_354_0 then
				arg_351_1:AudioAction("stop", "music", "se_story_16", "se_story_16_street_loop", "")

				local var_354_18 = manager.audio:GetAudioName("se_story_16", "se_story_16_street_loop")

				if "" ~= "" then
					if arg_351_1.bgmTxt_.text ~= var_354_18 and arg_351_1.bgmTxt_.text ~= "" then
						if arg_351_1.bgmTxt2_.text ~= "" then
							arg_351_1.bgmTxt_.text = arg_351_1.bgmTxt2_.text
						end

						arg_351_1.bgmTxt2_.text = var_354_18

						arg_351_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_351_1.bgmTxt_.text = var_354_18
						arg_351_1.bgmTxt2_.text = var_354_18
					end

					if arg_351_1.bgmTimer then
						arg_351_1.bgmTimer:Stop()

						arg_351_1.bgmTimer = nil
					end

					if arg_351_1.settingData.show_music_name == 1 then
						arg_351_1.musicController:SetSelectedState("show")
						arg_351_1.musicAnimator_:Play("open", 0, 0)

						if arg_351_1.settingData.music_time ~= 0 then
							arg_351_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_351_1.settingData.music_time), function()
								if arg_351_1 == nil or isNil(arg_351_1.bgmTxt_) then
									return
								end

								arg_351_1.musicController:SetSelectedState("hide")
								arg_351_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.76666666666667 < arg_351_1.time_ and arg_351_1.time_ <= 1.76666666666667 + arg_354_0 then
				arg_351_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_20 = 4
			local var_354_21 = 0.55

			if 4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_20 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_22 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_22:setOnUpdate(LuaHelper.FloatAction(function(arg_356_0)
					arg_351_1.dialogCg_.alpha = arg_356_0
				end))
				var_354_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_23 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1108102086).content)

				arg_351_1.text_.text = var_354_23

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_25 = 22 <= 0 and var_354_21 or var_354_21 * (utf8.len(var_354_23) / 22)

				if (22 <= 0 and var_354_21 or var_354_21 * (utf8.len(var_354_23) / 22)) > 0 and var_354_21 < var_354_25 then
					arg_351_1.talkMaxDuration = var_354_25
					var_354_20 = var_354_20 + 0.3

					if var_354_25 + var_354_20 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_25 + var_354_20
					end
				end

				arg_351_1.text_.text = var_354_23
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_26 = var_354_20 + 0.3
			local var_354_27 = math.max(var_354_21, arg_351_1.talkMaxDuration)

			if var_354_20 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_26 + var_354_27 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_26) / var_354_27

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_26 + var_354_27 and arg_351_1.time_ < var_354_26 + var_354_27 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play1108102087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1108102087
		arg_358_1.duration_ = 4.13

		local var_358_0 = {
			ja = 4.133,
			ko = 2.466,
			zh = 2.466
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
				arg_358_0:Play1108102088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1081ui_story = arg_358_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).z)
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles = arg_358_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_358_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1081ui_story"].transform.position).z)
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1081ui_story"].transform.localEulerAngles = arg_358_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["1081ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1081ui_story == nil then
				arg_358_1.var_.characterEffect1081ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.0166666666666667

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect1081ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1081ui_story then
				arg_358_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_361_4 = 0
			local var_361_5 = 0.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_6 = arg_358_1:GetWordFromCfg(1108102087)
				local var_361_7 = arg_358_1:FormatText(var_361_6.content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 8 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 8)

				if (8 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 8)) > 0 and var_361_5 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102087", "story_v_side_new_1108102.awb") ~= 0 then
					local var_361_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102087", "story_v_side_new_1108102.awb") / 1000

					if var_361_10 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_4
					end

					if var_361_6.prefab_name ~= "" and arg_358_1.actors_[var_361_6.prefab_name] ~= nil then
						local var_361_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_6.prefab_name].transform, "story_v_side_new_1108102", "1108102087", "story_v_side_new_1108102.awb")

						arg_358_1:RecordAudio("1108102087", var_361_11)
						arg_358_1:RecordAudio("1108102087", var_361_11)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102087", "story_v_side_new_1108102.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102087", "story_v_side_new_1108102.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_12 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_12 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_12

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_12 and arg_358_1.time_ < var_361_4 + var_361_12 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play1108102088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108102088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108102089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1081ui_story"]) and arg_362_1.var_.characterEffect1081ui_story == nil then
				arg_362_1.var_.characterEffect1081ui_story = arg_362_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.0166666666666667

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1081ui_story"]) then
				if arg_362_1.var_.characterEffect1081ui_story and not isNil(arg_362_1.actors_["1081ui_story"]) then
					arg_362_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1081ui_story"]) and arg_362_1.var_.characterEffect1081ui_story then
				arg_362_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.425

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(1108102088).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 17 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 17)

				if (17 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 17)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1108102089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108102089
		arg_366_1.duration_ = 6.27

		local var_366_0 = {
			ja = 6.266,
			ko = 4.666,
			zh = 4.666
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
				arg_366_0:Play1108102090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1081ui_story = arg_366_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).z)
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles = arg_366_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_366_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1081ui_story"].transform.position).z)
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1081ui_story"].transform.localEulerAngles = arg_366_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["1081ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1081ui_story == nil then
				arg_366_1.var_.characterEffect1081ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.0166666666666667

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect1081ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1081ui_story then
				arg_366_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action465")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_369_4 = 0
			local var_369_5 = 0.55

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_6 = arg_366_1:GetWordFromCfg(1108102089)
				local var_369_7 = arg_366_1:FormatText(var_369_6.content)

				arg_366_1.text_.text = var_369_7

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_9 = 22 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 22)

				if (22 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 22)) > 0 and var_369_5 < var_369_9 then
					arg_366_1.talkMaxDuration = var_369_9

					if var_369_9 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_4
					end
				end

				arg_366_1.text_.text = var_369_7
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102089", "story_v_side_new_1108102.awb") ~= 0 then
					local var_369_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102089", "story_v_side_new_1108102.awb") / 1000

					if var_369_10 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_10 + var_369_4
					end

					if var_369_6.prefab_name ~= "" and arg_366_1.actors_[var_369_6.prefab_name] ~= nil then
						local var_369_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_6.prefab_name].transform, "story_v_side_new_1108102", "1108102089", "story_v_side_new_1108102.awb")

						arg_366_1:RecordAudio("1108102089", var_369_11)
						arg_366_1:RecordAudio("1108102089", var_369_11)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102089", "story_v_side_new_1108102.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102089", "story_v_side_new_1108102.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_12 = math.max(var_369_5, arg_366_1.talkMaxDuration)

			if var_369_4 <= arg_366_1.time_ and arg_366_1.time_ < var_369_4 + var_369_12 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_4) / var_369_12

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_4 + var_369_12 and arg_366_1.time_ < var_369_4 + var_369_12 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108102090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108102090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108102091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1081ui_story"]) and arg_370_1.var_.characterEffect1081ui_story == nil then
				arg_370_1.var_.characterEffect1081ui_story = arg_370_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.0166666666666667

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1081ui_story"]) then
				if arg_370_1.var_.characterEffect1081ui_story and not isNil(arg_370_1.actors_["1081ui_story"]) then
					arg_370_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1081ui_story"]) and arg_370_1.var_.characterEffect1081ui_story then
				arg_370_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 1.6

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1108102090).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 64 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 64)

				if (64 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 64)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108102091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108102091
		arg_374_1.duration_ = 4.37

		local var_374_0 = {
			ja = 4.366,
			ko = 2.9,
			zh = 2.9
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
				arg_374_0:Play1108102092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1081ui_story = arg_374_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).z)
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles = arg_374_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_374_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1081ui_story"].transform.position).z)
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1081ui_story"].transform.localEulerAngles = arg_374_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1081ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1081ui_story == nil then
				arg_374_1.var_.characterEffect1081ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.0166666666666667

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1081ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1081ui_story then
				arg_374_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_377_4 = 0
			local var_377_5 = 0.275

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(1108102091)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 11 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 11)

				if (11 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 11)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102091", "story_v_side_new_1108102.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102091", "story_v_side_new_1108102.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_side_new_1108102", "1108102091", "story_v_side_new_1108102.awb")

						arg_374_1:RecordAudio("1108102091", var_377_11)
						arg_374_1:RecordAudio("1108102091", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102091", "story_v_side_new_1108102.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102091", "story_v_side_new_1108102.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108102092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108102092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108102093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1081ui_story"]) and arg_378_1.var_.characterEffect1081ui_story == nil then
				arg_378_1.var_.characterEffect1081ui_story = arg_378_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.0166666666666667

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1081ui_story"]) then
				if arg_378_1.var_.characterEffect1081ui_story and not isNil(arg_378_1.actors_["1081ui_story"]) then
					arg_378_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1081ui_story"]) and arg_378_1.var_.characterEffect1081ui_story then
				arg_378_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.275

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(1108102092).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 11 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 11)

				if (11 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 11)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108102093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108102093
		arg_382_1.duration_ = 2.2

		local var_382_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108102094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1081ui_story = arg_382_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).z)
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles = arg_382_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_382_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1081ui_story"].transform.position).z)
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1081ui_story"].transform.localEulerAngles = arg_382_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["1081ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1081ui_story == nil then
				arg_382_1.var_.characterEffect1081ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.0166666666666667

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect1081ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1081ui_story then
				arg_382_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_385_4 = 0
			local var_385_5 = 0.1

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_6 = arg_382_1:GetWordFromCfg(1108102093)
				local var_385_7 = arg_382_1:FormatText(var_385_6.content)

				arg_382_1.text_.text = var_385_7

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_9 = 4 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 4)

				if (4 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 4)) > 0 and var_385_5 < var_385_9 then
					arg_382_1.talkMaxDuration = var_385_9

					if var_385_9 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_9 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_7
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102093", "story_v_side_new_1108102.awb") ~= 0 then
					local var_385_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102093", "story_v_side_new_1108102.awb") / 1000

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end

					if var_385_6.prefab_name ~= "" and arg_382_1.actors_[var_385_6.prefab_name] ~= nil then
						local var_385_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_6.prefab_name].transform, "story_v_side_new_1108102", "1108102093", "story_v_side_new_1108102.awb")

						arg_382_1:RecordAudio("1108102093", var_385_11)
						arg_382_1:RecordAudio("1108102093", var_385_11)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102093", "story_v_side_new_1108102.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102093", "story_v_side_new_1108102.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_12 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_12 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_4) / var_385_12

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_4 + var_385_12 and arg_382_1.time_ < var_385_4 + var_385_12 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108102094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108102094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108102095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1081ui_story"]) and arg_386_1.var_.characterEffect1081ui_story == nil then
				arg_386_1.var_.characterEffect1081ui_story = arg_386_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.0166666666666667

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1081ui_story"]) then
				if arg_386_1.var_.characterEffect1081ui_story and not isNil(arg_386_1.actors_["1081ui_story"]) then
					arg_386_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1081ui_story"]) and arg_386_1.var_.characterEffect1081ui_story then
				arg_386_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 0.2

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(1108102094).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 8 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 8)

				if (8 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 8)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108102095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108102095
		arg_390_1.duration_ = 2

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108102096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1081ui_story = arg_390_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).z)
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles = arg_390_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_390_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1081ui_story"].transform.position).z)
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1081ui_story"].transform.localEulerAngles = arg_390_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["1081ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect1081ui_story == nil then
				arg_390_1.var_.characterEffect1081ui_story = var_393_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.0166666666666667

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 and not isNil(var_393_1) then
				if arg_390_1.var_.characterEffect1081ui_story and not isNil(var_393_1) then
					arg_390_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect1081ui_story then
				arg_390_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_393_4 = 0
			local var_393_5 = 0.1

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_6 = arg_390_1:GetWordFromCfg(1108102095)
				local var_393_7 = arg_390_1:FormatText(var_393_6.content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 4 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 4)

				if (4 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 4)) > 0 and var_393_5 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102095", "story_v_side_new_1108102.awb") ~= 0 then
					local var_393_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102095", "story_v_side_new_1108102.awb") / 1000

					if var_393_10 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_4
					end

					if var_393_6.prefab_name ~= "" and arg_390_1.actors_[var_393_6.prefab_name] ~= nil then
						local var_393_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_6.prefab_name].transform, "story_v_side_new_1108102", "1108102095", "story_v_side_new_1108102.awb")

						arg_390_1:RecordAudio("1108102095", var_393_11)
						arg_390_1:RecordAudio("1108102095", var_393_11)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102095", "story_v_side_new_1108102.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102095", "story_v_side_new_1108102.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_12 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_12 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_12

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_12 and arg_390_1.time_ < var_393_4 + var_393_12 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108102096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108102096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108102097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1081ui_story"]) and arg_394_1.var_.characterEffect1081ui_story == nil then
				arg_394_1.var_.characterEffect1081ui_story = arg_394_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.0166666666666667

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1081ui_story"]) then
				if arg_394_1.var_.characterEffect1081ui_story and not isNil(arg_394_1.actors_["1081ui_story"]) then
					arg_394_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1081ui_story"]) and arg_394_1.var_.characterEffect1081ui_story then
				arg_394_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_397_1 = 0
			local var_397_2 = 0.175

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1108102096).content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 7 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 7)

				if (7 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 7)) > 0 and var_397_2 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_6 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_6 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_6

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_6 and arg_394_1.time_ < var_397_1 + var_397_6 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108102097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108102097
		arg_398_1.duration_ = 2.3

		local var_398_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108102098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1081ui_story = arg_398_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).z)
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles = arg_398_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_398_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1081ui_story"].transform.position).z)
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1081ui_story"].transform.localEulerAngles = arg_398_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1081ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1081ui_story == nil then
				arg_398_1.var_.characterEffect1081ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.0166666666666667

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1081ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1081ui_story then
				arg_398_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_401_4 = 0
			local var_401_5 = 0.125

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(1108102097)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 5 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 5)

				if (5 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 5)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102097", "story_v_side_new_1108102.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102097", "story_v_side_new_1108102.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_side_new_1108102", "1108102097", "story_v_side_new_1108102.awb")

						arg_398_1:RecordAudio("1108102097", var_401_11)
						arg_398_1:RecordAudio("1108102097", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102097", "story_v_side_new_1108102.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102097", "story_v_side_new_1108102.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108102098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1108102098
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1108102099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1081ui_story"]) and arg_402_1.var_.characterEffect1081ui_story == nil then
				arg_402_1.var_.characterEffect1081ui_story = arg_402_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.0166666666666667

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1081ui_story"]) then
				if arg_402_1.var_.characterEffect1081ui_story and not isNil(arg_402_1.actors_["1081ui_story"]) then
					arg_402_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1081ui_story"]) and arg_402_1.var_.characterEffect1081ui_story then
				arg_402_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.225

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
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

				local var_405_3 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(1108102098).content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 9 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 9)

				if (9 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 9)) > 0 and var_405_2 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_6 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_6 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_6

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_6 and arg_402_1.time_ < var_405_1 + var_405_6 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1108102099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1108102099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1108102100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1081ui_story = arg_406_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_409_0 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				arg_406_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_406_1.time_ - 0) / var_409_0)
				arg_406_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).z)
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles = arg_406_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				arg_406_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_406_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1081ui_story"].transform.position).z)
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1081ui_story"].transform.localEulerAngles = arg_406_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_409_1 = 0
			local var_409_2 = 0.525

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_3 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(1108102099).content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 21 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 21)

				if (21 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 21)) > 0 and var_409_2 < var_409_5 then
					arg_406_1.talkMaxDuration = var_409_5

					if var_409_5 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_6 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_6 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_6

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_6 and arg_406_1.time_ < var_409_1 + var_409_6 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play1108102100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1108102100
		arg_410_1.duration_ = 3.77

		local var_410_0 = {
			ja = 3.766,
			ko = 2.033,
			zh = 2.033
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
				arg_410_0:Play1108102101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1081ui_story = arg_410_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).z)
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles = arg_410_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_410_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1081ui_story"].transform.position).z)
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1081ui_story"].transform.localEulerAngles = arg_410_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_413_1 = arg_410_1.actors_["1081ui_story"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1081ui_story == nil then
				arg_410_1.var_.characterEffect1081ui_story = var_413_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.0166666666666667

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_2 and not isNil(var_413_1) then
				if arg_410_1.var_.characterEffect1081ui_story and not isNil(var_413_1) then
					arg_410_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_2 and arg_410_1.time_ < 0 + var_413_2 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1081ui_story then
				arg_410_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_413_4 = 0
			local var_413_5 = 0.275

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_6 = arg_410_1:GetWordFromCfg(1108102100)
				local var_413_7 = arg_410_1:FormatText(var_413_6.content)

				arg_410_1.text_.text = var_413_7

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_9 = 11 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 11)

				if (11 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 11)) > 0 and var_413_5 < var_413_9 then
					arg_410_1.talkMaxDuration = var_413_9

					if var_413_9 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_4
					end
				end

				arg_410_1.text_.text = var_413_7
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102100", "story_v_side_new_1108102.awb") ~= 0 then
					local var_413_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102100", "story_v_side_new_1108102.awb") / 1000

					if var_413_10 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_4
					end

					if var_413_6.prefab_name ~= "" and arg_410_1.actors_[var_413_6.prefab_name] ~= nil then
						local var_413_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_6.prefab_name].transform, "story_v_side_new_1108102", "1108102100", "story_v_side_new_1108102.awb")

						arg_410_1:RecordAudio("1108102100", var_413_11)
						arg_410_1:RecordAudio("1108102100", var_413_11)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102100", "story_v_side_new_1108102.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102100", "story_v_side_new_1108102.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_12 = math.max(var_413_5, arg_410_1.talkMaxDuration)

			if var_413_4 <= arg_410_1.time_ and arg_410_1.time_ < var_413_4 + var_413_12 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_4) / var_413_12

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_4 + var_413_12 and arg_410_1.time_ < var_413_4 + var_413_12 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play1108102101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1108102101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1108102102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1081ui_story"]) and arg_414_1.var_.characterEffect1081ui_story == nil then
				arg_414_1.var_.characterEffect1081ui_story = arg_414_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.0166666666666667

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1081ui_story"]) then
				if arg_414_1.var_.characterEffect1081ui_story and not isNil(arg_414_1.actors_["1081ui_story"]) then
					arg_414_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_0)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1081ui_story"]) and arg_414_1.var_.characterEffect1081ui_story then
				arg_414_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_417_1 = 0
			local var_417_2 = 0.65

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_3 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(1108102101).content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 26 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_3) / 26)

				if (26 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_3) / 26)) > 0 and var_417_2 < var_417_5 then
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
	Play1108102102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1108102102
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1108102103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.575

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1108102102).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 23 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 23)

				if (23 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 23)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1108102103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1108102103
		arg_422_1.duration_ = 7.53

		local var_422_0 = {
			ja = 7.433,
			ko = 7.533,
			zh = 7.533
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
				arg_422_0:Play1108102104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1081ui_story = arg_422_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_425_0 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 then
				arg_422_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_422_1.time_ - 0) / var_425_0)
				arg_422_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).z)
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles = arg_422_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 then
				arg_422_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_422_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1081ui_story"].transform.position).z)
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1081ui_story"].transform.localEulerAngles = arg_422_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_425_1 = arg_422_1.actors_["1081ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_1) and arg_422_1.var_.characterEffect1081ui_story == nil then
				arg_422_1.var_.characterEffect1081ui_story = var_425_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.0166666666666667

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_2 and not isNil(var_425_1) then
				if arg_422_1.var_.characterEffect1081ui_story and not isNil(var_425_1) then
					arg_422_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_2 and arg_422_1.time_ < 0 + var_425_2 + arg_425_0 and not isNil(var_425_1) and arg_422_1.var_.characterEffect1081ui_story then
				arg_422_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_2")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_425_4 = 0
			local var_425_5 = 0.975

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_6 = arg_422_1:GetWordFromCfg(1108102103)
				local var_425_7 = arg_422_1:FormatText(var_425_6.content)

				arg_422_1.text_.text = var_425_7

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_9 = 39 <= 0 and var_425_5 or var_425_5 * (utf8.len(var_425_7) / 39)

				if (39 <= 0 and var_425_5 or var_425_5 * (utf8.len(var_425_7) / 39)) > 0 and var_425_5 < var_425_9 then
					arg_422_1.talkMaxDuration = var_425_9

					if var_425_9 + var_425_4 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_9 + var_425_4
					end
				end

				arg_422_1.text_.text = var_425_7
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102103", "story_v_side_new_1108102.awb") ~= 0 then
					local var_425_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102103", "story_v_side_new_1108102.awb") / 1000

					if var_425_10 + var_425_4 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_10 + var_425_4
					end

					if var_425_6.prefab_name ~= "" and arg_422_1.actors_[var_425_6.prefab_name] ~= nil then
						local var_425_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_6.prefab_name].transform, "story_v_side_new_1108102", "1108102103", "story_v_side_new_1108102.awb")

						arg_422_1:RecordAudio("1108102103", var_425_11)
						arg_422_1:RecordAudio("1108102103", var_425_11)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102103", "story_v_side_new_1108102.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102103", "story_v_side_new_1108102.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_12 = math.max(var_425_5, arg_422_1.talkMaxDuration)

			if var_425_4 <= arg_422_1.time_ and arg_422_1.time_ < var_425_4 + var_425_12 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_4) / var_425_12

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_4 + var_425_12 and arg_422_1.time_ < var_425_4 + var_425_12 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play1108102104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1108102104
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1108102105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1081ui_story"]) and arg_426_1.var_.characterEffect1081ui_story == nil then
				arg_426_1.var_.characterEffect1081ui_story = arg_426_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.0166666666666667

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1081ui_story"]) then
				if arg_426_1.var_.characterEffect1081ui_story and not isNil(arg_426_1.actors_["1081ui_story"]) then
					arg_426_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_0)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1081ui_story"]) and arg_426_1.var_.characterEffect1081ui_story then
				arg_426_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_429_1 = 0
			local var_429_2 = 0.4

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1108102104).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 16 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 16)

				if (16 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 16)) > 0 and var_429_2 < var_429_5 then
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

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1108102105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1108102105
		arg_430_1.duration_ = 10.87

		local var_430_0 = {
			ja = 10.866,
			ko = 4.5,
			zh = 4.5
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
				arg_430_0:Play1108102106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1081ui_story = arg_430_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).z)
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles = arg_430_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_430_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1081ui_story"].transform.position).z)
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1081ui_story"].transform.localEulerAngles = arg_430_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1081ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1081ui_story == nil then
				arg_430_1.var_.characterEffect1081ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.034000001847744

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect1081ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1081ui_story then
				arg_430_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_433_4 = 0
			local var_433_5 = 0.5

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(1108102105)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102105", "story_v_side_new_1108102.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102105", "story_v_side_new_1108102.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_side_new_1108102", "1108102105", "story_v_side_new_1108102.awb")

						arg_430_1:RecordAudio("1108102105", var_433_11)
						arg_430_1:RecordAudio("1108102105", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102105", "story_v_side_new_1108102.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102105", "story_v_side_new_1108102.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1108102106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1108102106
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1108102107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1081ui_story"]) and arg_434_1.var_.characterEffect1081ui_story == nil then
				arg_434_1.var_.characterEffect1081ui_story = arg_434_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.0166666666666667

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1081ui_story"]) then
				if arg_434_1.var_.characterEffect1081ui_story and not isNil(arg_434_1.actors_["1081ui_story"]) then
					arg_434_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1081ui_story"]) and arg_434_1.var_.characterEffect1081ui_story then
				arg_434_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_437_1 = 0
			local var_437_2 = 1

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(1108102106).content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 40 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 40)

				if (40 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 40)) > 0 and var_437_2 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_6 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_6 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_6

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_6 and arg_434_1.time_ < var_437_1 + var_437_6 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1108102107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1108102107
		arg_438_1.duration_ = 5.1

		local var_438_0 = {
			ja = 5.1,
			ko = 3.466,
			zh = 3.466
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1108102108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1081ui_story = arg_438_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_441_0 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				arg_438_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).z)
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles = arg_438_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				arg_438_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_438_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1081ui_story"].transform.position).z)
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1081ui_story"].transform.localEulerAngles = arg_438_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_441_1 = arg_438_1.actors_["1081ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1081ui_story == nil then
				arg_438_1.var_.characterEffect1081ui_story = var_441_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.0166666666666667

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_2 and not isNil(var_441_1) then
				if arg_438_1.var_.characterEffect1081ui_story and not isNil(var_441_1) then
					arg_438_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_2 and arg_438_1.time_ < 0 + var_441_2 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1081ui_story then
				arg_438_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_441_4 = 0
			local var_441_5 = 0.35

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(1108102107)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 14 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 14)

				if (14 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 14)) > 0 and var_441_5 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102107", "story_v_side_new_1108102.awb") ~= 0 then
					local var_441_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102107", "story_v_side_new_1108102.awb") / 1000

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end

					if var_441_6.prefab_name ~= "" and arg_438_1.actors_[var_441_6.prefab_name] ~= nil then
						local var_441_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_6.prefab_name].transform, "story_v_side_new_1108102", "1108102107", "story_v_side_new_1108102.awb")

						arg_438_1:RecordAudio("1108102107", var_441_11)
						arg_438_1:RecordAudio("1108102107", var_441_11)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102107", "story_v_side_new_1108102.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102107", "story_v_side_new_1108102.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_12 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_12 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_12

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_12 and arg_438_1.time_ < var_441_4 + var_441_12 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play1108102108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1108102108
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1108102109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1081ui_story"]) and arg_442_1.var_.characterEffect1081ui_story == nil then
				arg_442_1.var_.characterEffect1081ui_story = arg_442_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_0 = 0.0166666666666667

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1081ui_story"]) then
				if arg_442_1.var_.characterEffect1081ui_story and not isNil(arg_442_1.actors_["1081ui_story"]) then
					arg_442_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 0) / var_445_0)
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1081ui_story"]) and arg_442_1.var_.characterEffect1081ui_story then
				arg_442_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_445_1 = 0
			local var_445_2 = 0.325

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(1108102108).content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 13 <= 0 and var_445_2 or var_445_2 * (utf8.len(var_445_3) / 13)

				if (13 <= 0 and var_445_2 or var_445_2 * (utf8.len(var_445_3) / 13)) > 0 and var_445_2 < var_445_5 then
					arg_442_1.talkMaxDuration = var_445_5

					if var_445_5 + var_445_1 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + var_445_1
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_6 = math.max(var_445_2, arg_442_1.talkMaxDuration)

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_6 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_1) / var_445_6

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_1 + var_445_6 and arg_442_1.time_ < var_445_1 + var_445_6 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1108102109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1108102109
		arg_446_1.duration_ = 8.83

		local var_446_0 = {
			ja = 8.833,
			ko = 6.466,
			zh = 6.466
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1108102110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos1081ui_story = arg_446_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_449_0 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 then
				arg_446_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_446_1.time_ - 0) / var_449_0)
				arg_446_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).z)
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles = arg_446_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 then
				arg_446_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_446_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1081ui_story"].transform.position).z)
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1081ui_story"].transform.localEulerAngles = arg_446_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_449_1 = arg_446_1.actors_["1081ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1081ui_story == nil then
				arg_446_1.var_.characterEffect1081ui_story = var_449_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.0166666666666667

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_2 and not isNil(var_449_1) then
				if arg_446_1.var_.characterEffect1081ui_story and not isNil(var_449_1) then
					arg_446_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_2 and arg_446_1.time_ < 0 + var_449_2 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1081ui_story then
				arg_446_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_449_4 = 0
			local var_449_5 = 0.775

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(1108102109)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 31 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 31)

				if (31 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 31)) > 0 and var_449_5 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102109", "story_v_side_new_1108102.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102109", "story_v_side_new_1108102.awb") / 1000

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end

					if var_449_6.prefab_name ~= "" and arg_446_1.actors_[var_449_6.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_6.prefab_name].transform, "story_v_side_new_1108102", "1108102109", "story_v_side_new_1108102.awb")

						arg_446_1:RecordAudio("1108102109", var_449_11)
						arg_446_1:RecordAudio("1108102109", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102109", "story_v_side_new_1108102.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102109", "story_v_side_new_1108102.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_12 and arg_446_1.time_ < var_449_4 + var_449_12 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play1108102110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1108102110
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1108102111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1081ui_story"]) and arg_450_1.var_.characterEffect1081ui_story == nil then
				arg_450_1.var_.characterEffect1081ui_story = arg_450_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.0166666666666667

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1081ui_story"]) then
				if arg_450_1.var_.characterEffect1081ui_story and not isNil(arg_450_1.actors_["1081ui_story"]) then
					arg_450_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1081ui_story"]) and arg_450_1.var_.characterEffect1081ui_story then
				arg_450_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.075

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1108102110).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 3 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 3)

				if (3 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 3)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1108102111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1108102111
		arg_454_1.duration_ = 3.67

		local var_454_0 = {
			ja = 3.633,
			ko = 3.666,
			zh = 3.666
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1108102112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1081ui_story = arg_454_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_457_0 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 then
				arg_454_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_454_1.time_ - 0) / var_457_0)
				arg_454_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).z)
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles = arg_454_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 then
				arg_454_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_454_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1081ui_story"].transform.position).z)
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1081ui_story"].transform.localEulerAngles = arg_454_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_457_1 = arg_454_1.actors_["1081ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect1081ui_story == nil then
				arg_454_1.var_.characterEffect1081ui_story = var_457_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.0166666666666667

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_2 and not isNil(var_457_1) then
				if arg_454_1.var_.characterEffect1081ui_story and not isNil(var_457_1) then
					arg_454_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_2 and arg_454_1.time_ < 0 + var_457_2 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect1081ui_story then
				arg_454_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_457_4 = 0
			local var_457_5 = 0.45

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_6 = arg_454_1:GetWordFromCfg(1108102111)
				local var_457_7 = arg_454_1:FormatText(var_457_6.content)

				arg_454_1.text_.text = var_457_7

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_9 = 18 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 18)

				if (18 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 18)) > 0 and var_457_5 < var_457_9 then
					arg_454_1.talkMaxDuration = var_457_9

					if var_457_9 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_9 + var_457_4
					end
				end

				arg_454_1.text_.text = var_457_7
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102111", "story_v_side_new_1108102.awb") ~= 0 then
					local var_457_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102111", "story_v_side_new_1108102.awb") / 1000

					if var_457_10 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_10 + var_457_4
					end

					if var_457_6.prefab_name ~= "" and arg_454_1.actors_[var_457_6.prefab_name] ~= nil then
						local var_457_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_6.prefab_name].transform, "story_v_side_new_1108102", "1108102111", "story_v_side_new_1108102.awb")

						arg_454_1:RecordAudio("1108102111", var_457_11)
						arg_454_1:RecordAudio("1108102111", var_457_11)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102111", "story_v_side_new_1108102.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102111", "story_v_side_new_1108102.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_12 = math.max(var_457_5, arg_454_1.talkMaxDuration)

			if var_457_4 <= arg_454_1.time_ and arg_454_1.time_ < var_457_4 + var_457_12 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_4) / var_457_12

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_4 + var_457_12 and arg_454_1.time_ < var_457_4 + var_457_12 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play1108102112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1108102112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1108102113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1081ui_story"]) and arg_458_1.var_.characterEffect1081ui_story == nil then
				arg_458_1.var_.characterEffect1081ui_story = arg_458_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.0166666666666667

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1081ui_story"]) then
				if arg_458_1.var_.characterEffect1081ui_story and not isNil(arg_458_1.actors_["1081ui_story"]) then
					arg_458_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1081ui_story"]) and arg_458_1.var_.characterEffect1081ui_story then
				arg_458_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.1

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(1108102112).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 4 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 4)

				if (4 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 4)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1108102113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1108102113
		arg_462_1.duration_ = 4.53

		local var_462_0 = {
			ja = 3,
			ko = 4.533,
			zh = 4.533
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1108102114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos1081ui_story = arg_462_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_465_0 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 then
				arg_462_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_462_1.time_ - 0) / var_465_0)
				arg_462_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).z)
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles = arg_462_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 then
				arg_462_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_462_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1081ui_story"].transform.position).z)
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["1081ui_story"].transform.localEulerAngles = arg_462_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_465_1 = arg_462_1.actors_["1081ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_1) and arg_462_1.var_.characterEffect1081ui_story == nil then
				arg_462_1.var_.characterEffect1081ui_story = var_465_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.0166666666666667

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_2 and not isNil(var_465_1) then
				if arg_462_1.var_.characterEffect1081ui_story and not isNil(var_465_1) then
					arg_462_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_2 and arg_462_1.time_ < 0 + var_465_2 + arg_465_0 and not isNil(var_465_1) and arg_462_1.var_.characterEffect1081ui_story then
				arg_462_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_465_4 = 0
			local var_465_5 = 0.45

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_6 = arg_462_1:GetWordFromCfg(1108102113)
				local var_465_7 = arg_462_1:FormatText(var_465_6.content)

				arg_462_1.text_.text = var_465_7

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 18 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 18)

				if (18 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 18)) > 0 and var_465_5 < var_465_9 then
					arg_462_1.talkMaxDuration = var_465_9

					if var_465_9 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_7
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102113", "story_v_side_new_1108102.awb") ~= 0 then
					local var_465_10 = manager.audio:GetVoiceLength("story_v_side_new_1108102", "1108102113", "story_v_side_new_1108102.awb") / 1000

					if var_465_10 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_4
					end

					if var_465_6.prefab_name ~= "" and arg_462_1.actors_[var_465_6.prefab_name] ~= nil then
						local var_465_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_6.prefab_name].transform, "story_v_side_new_1108102", "1108102113", "story_v_side_new_1108102.awb")

						arg_462_1:RecordAudio("1108102113", var_465_11)
						arg_462_1:RecordAudio("1108102113", var_465_11)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_new_1108102", "1108102113", "story_v_side_new_1108102.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_new_1108102", "1108102113", "story_v_side_new_1108102.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_12 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_12 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_12

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_12 and arg_462_1.time_ < var_465_4 + var_465_12 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play1108102114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1108102114
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1108102115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos1081ui_story = arg_466_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_469_0 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 then
				arg_466_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_466_1.time_ - 0) / var_469_0)
				arg_466_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).z)
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles = arg_466_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 then
				arg_466_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_466_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1081ui_story"].transform.position).z)
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1081ui_story"].transform.localEulerAngles = arg_466_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_469_1 = arg_466_1.actors_["1081ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1081ui_story == nil then
				arg_466_1.var_.characterEffect1081ui_story = var_469_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.0166666666666667

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_2 and not isNil(var_469_1) then
				if arg_466_1.var_.characterEffect1081ui_story and not isNil(var_469_1) then
					arg_466_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_2)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_2 and arg_466_1.time_ < 0 + var_469_2 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1081ui_story then
				arg_466_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_469_3 = 0
			local var_469_4 = 1.125

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_3 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_5 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(1108102114).content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 45 <= 0 and var_469_4 or var_469_4 * (utf8.len(var_469_5) / 45)

				if (45 <= 0 and var_469_4 or var_469_4 * (utf8.len(var_469_5) / 45)) > 0 and var_469_4 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_3 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_3
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_8 = math.max(var_469_4, arg_466_1.talkMaxDuration)

			if var_469_3 <= arg_466_1.time_ and arg_466_1.time_ < var_469_3 + var_469_8 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_3) / var_469_8

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_3 + var_469_8 and arg_466_1.time_ < var_469_3 + var_469_8 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play1108102115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1108102115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
			arg_470_1.auto_ = false
		end

		function arg_470_1.playNext_(arg_472_0)
			arg_470_1.onStoryFinished_()
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 1.05

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(1108102115).content)

				arg_470_1.text_.text = var_473_1

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_3 = 42 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 42)

				if (42 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 42)) > 0 and var_473_0 < var_473_3 then
					arg_470_1.talkMaxDuration = var_473_3

					if var_473_3 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_3 + 0
					end
				end

				arg_470_1.text_.text = var_473_1
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_4 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_4 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_4

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_4 and arg_470_1.time_ < 0 + var_473_4 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/SA0201",
		"TextureConfig/Background/ST14",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/ST15"
	},
	voices = {
		"story_v_side_new_1108102.awb",
		"story_v_out_1108102.awb"
	}
}
