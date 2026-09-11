return {
	Play319781001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319781001
		arg_1_1.duration_ = 15.87

		local var_1_0 = {
			zh = 11.933,
			ja = 15.866
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
				arg_1_0:Play319781002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST74 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_4_0.name = "ST74"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST74 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST74

				arg_1_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST74" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1095ui_story"

			if arg_1_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1095ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1095ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_1_1.time_ - 2) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.98, -6.1)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1095ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1095ui_story == nil then
				arg_1_1.var_.characterEffect1095ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1095ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1095ui_story then
				arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

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

			local var_4_24 = 2.1
			local var_4_25 = 1.075

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(319781001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 43 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 43)

				if (43 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 43)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781001", "story_v_out_319781.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_319781", "319781001", "story_v_out_319781.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_319781", "319781001", "story_v_out_319781.awb")

						arg_1_1:RecordAudio("319781001", var_4_32)
						arg_1_1:RecordAudio("319781001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319781", "319781001", "story_v_out_319781.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319781", "319781001", "story_v_out_319781.awb")
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
				actorName = "1095ui_story",
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
	Play319781002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319781002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319781003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1095ui_story"]) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = arg_9_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1095ui_story"]) then
				if arg_9_1.var_.characterEffect1095ui_story and not isNil(arg_9_1.actors_["1095ui_story"]) then
					arg_9_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1095ui_story"]) and arg_9_1.var_.characterEffect1095ui_story then
				arg_9_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319781002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 58 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 58)

				if (58 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 58)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319781003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319781003
		arg_13_1.duration_ = 5.57

		local var_13_0 = {
			zh = 5,
			ja = 5.566
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
				arg_13_0:Play319781004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = arg_13_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) then
				if arg_13_1.var_.characterEffect1095ui_story and not isNil(arg_13_1.actors_["1095ui_story"]) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_16_2 = 0
			local var_16_3 = 0.55

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
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

				local var_16_4 = arg_13_1:GetWordFromCfg(319781003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 22 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 22)

				if (22 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 22)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781003", "story_v_out_319781.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_319781", "319781003", "story_v_out_319781.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_319781", "319781003", "story_v_out_319781.awb")

						arg_13_1:RecordAudio("319781003", var_16_9)
						arg_13_1:RecordAudio("319781003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319781", "319781003", "story_v_out_319781.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319781", "319781003", "story_v_out_319781.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319781004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319781004
		arg_17_1.duration_ = 5.57

		local var_17_0 = {
			zh = 2.9,
			ja = 5.566
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
				arg_17_0:Play319781005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = arg_17_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(arg_17_1.actors_["1095ui_story"]) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(319781004)
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

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781004", "story_v_out_319781.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319781", "319781004", "story_v_out_319781.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_319781", "319781004", "story_v_out_319781.awb")

						arg_17_1:RecordAudio("319781004", var_20_9)
						arg_17_1:RecordAudio("319781004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319781", "319781004", "story_v_out_319781.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319781", "319781004", "story_v_out_319781.awb")
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
	Play319781005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319781005
		arg_21_1.duration_ = 4.97

		local var_21_0 = {
			zh = 4.766,
			ja = 4.966
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
				arg_21_0:Play319781006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1084ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1084ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1084ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1084ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1084ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1084ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_24_8 = arg_21_1.actors_["1095ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1095ui_story = var_24_8.localPosition
			end

			local var_24_9 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_9)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			local var_24_10 = arg_21_1.actors_["1095ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 and not isNil(var_24_10) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_10) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_11)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_24_12 = 0
			local var_24_13 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(319781005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 25 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 25)

				if (25 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 25)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781005", "story_v_out_319781.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_319781", "319781005", "story_v_out_319781.awb") / 1000

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_319781", "319781005", "story_v_out_319781.awb")

						arg_21_1:RecordAudio("319781005", var_24_19)
						arg_21_1:RecordAudio("319781005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319781", "319781005", "story_v_out_319781.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319781", "319781005", "story_v_out_319781.awb")
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
	Play319781006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319781006
		arg_25_1.duration_ = 7.37

		local var_25_0 = {
			zh = 5.433,
			ja = 7.366
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
				arg_25_0:Play319781007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "4040ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["4040ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["4040ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["4040ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["4040ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos4040ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["4040ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect4040ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect4040ui_story then
				arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_28_8 = arg_25_1.actors_["1084ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = var_28_8.localPosition
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_9)
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

			local var_28_10 = arg_25_1.actors_["1084ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_10) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_11)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_28_12 = arg_25_1.actors_["1095ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1095ui_story = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_13)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_13 and arg_25_1.time_ < 0 + var_28_13 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, 100, 0)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			local var_28_14 = arg_25_1.actors_["1095ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_15 and not isNil(var_28_14) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_15)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_15 and arg_25_1.time_ < 0 + var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_28_16 = 0
			local var_28_17 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(319781006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 26 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 26)

				if (26 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 26)) > 0 and var_28_17 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781006", "story_v_out_319781.awb") ~= 0 then
					local var_28_22 = manager.audio:GetVoiceLength("story_v_out_319781", "319781006", "story_v_out_319781.awb") / 1000

					if var_28_22 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_16
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_319781", "319781006", "story_v_out_319781.awb")

						arg_25_1:RecordAudio("319781006", var_28_23)
						arg_25_1:RecordAudio("319781006", var_28_23)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319781", "319781006", "story_v_out_319781.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319781", "319781006", "story_v_out_319781.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_24 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_24 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_24

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_24 and arg_25_1.time_ < var_28_16 + var_28_24 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
			},
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319781007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319781007
		arg_29_1.duration_ = 5.63

		local var_29_0 = {
			zh = 3.3,
			ja = 5.633
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
				arg_29_0:Play319781008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = arg_29_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1095ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["4040ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_29_1.time_ - 0) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = arg_29_1.actors_["4040ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_29_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_29_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_32_8 = 0
			local var_32_9 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
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

				local var_32_10 = arg_29_1:GetWordFromCfg(319781007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)

				if (11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781007", "story_v_out_319781.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_319781", "319781007", "story_v_out_319781.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_319781", "319781007", "story_v_out_319781.awb")

						arg_29_1:RecordAudio("319781007", var_32_15)
						arg_29_1:RecordAudio("319781007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319781", "319781007", "story_v_out_319781.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319781", "319781007", "story_v_out_319781.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319781008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319781008
		arg_33_1.duration_ = 3.8

		local var_33_0 = {
			zh = 3.8,
			ja = 3.266
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
				arg_33_0:Play319781009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = arg_33_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(arg_33_1.actors_["1095ui_story"]) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_36_1 = arg_33_1.actors_["4040ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect4040ui_story then
				arg_33_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.425

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(319781008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 17 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 17)

				if (17 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 17)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781008", "story_v_out_319781.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781008", "story_v_out_319781.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_319781", "319781008", "story_v_out_319781.awb")

						arg_33_1:RecordAudio("319781008", var_36_11)
						arg_33_1:RecordAudio("319781008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319781", "319781008", "story_v_out_319781.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319781", "319781008", "story_v_out_319781.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319781009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319781009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319781010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = arg_37_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(arg_37_1.actors_["4040ui_story"]) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_37_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_37_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_40_1 = arg_37_1.actors_["4040ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = var_40_1.localPosition
			end

			local var_40_2 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 then
				var_40_1.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_2)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 then
				var_40_1.localPosition = Vector3.New(0, 100, 0)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			local var_40_3 = arg_37_1.actors_["1095ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, 100, 0)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = 0
			local var_40_6 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(319781009).content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 24 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_7) / 24)

				if (24 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_7) / 24)) > 0 and var_40_6 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_10 and arg_37_1.time_ < var_40_5 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_37_1:InitPlayNodeList()
	end,
	Play319781010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319781010
		arg_41_1.duration_ = 2.97

		local var_41_0 = {
			zh = 2.5,
			ja = 2.966
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
				arg_41_0:Play319781011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = arg_41_1.actors_["1084ui_story"].transform.localPosition

				arg_41_1:ShowWeapon(arg_41_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1084ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["1095ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_44_6 = arg_41_1.actors_["4040ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = var_44_6.localPosition
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_6.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_7)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_6.localPosition = Vector3.New(0, 100, 0)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			local var_44_8 = arg_41_1.actors_["4040ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_9 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_8) then
					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_9)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.characterEffect4040ui_story then
				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_44_10 = 0
			local var_44_11 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_12 = arg_41_1:GetWordFromCfg(319781010)
				local var_44_13 = arg_41_1:FormatText(var_44_12.content)

				arg_41_1.text_.text = var_44_13

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 13 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_13) / 13)

				if (13 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_13) / 13)) > 0 and var_44_11 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_13
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781010", "story_v_out_319781.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_319781", "319781010", "story_v_out_319781.awb") / 1000

					if var_44_16 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_10
					end

					if var_44_12.prefab_name ~= "" and arg_41_1.actors_[var_44_12.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_12.prefab_name].transform, "story_v_out_319781", "319781010", "story_v_out_319781.awb")

						arg_41_1:RecordAudio("319781010", var_44_17)
						arg_41_1:RecordAudio("319781010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319781", "319781010", "story_v_out_319781.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319781", "319781010", "story_v_out_319781.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_18 and arg_41_1.time_ < var_44_10 + var_44_18 + arg_44_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319781011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319781011
		arg_45_1.duration_ = 4.77

		local var_45_0 = {
			zh = 4.766,
			ja = 4.133
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
				arg_45_0:Play319781012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = arg_45_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).z)
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles = arg_45_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_45_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["4040ui_story"].transform.position).z)
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["4040ui_story"].transform.localEulerAngles = arg_45_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["4040ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["1084ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1084ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = arg_45_1.actors_["1084ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_48_8 = arg_45_1.actors_["1095ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1095ui_story = var_48_8.localPosition
			end

			local var_48_9 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_9)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(0, 100, 0)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			local var_48_10 = 0
			local var_48_11 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:GetWordFromCfg(319781011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 19 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 19)

				if (19 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 19)) > 0 and var_48_11 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781011", "story_v_out_319781.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_319781", "319781011", "story_v_out_319781.awb") / 1000

					if var_48_16 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_10
					end

					if var_48_12.prefab_name ~= "" and arg_45_1.actors_[var_48_12.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_12.prefab_name].transform, "story_v_out_319781", "319781011", "story_v_out_319781.awb")

						arg_45_1:RecordAudio("319781011", var_48_17)
						arg_45_1:RecordAudio("319781011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319781", "319781011", "story_v_out_319781.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319781", "319781011", "story_v_out_319781.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_18 and arg_45_1.time_ < var_48_10 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
			},
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

		arg_45_1:InitPlayNodeList()
	end,
	Play319781012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319781012
		arg_49_1.duration_ = 6.13

		local var_49_0 = {
			zh = 1.8,
			ja = 6.133
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
				arg_49_0:Play319781013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = arg_49_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) then
				if arg_49_1.var_.characterEffect4040ui_story and not isNil(arg_49_1.actors_["4040ui_story"]) then
					arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_49_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) and arg_49_1.var_.characterEffect4040ui_story then
				arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_49_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_52_1 = arg_49_1.actors_["1084ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(319781012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 7 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 7)

				if (7 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 7)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781012", "story_v_out_319781.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781012", "story_v_out_319781.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_319781", "319781012", "story_v_out_319781.awb")

						arg_49_1:RecordAudio("319781012", var_52_11)
						arg_49_1:RecordAudio("319781012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319781", "319781012", "story_v_out_319781.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319781", "319781012", "story_v_out_319781.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319781013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319781013
		arg_53_1.duration_ = 3.4

		local var_53_0 = {
			zh = 3.1,
			ja = 3.4
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
				arg_53_0:Play319781014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1095ui_story = arg_53_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).z)
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles = arg_53_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_53_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).z)
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles = arg_53_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1095ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_56_4 = arg_53_1.actors_["4040ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos4040ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_5)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0, 100, 0)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			local var_56_6 = arg_53_1.actors_["4040ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story then
				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_56_8 = arg_53_1.actors_["1084ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1084ui_story = var_56_8.localPosition
			end

			local var_56_9 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 then
				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_9)
				var_56_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_8.position).x, (manager.ui.mainCamera.transform.position - var_56_8.position).y, (manager.ui.mainCamera.transform.position - var_56_8.position).z)
				var_56_8.localEulerAngles.z = 0
				var_56_8.localEulerAngles.x = 0
				var_56_8.localEulerAngles = var_56_8.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(0, 100, 0)
				var_56_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_8.position).x, (manager.ui.mainCamera.transform.position - var_56_8.position).y, (manager.ui.mainCamera.transform.position - var_56_8.position).z)
				var_56_8.localEulerAngles.z = 0
				var_56_8.localEulerAngles.x = 0
				var_56_8.localEulerAngles = var_56_8.localEulerAngles
			end

			local var_56_10 = arg_53_1.actors_["1084ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = var_56_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_11 and not isNil(var_56_10) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(var_56_10) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_11)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_11 and arg_53_1.time_ < 0 + var_56_11 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_56_12 = 0
			local var_56_13 = 0.425

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(319781013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 17 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 17)

				if (17 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 17)) > 0 and var_56_13 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781013", "story_v_out_319781.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_319781", "319781013", "story_v_out_319781.awb") / 1000

					if var_56_18 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_12
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_319781", "319781013", "story_v_out_319781.awb")

						arg_53_1:RecordAudio("319781013", var_56_19)
						arg_53_1:RecordAudio("319781013", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319781", "319781013", "story_v_out_319781.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319781", "319781013", "story_v_out_319781.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_20 and arg_53_1.time_ < var_56_12 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_53_1:InitPlayNodeList()
	end,
	Play319781014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319781014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play319781015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = arg_57_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) then
				if arg_57_1.var_.characterEffect1095ui_story and not isNil(arg_57_1.actors_["1095ui_story"]) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.525

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

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(319781014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 21 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 21)

				if (21 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 21)) > 0 and var_60_2 < var_60_5 then
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
	Play319781015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319781015
		arg_61_1.duration_ = 8.23

		local var_61_0 = {
			zh = 7.6,
			ja = 8.233
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
				arg_61_0:Play319781016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = arg_61_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(arg_61_1.actors_["1095ui_story"]) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_2 = 0
			local var_64_3 = 0.85

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(319781015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 34 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 34)

				if (34 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 34)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781015", "story_v_out_319781.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_319781", "319781015", "story_v_out_319781.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_319781", "319781015", "story_v_out_319781.awb")

						arg_61_1:RecordAudio("319781015", var_64_9)
						arg_61_1:RecordAudio("319781015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319781", "319781015", "story_v_out_319781.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319781", "319781015", "story_v_out_319781.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319781016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319781016
		arg_65_1.duration_ = 3.17

		local var_65_0 = {
			zh = 2.566,
			ja = 3.166
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
				arg_65_0:Play319781017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos4040ui_story = arg_65_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).z)
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles = arg_65_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_65_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).z)
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles = arg_65_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["4040ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4040ui_story == nil then
				arg_65_1.var_.characterEffect4040ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect4040ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4040ui_story then
				arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1095ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1095ui_story = var_68_4.localPosition
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_65_1.time_ - 0) / var_68_5)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			local var_68_6 = arg_65_1.actors_["1095ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_8 = 0
			local var_68_9 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(319781016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 12 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 12)

				if (12 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 12)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781016", "story_v_out_319781.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_319781", "319781016", "story_v_out_319781.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_319781", "319781016", "story_v_out_319781.awb")

						arg_65_1:RecordAudio("319781016", var_68_15)
						arg_65_1:RecordAudio("319781016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319781", "319781016", "story_v_out_319781.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319781", "319781016", "story_v_out_319781.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_65_1:InitPlayNodeList()
	end,
	Play319781017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319781017
		arg_69_1.duration_ = 2.3

		local var_69_0 = {
			zh = 2.133,
			ja = 2.3
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
				arg_69_0:Play319781018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) and arg_69_1.var_.characterEffect4040ui_story == nil then
				arg_69_1.var_.characterEffect4040ui_story = arg_69_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.233333333333333

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) then
				if arg_69_1.var_.characterEffect4040ui_story and not isNil(arg_69_1.actors_["4040ui_story"]) then
					arg_69_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_69_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) and arg_69_1.var_.characterEffect4040ui_story then
				arg_69_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_69_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["1095ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1095ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_72_4 = 0
			local var_72_5 = 0.175

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(319781017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 7 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 7)

				if (7 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 7)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781017", "story_v_out_319781.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781017", "story_v_out_319781.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_319781", "319781017", "story_v_out_319781.awb")

						arg_69_1:RecordAudio("319781017", var_72_11)
						arg_69_1:RecordAudio("319781017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319781", "319781017", "story_v_out_319781.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319781", "319781017", "story_v_out_319781.awb")
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

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319781018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319781018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319781019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story == nil then
				arg_73_1.var_.characterEffect1095ui_story = arg_73_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) then
				if arg_73_1.var_.characterEffect1095ui_story and not isNil(arg_73_1.actors_["1095ui_story"]) then
					arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story then
				arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_76_1 = arg_73_1.actors_["4040ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos4040ui_story = var_76_1.localPosition
			end

			local var_76_2 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 then
				var_76_1.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_2)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				var_76_1.localPosition = Vector3.New(0, 100, 0)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			local var_76_3 = 0
			local var_76_4 = 0.75

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(319781018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 30 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 30)

				if (30 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 30)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319781019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319781019
		arg_77_1.duration_ = 7.93

		local var_77_0 = {
			zh = 6.3,
			ja = 7.933
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
				arg_77_0:Play319781020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1084ui_story = arg_77_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).z)
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles = arg_77_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_77_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1084ui_story"].transform.position).z)
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1084ui_story"].transform.localEulerAngles = arg_77_1.actors_["1084ui_story"].transform.localEulerAngles
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

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["4040ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos4040ui_story = var_80_4.localPosition
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_5)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, 100, 0)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			local var_80_6 = arg_77_1.actors_["1095ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1095ui_story = var_80_6.localPosition
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_6.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_77_1.time_ - 0) / var_80_7)
				var_80_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_6.position).x, (manager.ui.mainCamera.transform.position - var_80_6.position).y, (manager.ui.mainCamera.transform.position - var_80_6.position).z)
				var_80_6.localEulerAngles.z = 0
				var_80_6.localEulerAngles.x = 0
				var_80_6.localEulerAngles = var_80_6.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_6.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_80_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_6.position).x, (manager.ui.mainCamera.transform.position - var_80_6.position).y, (manager.ui.mainCamera.transform.position - var_80_6.position).z)
				var_80_6.localEulerAngles.z = 0
				var_80_6.localEulerAngles.x = 0
				var_80_6.localEulerAngles = var_80_6.localEulerAngles
			end

			local var_80_8 = 0
			local var_80_9 = 0.725

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
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

				local var_80_10 = arg_77_1:GetWordFromCfg(319781019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 29 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 29)

				if (29 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 29)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781019", "story_v_out_319781.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_319781", "319781019", "story_v_out_319781.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_319781", "319781019", "story_v_out_319781.awb")

						arg_77_1:RecordAudio("319781019", var_80_15)
						arg_77_1:RecordAudio("319781019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319781", "319781019", "story_v_out_319781.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319781", "319781019", "story_v_out_319781.awb")
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_77_1:InitPlayNodeList()
	end,
	Play319781020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319781020
		arg_81_1.duration_ = 4.27

		local var_81_0 = {
			zh = 2.2,
			ja = 4.266
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
				arg_81_0:Play319781021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = arg_81_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) then
				if arg_81_1.var_.characterEffect1095ui_story and not isNil(arg_81_1.actors_["1095ui_story"]) then
					arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) and arg_81_1.var_.characterEffect1095ui_story then
				arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = arg_81_1.actors_["1084ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(319781020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 11 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 11)

				if (11 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 11)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781020", "story_v_out_319781.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781020", "story_v_out_319781.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_319781", "319781020", "story_v_out_319781.awb")

						arg_81_1:RecordAudio("319781020", var_84_11)
						arg_81_1:RecordAudio("319781020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319781", "319781020", "story_v_out_319781.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319781", "319781020", "story_v_out_319781.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319781021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319781021
		arg_85_1.duration_ = 2.8

		local var_85_0 = {
			zh = 1.133,
			ja = 2.8
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
				arg_85_0:Play319781022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = arg_85_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(arg_85_1.actors_["1095ui_story"]) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["1084ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.075

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

				local var_88_6 = arg_85_1:GetWordFromCfg(319781021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 3 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 3)

				if (3 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 3)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781021", "story_v_out_319781.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781021", "story_v_out_319781.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_319781", "319781021", "story_v_out_319781.awb")

						arg_85_1:RecordAudio("319781021", var_88_11)
						arg_85_1:RecordAudio("319781021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319781", "319781021", "story_v_out_319781.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319781", "319781021", "story_v_out_319781.awb")
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
	Play319781022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319781022
		arg_89_1.duration_ = 7.57

		local var_89_0 = {
			zh = 7.033,
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
				arg_89_0:Play319781023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_0 = arg_89_1.actors_["1095ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_1 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 and not isNil(var_92_0) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_92_3 = arg_89_1.actors_["1084ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_4 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_3) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_3) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_4)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_5 = 0
			local var_92_6 = 0.725

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(319781022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 29 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 29)

				if (29 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 29)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781022", "story_v_out_319781.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_319781", "319781022", "story_v_out_319781.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_319781", "319781022", "story_v_out_319781.awb")

						arg_89_1:RecordAudio("319781022", var_92_12)
						arg_89_1:RecordAudio("319781022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319781", "319781022", "story_v_out_319781.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319781", "319781022", "story_v_out_319781.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319781023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319781023
		arg_93_1.duration_ = 3.27

		local var_93_0 = {
			zh = 3.266,
			ja = 2.733
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
				arg_93_0:Play319781024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "10066ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10066ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["10066ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["10066ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["10066ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10066ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["10066ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect10066ui_story == nil then
				arg_93_1.var_.characterEffect10066ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.characterEffect10066ui_story and not isNil(var_96_5) then
					arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect10066ui_story then
				arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_8 = arg_93_1.actors_["1095ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1095ui_story = var_96_8.localPosition
			end

			local var_96_9 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 then
				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_9)
				var_96_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_8.position).x, (manager.ui.mainCamera.transform.position - var_96_8.position).y, (manager.ui.mainCamera.transform.position - var_96_8.position).z)
				var_96_8.localEulerAngles.z = 0
				var_96_8.localEulerAngles.x = 0
				var_96_8.localEulerAngles = var_96_8.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, 100, 0)
				var_96_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_8.position).x, (manager.ui.mainCamera.transform.position - var_96_8.position).y, (manager.ui.mainCamera.transform.position - var_96_8.position).z)
				var_96_8.localEulerAngles.z = 0
				var_96_8.localEulerAngles.x = 0
				var_96_8.localEulerAngles = var_96_8.localEulerAngles
			end

			local var_96_10 = arg_93_1.actors_["1095ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1095ui_story == nil then
				arg_93_1.var_.characterEffect1095ui_story = var_96_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_11 and not isNil(var_96_10) then
				if arg_93_1.var_.characterEffect1095ui_story and not isNil(var_96_10) then
					arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_11)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_11 and arg_93_1.time_ < 0 + var_96_11 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1095ui_story then
				arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_96_12 = arg_93_1.actors_["1084ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = var_96_12.localPosition
			end

			local var_96_13 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_13 then
				var_96_12.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_13)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_13 and arg_93_1.time_ < 0 + var_96_13 + arg_96_0 then
				var_96_12.localPosition = Vector3.New(0, 100, 0)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			local var_96_14 = arg_93_1.actors_["1084ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_15 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_15 and not isNil(var_96_14) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_14) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_15)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_15 and arg_93_1.time_ < 0 + var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_96_16 = 0
			local var_96_17 = 0.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
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

				local var_96_18 = arg_93_1:GetWordFromCfg(319781023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 11 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 11)

				if (11 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 11)) > 0 and var_96_17 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781023", "story_v_out_319781.awb") ~= 0 then
					local var_96_22 = manager.audio:GetVoiceLength("story_v_out_319781", "319781023", "story_v_out_319781.awb") / 1000

					if var_96_22 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_16
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_319781", "319781023", "story_v_out_319781.awb")

						arg_93_1:RecordAudio("319781023", var_96_23)
						arg_93_1:RecordAudio("319781023", var_96_23)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319781", "319781023", "story_v_out_319781.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319781", "319781023", "story_v_out_319781.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_24 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_24 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_24

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_24 and arg_93_1.time_ < var_96_16 + var_96_24 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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

		arg_93_1:InitPlayNodeList()
	end,
	Play319781024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319781024
		arg_97_1.duration_ = 2.8

		local var_97_0 = {
			zh = 2.8,
			ja = 2.2
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
				arg_97_0:Play319781025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = arg_97_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1095ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story == nil then
				arg_97_1.var_.characterEffect1095ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1095ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story then
				arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_4 = arg_97_1.actors_["10066ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10066ui_story = var_100_4.localPosition
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_4.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
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

			local var_100_6 = arg_97_1.actors_["10066ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10066ui_story then
				arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_100_8 = 0
			local var_100_9 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(319781024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 14 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 14)

				if (14 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 14)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781024", "story_v_out_319781.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_319781", "319781024", "story_v_out_319781.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_319781", "319781024", "story_v_out_319781.awb")

						arg_97_1:RecordAudio("319781024", var_100_15)
						arg_97_1:RecordAudio("319781024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319781", "319781024", "story_v_out_319781.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319781", "319781024", "story_v_out_319781.awb")
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
				actorName = "1095ui_story",
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

		arg_97_1:InitPlayNodeList()
	end,
	Play319781025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319781025
		arg_101_1.duration_ = 9.2

		local var_101_0 = {
			zh = 7.166,
			ja = 9.2
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
				arg_101_0:Play319781026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(319781025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 33)

				if (33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 33)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781025", "story_v_out_319781.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_319781", "319781025", "story_v_out_319781.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_319781", "319781025", "story_v_out_319781.awb")

						arg_101_1:RecordAudio("319781025", var_104_6)
						arg_101_1:RecordAudio("319781025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319781", "319781025", "story_v_out_319781.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319781", "319781025", "story_v_out_319781.awb")
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
	Play319781026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319781026
		arg_105_1.duration_ = 4.1

		local var_105_0 = {
			zh = 2.5,
			ja = 4.1
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
				arg_105_0:Play319781027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(319781026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)

				if (14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781026", "story_v_out_319781.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_319781", "319781026", "story_v_out_319781.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_319781", "319781026", "story_v_out_319781.awb")

						arg_105_1:RecordAudio("319781026", var_108_6)
						arg_105_1:RecordAudio("319781026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319781", "319781026", "story_v_out_319781.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319781", "319781026", "story_v_out_319781.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319781027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319781027
		arg_109_1.duration_ = 2.03

		local var_109_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_109_0:Play319781028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1084ui_story = arg_109_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).z)
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles = arg_109_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_109_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1084ui_story"].transform.position).z)
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1084ui_story"].transform.localEulerAngles = arg_109_1.actors_["1084ui_story"].transform.localEulerAngles
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
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_112_4 = arg_109_1.actors_["1095ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1095ui_story = var_112_4.localPosition
			end

			local var_112_5 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 then
				var_112_4.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_109_1.time_ - 0) / var_112_5)
				var_112_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_4.position).x, (manager.ui.mainCamera.transform.position - var_112_4.position).y, (manager.ui.mainCamera.transform.position - var_112_4.position).z)
				var_112_4.localEulerAngles.z = 0
				var_112_4.localEulerAngles.x = 0
				var_112_4.localEulerAngles = var_112_4.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 then
				var_112_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_112_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_4.position).x, (manager.ui.mainCamera.transform.position - var_112_4.position).y, (manager.ui.mainCamera.transform.position - var_112_4.position).z)
				var_112_4.localEulerAngles.z = 0
				var_112_4.localEulerAngles.x = 0
				var_112_4.localEulerAngles = var_112_4.localEulerAngles
			end

			local var_112_6 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_7 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 and not isNil(var_112_6) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_7)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_112_8 = 0
			local var_112_9 = 0.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
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

				local var_112_10 = arg_109_1:GetWordFromCfg(319781027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 6 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 6)

				if (6 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 6)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781027", "story_v_out_319781.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_319781", "319781027", "story_v_out_319781.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_319781", "319781027", "story_v_out_319781.awb")

						arg_109_1:RecordAudio("319781027", var_112_15)
						arg_109_1:RecordAudio("319781027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319781", "319781027", "story_v_out_319781.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319781", "319781027", "story_v_out_319781.awb")
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
				actorName = "1095ui_story",
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
	Play319781028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319781028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319781029(arg_113_1)
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
			local var_116_2 = 1.075

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

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(319781028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 43 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 43)

				if (43 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 43)) > 0 and var_116_2 < var_116_5 then
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
	Play319781029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319781029
		arg_117_1.duration_ = 15.7

		local var_117_0 = {
			zh = 9.533,
			ja = 15.7
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
				arg_117_0:Play319781030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = arg_117_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) then
				if arg_117_1.var_.characterEffect1095ui_story and not isNil(arg_117_1.actors_["1095ui_story"]) then
					arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) and arg_117_1.var_.characterEffect1095ui_story then
				arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1084ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_120_4 = 0
			local var_120_5 = 1.025

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(319781029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 41 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 41)

				if (41 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 41)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781029", "story_v_out_319781.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781029", "story_v_out_319781.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_319781", "319781029", "story_v_out_319781.awb")

						arg_117_1:RecordAudio("319781029", var_120_11)
						arg_117_1:RecordAudio("319781029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319781", "319781029", "story_v_out_319781.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319781", "319781029", "story_v_out_319781.awb")
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
	Play319781030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319781030
		arg_121_1.duration_ = 13.93

		local var_121_0 = {
			zh = 6.766,
			ja = 13.933
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
				arg_121_0:Play319781031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.875

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(319781030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 35 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 35)

				if (35 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 35)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781030", "story_v_out_319781.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_319781", "319781030", "story_v_out_319781.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_319781", "319781030", "story_v_out_319781.awb")

						arg_121_1:RecordAudio("319781030", var_124_6)
						arg_121_1:RecordAudio("319781030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319781", "319781030", "story_v_out_319781.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319781", "319781030", "story_v_out_319781.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319781031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319781031
		arg_125_1.duration_ = 3

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_125_0:Play319781032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1095ui_story"]) and arg_125_1.var_.characterEffect1095ui_story == nil then
				arg_125_1.var_.characterEffect1095ui_story = arg_125_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1095ui_story"]) then
				if arg_125_1.var_.characterEffect1095ui_story and not isNil(arg_125_1.actors_["1095ui_story"]) then
					arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1095ui_story"]) and arg_125_1.var_.characterEffect1095ui_story then
				arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_128_1 = arg_125_1.actors_["1084ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(319781031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 6 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 6)

				if (6 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 6)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781031", "story_v_out_319781.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781031", "story_v_out_319781.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_319781", "319781031", "story_v_out_319781.awb")

						arg_125_1:RecordAudio("319781031", var_128_11)
						arg_125_1:RecordAudio("319781031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319781", "319781031", "story_v_out_319781.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319781", "319781031", "story_v_out_319781.awb")
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
	Play319781032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319781032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319781033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = arg_129_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(arg_129_1.actors_["1084ui_story"]) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.875

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(319781032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 35 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 35)

				if (35 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 35)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319781033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319781033
		arg_133_1.duration_ = 9.03

		local var_133_0 = {
			zh = 6.5,
			ja = 9.033
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
				arg_133_0:Play319781034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1095ui_story = arg_133_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).z)
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles = arg_133_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_133_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1095ui_story"].transform.position).z)
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1095ui_story"].transform.localEulerAngles = arg_133_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1095ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1095ui_story == nil then
				arg_133_1.var_.characterEffect1095ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1095ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1095ui_story then
				arg_133_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(319781033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 26 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 26)

				if (26 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 26)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781033", "story_v_out_319781.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781033", "story_v_out_319781.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_319781", "319781033", "story_v_out_319781.awb")

						arg_133_1:RecordAudio("319781033", var_136_11)
						arg_133_1:RecordAudio("319781033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319781", "319781033", "story_v_out_319781.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319781", "319781033", "story_v_out_319781.awb")
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

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play319781034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319781034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319781035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1084ui_story = arg_137_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).z)
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles = arg_137_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_137_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1084ui_story"].transform.position).z)
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1084ui_story"].transform.localEulerAngles = arg_137_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1084ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4133")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_140_4 = arg_137_1.actors_["1095ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1095ui_story == nil then
				arg_137_1.var_.characterEffect1095ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect1095ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1095ui_story then
				arg_137_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_140_6 = 0
			local var_140_7 = 0.05

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(319781034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 2 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 2)

				if (2 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 2)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781034", "story_v_out_319781.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_319781", "319781034", "story_v_out_319781.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_319781", "319781034", "story_v_out_319781.awb")

						arg_137_1:RecordAudio("319781034", var_140_13)
						arg_137_1:RecordAudio("319781034", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319781", "319781034", "story_v_out_319781.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319781", "319781034", "story_v_out_319781.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play319781035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319781035
		arg_141_1.duration_ = 17.23

		local var_141_0 = {
			zh = 11.866,
			ja = 17.233
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
				arg_141_0:Play319781036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1095ui_story = arg_141_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1095ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story then
				arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_4 = arg_141_1.actors_["1084ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_144_6 = 0
			local var_144_7 = 1.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(319781035)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 49 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 49)

				if (49 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 49)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781035", "story_v_out_319781.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_319781", "319781035", "story_v_out_319781.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_319781", "319781035", "story_v_out_319781.awb")

						arg_141_1:RecordAudio("319781035", var_144_13)
						arg_141_1:RecordAudio("319781035", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319781", "319781035", "story_v_out_319781.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319781", "319781035", "story_v_out_319781.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play319781036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319781036
		arg_145_1.duration_ = 14.53

		local var_145_0 = {
			zh = 8.7,
			ja = 14.533
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
				arg_145_0:Play319781037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(319781036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 44 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 44)

				if (44 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 44)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781036", "story_v_out_319781.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_319781", "319781036", "story_v_out_319781.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_319781", "319781036", "story_v_out_319781.awb")

						arg_145_1:RecordAudio("319781036", var_148_6)
						arg_145_1:RecordAudio("319781036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319781", "319781036", "story_v_out_319781.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319781", "319781036", "story_v_out_319781.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319781037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319781037
		arg_149_1.duration_ = 4.17

		local var_149_0 = {
			zh = 2.8,
			ja = 4.166
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
				arg_149_0:Play319781038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = arg_149_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) then
				if arg_149_1.var_.characterEffect1095ui_story and not isNil(arg_149_1.actors_["1095ui_story"]) then
					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story then
				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_152_1 = arg_149_1.actors_["1084ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_152_4 = 0
			local var_152_5 = 0.225

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(319781037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 9 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 9)

				if (9 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 9)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781037", "story_v_out_319781.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781037", "story_v_out_319781.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_319781", "319781037", "story_v_out_319781.awb")

						arg_149_1:RecordAudio("319781037", var_152_11)
						arg_149_1:RecordAudio("319781037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319781", "319781037", "story_v_out_319781.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319781", "319781037", "story_v_out_319781.awb")
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

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319781038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319781038
		arg_153_1.duration_ = 16.83

		local var_153_0 = {
			zh = 16.833,
			ja = 15.333
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
				arg_153_0:Play319781039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) and arg_153_1.var_.characterEffect1095ui_story == nil then
				arg_153_1.var_.characterEffect1095ui_story = arg_153_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) then
				if arg_153_1.var_.characterEffect1095ui_story and not isNil(arg_153_1.actors_["1095ui_story"]) then
					arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) and arg_153_1.var_.characterEffect1095ui_story then
				arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1084ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1084ui_story == nil then
				arg_153_1.var_.characterEffect1084ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1084ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1084ui_story then
				arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 1.625

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(319781038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 65 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 65)

				if (65 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 65)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781038", "story_v_out_319781.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781038", "story_v_out_319781.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_319781", "319781038", "story_v_out_319781.awb")

						arg_153_1:RecordAudio("319781038", var_156_11)
						arg_153_1:RecordAudio("319781038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319781", "319781038", "story_v_out_319781.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319781", "319781038", "story_v_out_319781.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319781039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319781039
		arg_157_1.duration_ = 10.3

		local var_157_0 = {
			zh = 8.4,
			ja = 10.3
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
				arg_157_0:Play319781040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1095ui_story = arg_157_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).z)
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles = arg_157_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_157_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1095ui_story"].transform.position).z)
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1095ui_story"].transform.localEulerAngles = arg_157_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_1 = 0
			local var_160_2 = 1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(319781039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 40 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 40)

				if (40 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 40)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781039", "story_v_out_319781.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_319781", "319781039", "story_v_out_319781.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_319781", "319781039", "story_v_out_319781.awb")

						arg_157_1:RecordAudio("319781039", var_160_8)
						arg_157_1:RecordAudio("319781039", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319781", "319781039", "story_v_out_319781.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319781", "319781039", "story_v_out_319781.awb")
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
				actorName = "1095ui_story",
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
	Play319781040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319781040
		arg_161_1.duration_ = 12.37

		local var_161_0 = {
			zh = 8.166,
			ja = 12.366
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
				arg_161_0:Play319781041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(319781040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 36)

				if (36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 36)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781040", "story_v_out_319781.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_319781", "319781040", "story_v_out_319781.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_319781", "319781040", "story_v_out_319781.awb")

						arg_161_1:RecordAudio("319781040", var_164_6)
						arg_161_1:RecordAudio("319781040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319781", "319781040", "story_v_out_319781.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319781", "319781040", "story_v_out_319781.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319781041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319781041
		arg_165_1.duration_ = 4.57

		local var_165_0 = {
			zh = 2.1,
			ja = 4.566
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
				arg_165_0:Play319781042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = arg_165_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(arg_165_1.actors_["1095ui_story"]) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1084ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(319781041)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 12 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 12)

				if (12 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 12)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781041", "story_v_out_319781.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781041", "story_v_out_319781.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_319781", "319781041", "story_v_out_319781.awb")

						arg_165_1:RecordAudio("319781041", var_168_11)
						arg_165_1:RecordAudio("319781041", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319781", "319781041", "story_v_out_319781.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319781", "319781041", "story_v_out_319781.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319781042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319781042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319781043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = arg_169_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) then
				if arg_169_1.var_.characterEffect1095ui_story and not isNil(arg_169_1.actors_["1095ui_story"]) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_172_1 = arg_169_1.actors_["1084ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1084ui_story == nil then
				arg_169_1.var_.characterEffect1084ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1084ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_2)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1084ui_story then
				arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_172_3 = arg_169_1.actors_["1095ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = var_172_3.localPosition
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_4)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(0, 100, 0)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			local var_172_5 = arg_169_1.actors_["1084ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1084ui_story = var_172_5.localPosition
			end

			local var_172_6 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 then
				var_172_5.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_6)
				var_172_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_5.position).x, (manager.ui.mainCamera.transform.position - var_172_5.position).y, (manager.ui.mainCamera.transform.position - var_172_5.position).z)
				var_172_5.localEulerAngles.z = 0
				var_172_5.localEulerAngles.x = 0
				var_172_5.localEulerAngles = var_172_5.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 then
				var_172_5.localPosition = Vector3.New(0, 100, 0)
				var_172_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_5.position).x, (manager.ui.mainCamera.transform.position - var_172_5.position).y, (manager.ui.mainCamera.transform.position - var_172_5.position).z)
				var_172_5.localEulerAngles.z = 0
				var_172_5.localEulerAngles.x = 0
				var_172_5.localEulerAngles = var_172_5.localEulerAngles
			end

			local var_172_7 = 0
			local var_172_8 = 1.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(319781042).content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 55 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 55)

				if (55 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 55)) > 0 and var_172_8 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_7 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_7
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_7) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_7 + var_172_12 and arg_169_1.time_ < var_172_7 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_169_1:InitPlayNodeList()
	end,
	Play319781043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319781043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319781044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = arg_173_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(arg_173_1.actors_["1095ui_story"]) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["1095ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1095ui_story = var_176_2.localPosition
			end

			local var_176_3 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 then
				var_176_2.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_3)
				var_176_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_2.position).x, (manager.ui.mainCamera.transform.position - var_176_2.position).y, (manager.ui.mainCamera.transform.position - var_176_2.position).z)
				var_176_2.localEulerAngles.z = 0
				var_176_2.localEulerAngles.x = 0
				var_176_2.localEulerAngles = var_176_2.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 then
				var_176_2.localPosition = Vector3.New(0, 100, 0)
				var_176_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_2.position).x, (manager.ui.mainCamera.transform.position - var_176_2.position).y, (manager.ui.mainCamera.transform.position - var_176_2.position).z)
				var_176_2.localEulerAngles.z = 0
				var_176_2.localEulerAngles.x = 0
				var_176_2.localEulerAngles = var_176_2.localEulerAngles
			end

			local var_176_4 = arg_173_1.actors_["1084ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1084ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(0, 100, 0)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				local var_176_6 = arg_173_1.fswbg_.transform:Find("textbox/adapt/content") or arg_173_1.fswbg_.transform:Find("textbox/content")
				local var_176_7 = arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_176_8 = var_176_6:GetComponent("RectTransform")

				var_176_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_176_8.offsetMin = Vector2.New(0, 0)
				var_176_8.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.fswbg_:SetActive(true)
				arg_173_1.dialog_:SetActive(false)

				arg_173_1.fswtw_.percent = 0
				arg_173_1.fswt_.text = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(319781043).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.fswt_)

				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_173_1.fswtw_:SetDirty()

				arg_173_1.typewritterCharCountI18N = 0

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_9 = 0.466666666666667

			if 0.466666666666667 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_10 = 8
			local var_176_11 = 0.533333333333333
			local var_176_12, var_176_13 = arg_173_1:GetPercentByPara(arg_173_1:FormatText(arg_173_1:GetWordFromCfg(319781043).content), 1)

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_14 = var_176_10 <= 0 and var_176_11 or var_176_11 * ((var_176_13 - arg_173_1.typewritterCharCountI18N) / var_176_10)

				if (var_176_10 <= 0 and var_176_11 or var_176_11 * ((var_176_13 - arg_173_1.typewritterCharCountI18N) / var_176_10)) > 0 and var_176_11 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_9
					end
				end
			end

			local var_176_15 = math.max(0.533333333333333, arg_173_1.talkMaxDuration)

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_15 then
				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_12, (arg_173_1.time_ - var_176_9) / var_176_15)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_9 + var_176_15 and arg_173_1.time_ < var_176_9 + var_176_15 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_12

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_13
			end

			local var_176_16 = "STblack"

			if arg_173_1.bgs_.STblack == nil then
				local var_176_17 = Object.Instantiate(arg_173_1.paintGo_)

				var_176_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_176_16)
				var_176_17.name = var_176_16
				var_176_17.transform.parent = arg_173_1.stage_.transform
				var_176_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.bgs_[var_176_16] = var_176_17
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				local var_176_18 = arg_173_1.bgs_.STblack

				arg_173_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_19 = var_176_18:GetComponent("SpriteRenderer")

				if var_176_19 and var_176_19.sprite then
					local var_176_20 = 2 * (var_176_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_18.transform.localScale = Vector3.New(var_176_20 / var_176_19.sprite.bounds.size.y < var_176_20 * manager.ui.mainCameraCom_.aspect / var_176_19.sprite.bounds.size.x and var_176_20 * manager.ui.mainCameraCom_.aspect / var_176_19.sprite.bounds.size.x or var_176_20 / var_176_19.sprite.bounds.size.y, var_176_20 / var_176_19.sprite.bounds.size.y < var_176_20 * manager.ui.mainCameraCom_.aspect / var_176_19.sprite.bounds.size.x and var_176_20 * manager.ui.mainCameraCom_.aspect / var_176_19.sprite.bounds.size.x or var_176_20 / var_176_19.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "STblack" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_21 = 0.466666666666667
			local var_176_22 = manager.audio:GetVoiceLength("story_v_out_319781", "319781043", "story_v_out_319781.awb") / 1000

			if var_176_22 > 0 and 2.666 < var_176_22 and var_176_22 + var_176_21 > arg_173_1.duration_ then
				arg_173_1.duration_ = var_176_22 + var_176_21
			end

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1:AudioAction("play", "voice", "story_v_out_319781", "319781043", "story_v_out_319781.awb")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.cswbg_:SetActive(true)

				local var_176_24 = arg_173_1.cswt_:GetComponent("RectTransform")

				arg_173_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_176_24.offsetMin = Vector2.New(410, 330)
				var_176_24.offsetMax = Vector2.New(-400, -175)
				arg_173_1.cswt_.text = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(419053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.cswt_)

				arg_173_1.cswt_.fontSize = 180
				arg_173_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_173_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_173_1:InitPlayNodeList()
	end,
	Play319781044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319781044
		arg_177_1.duration_ = 1.8

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319781045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0
				arg_177_1.fswt_.text = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(319781044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_0 = 0.466666666666667

			if 0.466666666666667 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_1 = 6
			local var_180_2 = 0.4
			local var_180_3, var_180_4 = arg_177_1:GetPercentByPara(arg_177_1:FormatText(arg_177_1:GetWordFromCfg(319781044).content), 1)

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_5 = var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)

				if (var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end
			end

			local var_180_6 = math.max(0.4, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_6 then
				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_3, (arg_177_1.time_ - var_180_0) / var_180_6)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_6 and arg_177_1.time_ < var_180_0 + var_180_6 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_3

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_4
			end

			local var_180_7 = 0.466666666666667
			local var_180_8 = manager.audio:GetVoiceLength("story_v_out_319781", "319781044", "story_v_out_319781.awb") / 1000

			if var_180_8 > 0 and 1.333 < var_180_8 and var_180_8 + var_180_7 > arg_177_1.duration_ then
				arg_177_1.duration_ = var_180_8 + var_180_7
			end

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1:AudioAction("play", "voice", "story_v_out_319781", "319781044", "story_v_out_319781.awb")
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319781045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319781045
		arg_181_1.duration_ = 7.67

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319781046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				local var_184_0 = arg_181_1.bgs_.ST74

				arg_181_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_1 = var_184_0:GetComponent("SpriteRenderer")

				if var_184_1 and var_184_1.sprite then
					local var_184_2 = 2 * (var_184_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_0.transform.localScale = Vector3.New(var_184_2 / var_184_1.sprite.bounds.size.y < var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x and var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x or var_184_2 / var_184_1.sprite.bounds.size.y, var_184_2 / var_184_1.sprite.bounds.size.y < var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x and var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x or var_184_2 / var_184_1.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "ST74" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_3 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_3 + 0.3 and arg_181_1.time_ < var_184_3 + 0.3 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_4 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_5 = 1

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_5 then
				local var_184_6 = Color.New(0, 0, 0)

				var_184_6.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_4) / var_184_5)
				arg_181_1.mask_.color = var_184_6
			end

			if arg_181_1.time_ >= var_184_4 + var_184_5 and arg_181_1.time_ < var_184_4 + var_184_5 + arg_184_0 then
				local var_184_7 = Color.New(0, 0, 0)

				var_184_7.a = 1
				arg_181_1.mask_.color = var_184_7
			end

			local var_184_8 = 1

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_9 = 2

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 then
				local var_184_10 = Color.New(0, 0, 0)

				var_184_10.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_8) / var_184_9)
				arg_181_1.mask_.color = var_184_10
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 then
				local var_184_11 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_11.a = 0
				arg_181_1.mask_.color = var_184_11
			end

			local var_184_12 = arg_181_1.actors_["1084ui_story"].transform

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1084ui_story = var_184_12.localPosition
			end

			local var_184_13 = 0.001

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_13 then
				var_184_12.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 1) / var_184_13)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			if arg_181_1.time_ >= 1 + var_184_13 and arg_181_1.time_ < 1 + var_184_13 + arg_184_0 then
				var_184_12.localPosition = Vector3.New(0, 100, 0)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			local var_184_14 = arg_181_1.actors_["1095ui_story"].transform

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = var_184_14.localPosition
			end

			local var_184_15 = 0.001

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_15 then
				var_184_14.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 1) / var_184_15)
				var_184_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_14.position).x, (manager.ui.mainCamera.transform.position - var_184_14.position).y, (manager.ui.mainCamera.transform.position - var_184_14.position).z)
				var_184_14.localEulerAngles.z = 0
				var_184_14.localEulerAngles.x = 0
				var_184_14.localEulerAngles = var_184_14.localEulerAngles
			end

			if arg_181_1.time_ >= 1 + var_184_15 and arg_181_1.time_ < 1 + var_184_15 + arg_184_0 then
				var_184_14.localPosition = Vector3.New(0, 100, 0)
				var_184_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_14.position).x, (manager.ui.mainCamera.transform.position - var_184_14.position).y, (manager.ui.mainCamera.transform.position - var_184_14.position).z)
				var_184_14.localEulerAngles.z = 0
				var_184_14.localEulerAngles.x = 0
				var_184_14.localEulerAngles = var_184_14.localEulerAngles
			end

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(false)
				arg_181_1.dialog_:SetActive(false)
				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			if 1.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= 1.03400000184774 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(false)
				arg_181_1.dialog_:SetActive(false)
				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.cswbg_:SetActive(false)
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_16 = 2.66666666666667
			local var_184_17 = 1.125

			if 2.66666666666667 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_18 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_18:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(319781045).content)

				arg_181_1.text_.text = var_184_19

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 45 <= 0 and var_184_17 or var_184_17 * (utf8.len(var_184_19) / 45)

				if (45 <= 0 and var_184_17 or var_184_17 * (utf8.len(var_184_19) / 45)) > 0 and var_184_17 < var_184_21 then
					arg_181_1.talkMaxDuration = var_184_21
					var_184_16 = var_184_16 + 0.3

					if var_184_21 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_21 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_19
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = var_184_16 + 0.3
			local var_184_23 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_22 + var_184_23 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_22) / var_184_23

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_22 + var_184_23 and arg_181_1.time_ < var_184_22 + var_184_23 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319781046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319781046
		arg_187_1.duration_ = 6.37

		local var_187_0 = {
			zh = 4.3,
			ja = 6.366
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
			arg_187_1.auto_ = false
		end

		function arg_187_1.playNext_(arg_189_0)
			arg_187_1.onStoryFinished_()
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) and arg_187_1.var_.characterEffect1095ui_story == nil then
				arg_187_1.var_.characterEffect1095ui_story = arg_187_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) then
				if arg_187_1.var_.characterEffect1095ui_story and not isNil(arg_187_1.actors_["1095ui_story"]) then
					arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) and arg_187_1.var_.characterEffect1095ui_story then
				arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_190_2 = arg_187_1.actors_["1095ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1095ui_story = var_190_2.localPosition
			end

			local var_190_3 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_187_1.time_ - 0) / var_190_3)
				var_190_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_2.position).x, (manager.ui.mainCamera.transform.position - var_190_2.position).y, (manager.ui.mainCamera.transform.position - var_190_2.position).z)
				var_190_2.localEulerAngles.z = 0
				var_190_2.localEulerAngles.x = 0
				var_190_2.localEulerAngles = var_190_2.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_190_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_2.position).x, (manager.ui.mainCamera.transform.position - var_190_2.position).y, (manager.ui.mainCamera.transform.position - var_190_2.position).z)
				var_190_2.localEulerAngles.z = 0
				var_190_2.localEulerAngles.x = 0
				var_190_2.localEulerAngles = var_190_2.localEulerAngles
			end

			local var_190_4 = 0
			local var_190_5 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(319781046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 11 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 11)

				if (11 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 11)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319781", "319781046", "story_v_out_319781.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_319781", "319781046", "story_v_out_319781.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_319781", "319781046", "story_v_out_319781.awb")

						arg_187_1:RecordAudio("319781046", var_190_11)
						arg_187_1:RecordAudio("319781046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319781", "319781046", "story_v_out_319781.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319781", "319781046", "story_v_out_319781.awb")
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
				actorName = "1095ui_story",
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
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319781.awb"
	}
}
