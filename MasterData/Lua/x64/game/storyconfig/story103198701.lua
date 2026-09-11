return {
	Play319871001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319871001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			zh = 7.9,
			ja = 8.133
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
				arg_1_0:Play319871002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST71a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71a")
				var_4_0.name = "ST71a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST71a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST71a

				arg_1_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST71a" then
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

			local var_4_9 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1084ui_story"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 1.86666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_14 and arg_1_1.time_ < 1.86666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.97, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1084ui_story"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_16 and arg_1_1.time_ < 1.86666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano")

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

			local var_4_24 = 2
			local var_4_25 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(319871001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 32 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 32)

				if (32 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 32)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871001", "story_v_out_319871.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_319871", "319871001", "story_v_out_319871.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_319871", "319871001", "story_v_out_319871.awb")

						arg_1_1:RecordAudio("319871001", var_4_32)
						arg_1_1:RecordAudio("319871001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319871", "319871001", "story_v_out_319871.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319871", "319871001", "story_v_out_319871.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319871002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319871002
		arg_9_1.duration_ = 11.53

		local var_9_0 = {
			zh = 7.633,
			ja = 11.533
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
				arg_9_0:Play319871003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
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

				local var_12_1 = arg_9_1:GetWordFromCfg(319871002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 40)

				if (40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 40)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871002", "story_v_out_319871.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_319871", "319871002", "story_v_out_319871.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_319871", "319871002", "story_v_out_319871.awb")

						arg_9_1:RecordAudio("319871002", var_12_6)
						arg_9_1:RecordAudio("319871002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319871", "319871002", "story_v_out_319871.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319871", "319871002", "story_v_out_319871.awb")
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
	Play319871003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319871003
		arg_13_1.duration_ = 6.9

		local var_13_0 = {
			zh = 3.8,
			ja = 6.9
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
				arg_13_0:Play319871004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10068ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10068ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10068ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10068ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10068ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10068ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10068ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10068ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10068ui_story, Vector3.New(0.7, -0.75, -6.18), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.75, -6.18)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10068ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10068ui_story == nil then
				arg_13_1.var_.characterEffect10068ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10068ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10068ui_story then
				arg_13_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_8 = arg_13_1.actors_["1084ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["1084ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(319871003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 15 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 15)

				if (15 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 15)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871003", "story_v_out_319871.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_319871", "319871003", "story_v_out_319871.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_319871", "319871003", "story_v_out_319871.awb")

						arg_13_1:RecordAudio("319871003", var_16_19)
						arg_13_1:RecordAudio("319871003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319871", "319871003", "story_v_out_319871.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319871", "319871003", "story_v_out_319871.awb")
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
				actorName = "10068ui_story",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play319871004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319871004
		arg_17_1.duration_ = 6.2

		local var_17_0 = {
			zh = 5.033,
			ja = 6.2
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
				arg_17_0:Play319871005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10068ui_story"]) and arg_17_1.var_.characterEffect10068ui_story == nil then
				arg_17_1.var_.characterEffect10068ui_story = arg_17_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10068ui_story"]) then
				if arg_17_1.var_.characterEffect10068ui_story and not isNil(arg_17_1.actors_["10068ui_story"]) then
					arg_17_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10068ui_story"]) and arg_17_1.var_.characterEffect10068ui_story then
				arg_17_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_20_1 = arg_17_1.actors_["1084ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
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

				local var_20_6 = arg_17_1:GetWordFromCfg(319871004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 22 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 22)

				if (22 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 22)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871004", "story_v_out_319871.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871004", "story_v_out_319871.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319871", "319871004", "story_v_out_319871.awb")

						arg_17_1:RecordAudio("319871004", var_20_11)
						arg_17_1:RecordAudio("319871004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319871", "319871004", "story_v_out_319871.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319871", "319871004", "story_v_out_319871.awb")
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

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319871005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319871005
		arg_21_1.duration_ = 4.2

		local var_21_0 = {
			zh = 3.066,
			ja = 4.2
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
				arg_21_0:Play319871006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10068ui_story"]) and arg_21_1.var_.characterEffect10068ui_story == nil then
				arg_21_1.var_.characterEffect10068ui_story = arg_21_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10068ui_story"]) then
				if arg_21_1.var_.characterEffect10068ui_story and not isNil(arg_21_1.actors_["10068ui_story"]) then
					arg_21_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10068ui_story"]) and arg_21_1.var_.characterEffect10068ui_story then
				arg_21_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["1084ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319871005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 11 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 11)

				if (11 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 11)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871005", "story_v_out_319871.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871005", "story_v_out_319871.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319871", "319871005", "story_v_out_319871.awb")

						arg_21_1:RecordAudio("319871005", var_24_11)
						arg_21_1:RecordAudio("319871005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319871", "319871005", "story_v_out_319871.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319871", "319871005", "story_v_out_319871.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319871006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319871006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319871007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = arg_25_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10068ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10068ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(0, 100, 0)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			local var_28_3 = 0
			local var_28_4 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319871006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 41 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 41)

				if (41 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 41)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
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
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319871007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319871007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319871008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319871007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 49)

				if (49 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 49)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319871008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319871008
		arg_33_1.duration_ = 7.63

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319871009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.ST72a == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72a")
				var_36_0.name = "ST72a"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.ST72a = var_36_0
			end

			if 1 < arg_33_1.time_ and arg_33_1.time_ <= 1 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.ST72a

				arg_33_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "ST72a" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			if arg_33_1.time_ >= var_36_4 + 0.3 and arg_33_1.time_ < var_36_4 + 0.3 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_5 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_6 = 1

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_5) / var_36_6)
				arg_33_1.mask_.color = var_36_7
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 then
				local var_36_8 = Color.New(0, 0, 0)

				var_36_8.a = 1
				arg_33_1.mask_.color = var_36_8
			end

			local var_36_9 = 1

			if 1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_10 = 1.8

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 then
				local var_36_11 = Color.New(0, 0, 0)

				var_36_11.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_9) / var_36_10)
				arg_33_1.mask_.color = var_36_11
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 then
				local var_36_12 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_12.a = 0
				arg_33_1.mask_.color = var_36_12
			end

			local var_36_13 = arg_33_1.actors_["1084ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1084ui_story = var_36_13.localPosition
			end

			local var_36_14 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_14 then
				var_36_13.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_14)
				var_36_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_13.position).x, (manager.ui.mainCamera.transform.position - var_36_13.position).y, (manager.ui.mainCamera.transform.position - var_36_13.position).z)
				var_36_13.localEulerAngles.z = 0
				var_36_13.localEulerAngles.x = 0
				var_36_13.localEulerAngles = var_36_13.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_14 and arg_33_1.time_ < 0 + var_36_14 + arg_36_0 then
				var_36_13.localPosition = Vector3.New(0, 100, 0)
				var_36_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_13.position).x, (manager.ui.mainCamera.transform.position - var_36_13.position).y, (manager.ui.mainCamera.transform.position - var_36_13.position).z)
				var_36_13.localEulerAngles.z = 0
				var_36_13.localEulerAngles.x = 0
				var_36_13.localEulerAngles = var_36_13.localEulerAngles
			end

			local var_36_15 = arg_33_1.actors_["1084ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_16 and not isNil(var_36_15) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_15) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_16)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_16 and arg_33_1.time_ < 0 + var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_17 = 2.63333333333333
			local var_36_18 = 0.525

			if 2.63333333333333 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_19 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_19:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_20 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319871008).content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_22 = 21 <= 0 and var_36_18 or var_36_18 * (utf8.len(var_36_20) / 21)

				if (21 <= 0 and var_36_18 or var_36_18 * (utf8.len(var_36_20) / 21)) > 0 and var_36_18 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22
					var_36_17 = var_36_17 + 0.3

					if var_36_22 + var_36_17 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_17
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_23 = var_36_17 + 0.3
			local var_36_24 = math.max(var_36_18, arg_33_1.talkMaxDuration)

			if var_36_17 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319871009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319871009
		arg_39_1.duration_ = 7.8

		local var_39_0 = {
			zh = 6.4,
			ja = 7.8
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
				arg_39_0:Play319871010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_42_0 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_39_1.stage_.transform)

				var_42_0.name = "10069ui_story"
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["10069ui_story"] = var_42_0

				local var_42_1 = var_42_0:GetComponentInChildren(typeof(CharacterEffect))

				var_42_1.enabled = true

				local var_42_2 = GameObjectTools.GetOrAddComponent(var_42_0, typeof(DynamicBoneHelper))

				if var_42_2 then
					var_42_2:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_1.transform, false)

				arg_39_1.var_["10069ui_story" .. "Animator"] = var_42_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_["10069ui_story" .. "Animator"].applyRootMotion = true
				arg_39_1.var_["10069ui_story" .. "LipSync"] = var_42_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_3 = arg_39_1.actors_["10069ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10069ui_story = var_42_3.localPosition
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_3.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_39_1.time_ - 0) / var_42_4)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_3.localPosition = Vector3.New(0, -1.08, -6.33)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			local var_42_5 = arg_39_1.actors_["10069ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect10069ui_story == nil then
				arg_39_1.var_.characterEffect10069ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.characterEffect10069ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect10069ui_story then
				arg_39_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_8 = 0
			local var_42_9 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(319871009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 32 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 32)

				if (32 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 32)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871009", "story_v_out_319871.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_319871", "319871009", "story_v_out_319871.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_319871", "319871009", "story_v_out_319871.awb")

						arg_39_1:RecordAudio("319871009", var_42_15)
						arg_39_1:RecordAudio("319871009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319871", "319871009", "story_v_out_319871.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319871", "319871009", "story_v_out_319871.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319871010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319871010
		arg_43_1.duration_ = 6.47

		local var_43_0 = {
			zh = 4.033,
			ja = 6.466
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
				arg_43_0:Play319871011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "1095ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1095ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["1095ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["1095ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["1095ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1095ui_story = var_46_3.localPosition
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_43_1.time_ - 0) / var_46_4)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			local var_46_5 = arg_43_1.actors_["1095ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.characterEffect1095ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1095ui_story then
				arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_8 = arg_43_1.actors_["10069ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10069ui_story = var_46_8.localPosition
			end

			local var_46_9 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_9 then
				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_43_1.time_ - 0) / var_46_9)
				var_46_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_8.position).x, (manager.ui.mainCamera.transform.position - var_46_8.position).y, (manager.ui.mainCamera.transform.position - var_46_8.position).z)
				var_46_8.localEulerAngles.z = 0
				var_46_8.localEulerAngles.x = 0
				var_46_8.localEulerAngles = var_46_8.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_9 and arg_43_1.time_ < 0 + var_46_9 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				var_46_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_8.position).x, (manager.ui.mainCamera.transform.position - var_46_8.position).y, (manager.ui.mainCamera.transform.position - var_46_8.position).z)
				var_46_8.localEulerAngles.z = 0
				var_46_8.localEulerAngles.x = 0
				var_46_8.localEulerAngles = var_46_8.localEulerAngles
			end

			local var_46_10 = arg_43_1.actors_["10069ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect10069ui_story == nil then
				arg_43_1.var_.characterEffect10069ui_story = var_46_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_11 and not isNil(var_46_10) then
				if arg_43_1.var_.characterEffect10069ui_story and not isNil(var_46_10) then
					arg_43_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_43_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_11)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_11 and arg_43_1.time_ < 0 + var_46_11 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect10069ui_story then
				arg_43_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_43_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_46_12 = 0
			local var_46_13 = 0.55

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(319871010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 22 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 22)

				if (22 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 22)) > 0 and var_46_13 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871010", "story_v_out_319871.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_319871", "319871010", "story_v_out_319871.awb") / 1000

					if var_46_18 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_12
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_319871", "319871010", "story_v_out_319871.awb")

						arg_43_1:RecordAudio("319871010", var_46_19)
						arg_43_1:RecordAudio("319871010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319871", "319871010", "story_v_out_319871.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319871", "319871010", "story_v_out_319871.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_20 and arg_43_1.time_ < var_46_12 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
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
	Play319871011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319871011
		arg_47_1.duration_ = 2.67

		local var_47_0 = {
			zh = 2.4,
			ja = 2.666
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
				arg_47_0:Play319871012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1095ui_story"]) and arg_47_1.var_.characterEffect1095ui_story == nil then
				arg_47_1.var_.characterEffect1095ui_story = arg_47_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1095ui_story"]) then
				if arg_47_1.var_.characterEffect1095ui_story and not isNil(arg_47_1.actors_["1095ui_story"]) then
					arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1095ui_story"]) and arg_47_1.var_.characterEffect1095ui_story then
				arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_50_1 = arg_47_1.actors_["10069ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10069ui_story == nil then
				arg_47_1.var_.characterEffect10069ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10069ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10069ui_story then
				arg_47_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_50_4 = 0
			local var_50_5 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(319871011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 9 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 9)

				if (9 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 9)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871011", "story_v_out_319871.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871011", "story_v_out_319871.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_319871", "319871011", "story_v_out_319871.awb")

						arg_47_1:RecordAudio("319871011", var_50_11)
						arg_47_1:RecordAudio("319871011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319871", "319871011", "story_v_out_319871.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319871", "319871011", "story_v_out_319871.awb")
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
	Play319871012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319871012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319871013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10069ui_story"]) and arg_51_1.var_.characterEffect10069ui_story == nil then
				arg_51_1.var_.characterEffect10069ui_story = arg_51_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10069ui_story"]) then
				if arg_51_1.var_.characterEffect10069ui_story and not isNil(arg_51_1.actors_["10069ui_story"]) then
					arg_51_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10069ui_story"]) and arg_51_1.var_.characterEffect10069ui_story then
				arg_51_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.625

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319871012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 25 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 25)

				if (25 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 25)) > 0 and var_54_2 < var_54_5 then
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
	Play319871013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319871013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319871014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.125

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

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(319871013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 45 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 45)

				if (45 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 45)) > 0 and var_58_0 < var_58_3 then
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
	Play319871014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319871014
		arg_59_1.duration_ = 6.77

		local var_59_0 = {
			zh = 6.766,
			ja = 6.1
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
				arg_59_0:Play319871015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1095ui_story = arg_59_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).z)
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles = arg_59_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_59_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1095ui_story"].transform.position).z)
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1095ui_story"].transform.localEulerAngles = arg_59_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1095ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1095ui_story == nil then
				arg_59_1.var_.characterEffect1095ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1095ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1095ui_story then
				arg_59_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.775

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
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

				local var_62_6 = arg_59_1:GetWordFromCfg(319871014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 31 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 31)

				if (31 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 31)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871014", "story_v_out_319871.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871014", "story_v_out_319871.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_319871", "319871014", "story_v_out_319871.awb")

						arg_59_1:RecordAudio("319871014", var_62_11)
						arg_59_1:RecordAudio("319871014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319871", "319871014", "story_v_out_319871.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319871", "319871014", "story_v_out_319871.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play319871015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319871015
		arg_63_1.duration_ = 5.13

		local var_63_0 = {
			zh = 2.566,
			ja = 5.133
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
				arg_63_0:Play319871016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) and arg_63_1.var_.characterEffect1095ui_story == nil then
				arg_63_1.var_.characterEffect1095ui_story = arg_63_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) then
				if arg_63_1.var_.characterEffect1095ui_story and not isNil(arg_63_1.actors_["1095ui_story"]) then
					arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) and arg_63_1.var_.characterEffect1095ui_story then
				arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_66_1 = arg_63_1.actors_["10069ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10069ui_story == nil then
				arg_63_1.var_.characterEffect10069ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect10069ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10069ui_story then
				arg_63_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_66_4 = 0
			local var_66_5 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(319871015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 14 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 14)

				if (14 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 14)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871015", "story_v_out_319871.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871015", "story_v_out_319871.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_319871", "319871015", "story_v_out_319871.awb")

						arg_63_1:RecordAudio("319871015", var_66_11)
						arg_63_1:RecordAudio("319871015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319871", "319871015", "story_v_out_319871.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319871", "319871015", "story_v_out_319871.awb")
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

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319871016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319871016
		arg_67_1.duration_ = 7.8

		local var_67_0 = {
			zh = 2.666,
			ja = 7.8
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319871017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1095ui_story"]) and arg_67_1.var_.characterEffect1095ui_story == nil then
				arg_67_1.var_.characterEffect1095ui_story = arg_67_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1095ui_story"]) then
				if arg_67_1.var_.characterEffect1095ui_story and not isNil(arg_67_1.actors_["1095ui_story"]) then
					arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1095ui_story"]) and arg_67_1.var_.characterEffect1095ui_story then
				arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_70_2 = arg_67_1.actors_["10069ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect10069ui_story == nil then
				arg_67_1.var_.characterEffect10069ui_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_3 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.characterEffect10069ui_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_3)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect10069ui_story then
				arg_67_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_70_4 = 0
			local var_70_5 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(319871016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 12 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 12)

				if (12 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 12)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871016", "story_v_out_319871.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871016", "story_v_out_319871.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_319871", "319871016", "story_v_out_319871.awb")

						arg_67_1:RecordAudio("319871016", var_70_11)
						arg_67_1:RecordAudio("319871016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319871", "319871016", "story_v_out_319871.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319871", "319871016", "story_v_out_319871.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319871017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319871017
		arg_71_1.duration_ = 2.17

		local var_71_0 = {
			zh = 2.133,
			ja = 2.166
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
				arg_71_0:Play319871018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10069ui_story = arg_71_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).z)
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles = arg_71_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				arg_71_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10069ui_story"].transform.position).z)
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10069ui_story"].transform.localEulerAngles = arg_71_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10069ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10069ui_story == nil then
				arg_71_1.var_.characterEffect10069ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10069ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10069ui_story then
				arg_71_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action3_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_4 = arg_71_1.actors_["1095ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect1095ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1095ui_story then
				arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_74_6 = 0
			local var_74_7 = 0.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(319871017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 12 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 12)

				if (12 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 12)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871017", "story_v_out_319871.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_319871", "319871017", "story_v_out_319871.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_319871", "319871017", "story_v_out_319871.awb")

						arg_71_1:RecordAudio("319871017", var_74_13)
						arg_71_1:RecordAudio("319871017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319871", "319871017", "story_v_out_319871.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319871", "319871017", "story_v_out_319871.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319871018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319871018
		arg_75_1.duration_ = 16.57

		local var_75_0 = {
			zh = 8.9,
			ja = 16.566
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319871019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10069ui_story"]) and arg_75_1.var_.characterEffect10069ui_story == nil then
				arg_75_1.var_.characterEffect10069ui_story = arg_75_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10069ui_story"]) then
				if arg_75_1.var_.characterEffect10069ui_story and not isNil(arg_75_1.actors_["10069ui_story"]) then
					arg_75_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10069ui_story"]) and arg_75_1.var_.characterEffect10069ui_story then
				arg_75_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_78_1 = arg_75_1.actors_["1095ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1095ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1095ui_story then
				arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_78_4 = 0
			local var_78_5 = 1.025

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(319871018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 41 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 41)

				if (41 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 41)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871018", "story_v_out_319871.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871018", "story_v_out_319871.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_319871", "319871018", "story_v_out_319871.awb")

						arg_75_1:RecordAudio("319871018", var_78_11)
						arg_75_1:RecordAudio("319871018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319871", "319871018", "story_v_out_319871.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319871", "319871018", "story_v_out_319871.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319871019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319871019
		arg_79_1.duration_ = 13.63

		local var_79_0 = {
			zh = 10.666,
			ja = 13.633
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319871020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:GetWordFromCfg(319871019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 51 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 51)

				if (51 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 51)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871019", "story_v_out_319871.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_319871", "319871019", "story_v_out_319871.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_319871", "319871019", "story_v_out_319871.awb")

						arg_79_1:RecordAudio("319871019", var_82_6)
						arg_79_1:RecordAudio("319871019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319871", "319871019", "story_v_out_319871.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319871", "319871019", "story_v_out_319871.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319871020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319871020
		arg_83_1.duration_ = 3.63

		local var_83_0 = {
			zh = 2.43333333333333,
			ja = 3.63333333333333
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
				arg_83_0:Play319871021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1095ui_story = arg_83_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).z)
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles = arg_83_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_83_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).z)
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles = arg_83_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1095ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1095ui_story == nil then
				arg_83_1.var_.characterEffect1095ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1095ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1095ui_story then
				arg_83_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_4 = 1.23333333333333
			local var_86_5 = 0.125

			if 1.23333333333333 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_6 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_6:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(319871020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 5 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_8) / 5)

				if (5 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_8) / 5)) > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10
					var_86_4 = var_86_4 + 0.3

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871020", "story_v_out_319871.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_319871", "319871020", "story_v_out_319871.awb") / 1000

					if var_86_11 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_4
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_319871", "319871020", "story_v_out_319871.awb")

						arg_83_1:RecordAudio("319871020", var_86_12)
						arg_83_1:RecordAudio("319871020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319871", "319871020", "story_v_out_319871.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319871", "319871020", "story_v_out_319871.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = var_86_4 + 0.3
			local var_86_14 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_13 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_13) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_13 + var_86_14 and arg_83_1.time_ < var_86_13 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play319871021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319871021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319871022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = arg_89_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(arg_89_1.actors_["1095ui_story"]) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1095ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1095ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, 100, 0)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = arg_89_1.actors_["10069ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10069ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_4)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(0, 100, 0)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			local var_92_5 = 0
			local var_92_6 = 0.55

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319871021).content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 22 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 22)

				if (22 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 22)) > 0 and var_92_6 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_10 and arg_89_1.time_ < var_92_5 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
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
	Play319871022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319871022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319871023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319871022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 49)

				if (49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 49)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319871023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319871023
		arg_97_1.duration_ = 6.53

		local var_97_0 = {
			zh = 5.366,
			ja = 6.533
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
				arg_97_0:Play319871024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10069ui_story = arg_97_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).z)
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles = arg_97_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				arg_97_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10069ui_story"].transform.position).z)
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10069ui_story"].transform.localEulerAngles = arg_97_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10069ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10069ui_story == nil then
				arg_97_1.var_.characterEffect10069ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10069ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10069ui_story then
				arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action3_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(319871023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 24 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 24)

				if (24 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 24)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871023", "story_v_out_319871.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871023", "story_v_out_319871.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_319871", "319871023", "story_v_out_319871.awb")

						arg_97_1:RecordAudio("319871023", var_100_11)
						arg_97_1:RecordAudio("319871023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319871", "319871023", "story_v_out_319871.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319871", "319871023", "story_v_out_319871.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319871024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319871024
		arg_101_1.duration_ = 12.07

		local var_101_0 = {
			zh = 8.5,
			ja = 12.066
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
				arg_101_0:Play319871025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = arg_101_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) then
				if arg_101_1.var_.characterEffect10069ui_story and not isNil(arg_101_1.actors_["10069ui_story"]) then
					arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) and arg_101_1.var_.characterEffect10069ui_story then
				arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_104_1 = arg_101_1.actors_["1095ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = var_104_1.localPosition
			end

			local var_104_2 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_101_1.time_ - 0) / var_104_2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			local var_104_3 = arg_101_1.actors_["10069ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10069ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = arg_101_1.actors_["1095ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_5) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_104_8 = 0
			local var_104_9 = 1.125

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
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

				local var_104_10 = arg_101_1:GetWordFromCfg(319871024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 45 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 45)

				if (45 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 45)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871024", "story_v_out_319871.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_319871", "319871024", "story_v_out_319871.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_319871", "319871024", "story_v_out_319871.awb")

						arg_101_1:RecordAudio("319871024", var_104_15)
						arg_101_1:RecordAudio("319871024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319871", "319871024", "story_v_out_319871.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319871", "319871024", "story_v_out_319871.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
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
	Play319871025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319871025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319871026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) and arg_105_1.var_.characterEffect1095ui_story == nil then
				arg_105_1.var_.characterEffect1095ui_story = arg_105_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) then
				if arg_105_1.var_.characterEffect1095ui_story and not isNil(arg_105_1.actors_["1095ui_story"]) then
					arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) and arg_105_1.var_.characterEffect1095ui_story then
				arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_108_1 = 0
			local var_108_2 = 0.75

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

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(319871025).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 30 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 30)

				if (30 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 30)) > 0 and var_108_2 < var_108_5 then
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
	Play319871026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319871026
		arg_109_1.duration_ = 7.3

		local var_109_0 = {
			zh = 5.433,
			ja = 7.3
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
				arg_109_0:Play319871027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_0 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_1 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(var_112_0) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_112_3 = 0
			local var_112_4 = 0.65

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(319871026)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 26 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 26)

				if (26 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 26)) > 0 and var_112_4 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871026", "story_v_out_319871.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_319871", "319871026", "story_v_out_319871.awb") / 1000

					if var_112_9 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_3
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_319871", "319871026", "story_v_out_319871.awb")

						arg_109_1:RecordAudio("319871026", var_112_10)
						arg_109_1:RecordAudio("319871026", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319871", "319871026", "story_v_out_319871.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319871", "319871026", "story_v_out_319871.awb")
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
	Play319871027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319871027
		arg_113_1.duration_ = 6.47

		local var_113_0 = {
			zh = 5.833333333332,
			ja = 6.46633333631357
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
				arg_113_0:Play319871028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_0 = arg_113_1.bgs_.ST71a

				arg_113_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_1 = var_116_0:GetComponent("SpriteRenderer")

				if var_116_1 and var_116_1.sprite then
					local var_116_2 = 2 * (var_116_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_0.transform.localScale = Vector3.New(var_116_2 / var_116_1.sprite.bounds.size.y < var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x and var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x or var_116_2 / var_116_1.sprite.bounds.size.y, var_116_2 / var_116_1.sprite.bounds.size.y < var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x and var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x or var_116_2 / var_116_1.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST71a" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_3 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_3 + 0.3 and arg_113_1.time_ < var_116_3 + 0.3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 2

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = 1
				arg_113_1.mask_.color = var_116_7
			end

			local var_116_8 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_9 = 2

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 then
				local var_116_10 = Color.New(0, 0, 0)

				var_116_10.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_8) / var_116_9)
				arg_113_1.mask_.color = var_116_10
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 then
				local var_116_11 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_11.a = 0
				arg_113_1.mask_.color = var_116_11
			end

			local var_116_12 = arg_113_1.actors_["10068ui_story"].transform

			if 3.83333333333333 < arg_113_1.time_ and arg_113_1.time_ <= 3.83333333333333 + arg_116_0 then
				arg_113_1.var_.moveOldPos10068ui_story = var_116_12.localPosition
			end

			local var_116_13 = 0.001

			if 3.83333333333333 <= arg_113_1.time_ and arg_113_1.time_ < 3.83333333333333 + var_116_13 then
				var_116_12.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10068ui_story, Vector3.New(0, -0.75, -6.18), (arg_113_1.time_ - 3.83333333333333) / var_116_13)
				var_116_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_12.position).x, (manager.ui.mainCamera.transform.position - var_116_12.position).y, (manager.ui.mainCamera.transform.position - var_116_12.position).z)
				var_116_12.localEulerAngles.z = 0
				var_116_12.localEulerAngles.x = 0
				var_116_12.localEulerAngles = var_116_12.localEulerAngles
			end

			if arg_113_1.time_ >= 3.83333333333333 + var_116_13 and arg_113_1.time_ < 3.83333333333333 + var_116_13 + arg_116_0 then
				var_116_12.localPosition = Vector3.New(0, -0.75, -6.18)
				var_116_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_12.position).x, (manager.ui.mainCamera.transform.position - var_116_12.position).y, (manager.ui.mainCamera.transform.position - var_116_12.position).z)
				var_116_12.localEulerAngles.z = 0
				var_116_12.localEulerAngles.x = 0
				var_116_12.localEulerAngles = var_116_12.localEulerAngles
			end

			local var_116_14 = arg_113_1.actors_["10068ui_story"]

			if 3.83333333333333 < arg_113_1.time_ and arg_113_1.time_ <= 3.83333333333333 + arg_116_0 and not isNil(var_116_14) and arg_113_1.var_.characterEffect10068ui_story == nil then
				arg_113_1.var_.characterEffect10068ui_story = var_116_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_15 = 0.200000002980232

			if 3.83333333333333 <= arg_113_1.time_ and arg_113_1.time_ < 3.83333333333333 + var_116_15 and not isNil(var_116_14) then
				if arg_113_1.var_.characterEffect10068ui_story and not isNil(var_116_14) then
					arg_113_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 3.83333333333333 + var_116_15 and arg_113_1.time_ < 3.83333333333333 + var_116_15 + arg_116_0 and not isNil(var_116_14) and arg_113_1.var_.characterEffect10068ui_story then
				arg_113_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_113_1.time_ and arg_113_1.time_ <= 3.83333333333333 + arg_116_0 then
				arg_113_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_2")
			end

			if 3.83333333333333 < arg_113_1.time_ and arg_113_1.time_ <= 3.83333333333333 + arg_116_0 then
				arg_113_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_17 = arg_113_1.actors_["1095ui_story"].transform

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				arg_113_1.var_.moveOldPos1095ui_story = var_116_17.localPosition
			end

			local var_116_18 = 0.001

			if 2 <= arg_113_1.time_ and arg_113_1.time_ < 2 + var_116_18 then
				var_116_17.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 2) / var_116_18)
				var_116_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_17.position).x, (manager.ui.mainCamera.transform.position - var_116_17.position).y, (manager.ui.mainCamera.transform.position - var_116_17.position).z)
				var_116_17.localEulerAngles.z = 0
				var_116_17.localEulerAngles.x = 0
				var_116_17.localEulerAngles = var_116_17.localEulerAngles
			end

			if arg_113_1.time_ >= 2 + var_116_18 and arg_113_1.time_ < 2 + var_116_18 + arg_116_0 then
				var_116_17.localPosition = Vector3.New(0, 100, 0)
				var_116_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_17.position).x, (manager.ui.mainCamera.transform.position - var_116_17.position).y, (manager.ui.mainCamera.transform.position - var_116_17.position).z)
				var_116_17.localEulerAngles.z = 0
				var_116_17.localEulerAngles.x = 0
				var_116_17.localEulerAngles = var_116_17.localEulerAngles
			end

			local var_116_19 = arg_113_1.actors_["10069ui_story"].transform

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				arg_113_1.var_.moveOldPos10069ui_story = var_116_19.localPosition
			end

			local var_116_20 = 0.001

			if 2 <= arg_113_1.time_ and arg_113_1.time_ < 2 + var_116_20 then
				var_116_19.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 2) / var_116_20)
				var_116_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_19.position).x, (manager.ui.mainCamera.transform.position - var_116_19.position).y, (manager.ui.mainCamera.transform.position - var_116_19.position).z)
				var_116_19.localEulerAngles.z = 0
				var_116_19.localEulerAngles.x = 0
				var_116_19.localEulerAngles = var_116_19.localEulerAngles
			end

			if arg_113_1.time_ >= 2 + var_116_20 and arg_113_1.time_ < 2 + var_116_20 + arg_116_0 then
				var_116_19.localPosition = Vector3.New(0, 100, 0)
				var_116_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_19.position).x, (manager.ui.mainCamera.transform.position - var_116_19.position).y, (manager.ui.mainCamera.transform.position - var_116_19.position).z)
				var_116_19.localEulerAngles.z = 0
				var_116_19.localEulerAngles.x = 0
				var_116_19.localEulerAngles = var_116_19.localEulerAngles
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_21 = 4.03333333631357
			local var_116_22 = 0.125

			if 4.03333333631357 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_23 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_23:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_24 = arg_113_1:GetWordFromCfg(319871027)
				local var_116_25 = arg_113_1:FormatText(var_116_24.content)

				arg_113_1.text_.text = var_116_25

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_27 = 5 <= 0 and var_116_22 or var_116_22 * (utf8.len(var_116_25) / 5)

				if (5 <= 0 and var_116_22 or var_116_22 * (utf8.len(var_116_25) / 5)) > 0 and var_116_22 < var_116_27 then
					arg_113_1.talkMaxDuration = var_116_27
					var_116_21 = var_116_21 + 0.3

					if var_116_27 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_27 + var_116_21
					end
				end

				arg_113_1.text_.text = var_116_25
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871027", "story_v_out_319871.awb") ~= 0 then
					local var_116_28 = manager.audio:GetVoiceLength("story_v_out_319871", "319871027", "story_v_out_319871.awb") / 1000

					if var_116_28 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_28 + var_116_21
					end

					if var_116_24.prefab_name ~= "" and arg_113_1.actors_[var_116_24.prefab_name] ~= nil then
						local var_116_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_24.prefab_name].transform, "story_v_out_319871", "319871027", "story_v_out_319871.awb")

						arg_113_1:RecordAudio("319871027", var_116_29)
						arg_113_1:RecordAudio("319871027", var_116_29)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319871", "319871027", "story_v_out_319871.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319871", "319871027", "story_v_out_319871.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_30 = var_116_21 + 0.3
			local var_116_31 = math.max(var_116_22, arg_113_1.talkMaxDuration)

			if var_116_21 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_30 + var_116_31 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_30) / var_116_31

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_30 + var_116_31 and arg_113_1.time_ < var_116_30 + var_116_31 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play319871028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319871028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play319871029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10068ui_story"]) and arg_119_1.var_.characterEffect10068ui_story == nil then
				arg_119_1.var_.characterEffect10068ui_story = arg_119_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10068ui_story"]) then
				if arg_119_1.var_.characterEffect10068ui_story and not isNil(arg_119_1.actors_["10068ui_story"]) then
					arg_119_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10068ui_story"]) and arg_119_1.var_.characterEffect10068ui_story then
				arg_119_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.8

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(319871028).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 32 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 32)

				if (32 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 32)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319871029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319871029
		arg_123_1.duration_ = 5.67

		local var_123_0 = {
			zh = 3.333,
			ja = 5.666
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
				arg_123_0:Play319871030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1084ui_story = arg_123_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).z)
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles = arg_123_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_123_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).z)
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles = arg_123_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_126_4 = arg_123_1.actors_["10068ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10068ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10068ui_story, Vector3.New(-0.7, -0.75, -6.18), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(-0.7, -0.75, -6.18)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["10068ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10068ui_story == nil then
				arg_123_1.var_.characterEffect10068ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 and not isNil(var_126_6) then
				if arg_123_1.var_.characterEffect10068ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_7)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10068ui_story then
				arg_123_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_126_8 = 0
			local var_126_9 = 0.35

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(319871029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 14 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 14)

				if (14 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 14)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871029", "story_v_out_319871.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_319871", "319871029", "story_v_out_319871.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_319871", "319871029", "story_v_out_319871.awb")

						arg_123_1:RecordAudio("319871029", var_126_15)
						arg_123_1:RecordAudio("319871029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319871", "319871029", "story_v_out_319871.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319871", "319871029", "story_v_out_319871.awb")
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
				actorName = "10068ui_story",
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
	Play319871030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319871030
		arg_127_1.duration_ = 8.9

		local var_127_0 = {
			zh = 5.933,
			ja = 8.9
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319871031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = arg_127_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(arg_127_1.actors_["1084ui_story"]) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action3_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_1 = arg_127_1.actors_["10068ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10068ui_story == nil then
				arg_127_1.var_.characterEffect10068ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10068ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10068ui_story then
				arg_127_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319871030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 20 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 20)

				if (20 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 20)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871030", "story_v_out_319871.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871030", "story_v_out_319871.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319871", "319871030", "story_v_out_319871.awb")

						arg_127_1:RecordAudio("319871030", var_130_11)
						arg_127_1:RecordAudio("319871030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319871", "319871030", "story_v_out_319871.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319871", "319871030", "story_v_out_319871.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319871031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319871031
		arg_131_1.duration_ = 2.7

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_131_0:Play319871032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = arg_131_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(arg_131_1.actors_["1084ui_story"]) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_2 = arg_131_1.actors_["10068ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect10068ui_story == nil then
				arg_131_1.var_.characterEffect10068ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect10068ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect10068ui_story then
				arg_131_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_134_4 = 0
			local var_134_5 = 0.25

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(319871031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 10 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 10)

				if (10 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 10)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871031", "story_v_out_319871.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871031", "story_v_out_319871.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_319871", "319871031", "story_v_out_319871.awb")

						arg_131_1:RecordAudio("319871031", var_134_11)
						arg_131_1:RecordAudio("319871031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319871", "319871031", "story_v_out_319871.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319871", "319871031", "story_v_out_319871.awb")
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

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319871032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319871032
		arg_135_1.duration_ = 10.93

		local var_135_0 = {
			zh = 9.8,
			ja = 10.933
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
				arg_135_0:Play319871033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = arg_135_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) then
				if arg_135_1.var_.characterEffect1084ui_story and not isNil(arg_135_1.actors_["1084ui_story"]) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_138_1 = arg_135_1.actors_["10068ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10068ui_story == nil then
				arg_135_1.var_.characterEffect10068ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10068ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10068ui_story then
				arg_135_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.975

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(319871032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 39 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 39)

				if (39 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 39)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871032", "story_v_out_319871.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871032", "story_v_out_319871.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_319871", "319871032", "story_v_out_319871.awb")

						arg_135_1:RecordAudio("319871032", var_138_11)
						arg_135_1:RecordAudio("319871032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319871", "319871032", "story_v_out_319871.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319871", "319871032", "story_v_out_319871.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319871033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319871033
		arg_139_1.duration_ = 6.67

		local var_139_0 = {
			zh = 6.666,
			ja = 6.6
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
				arg_139_0:Play319871034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068actionlink/10068action434")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_0 = 0
			local var_142_1 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(319871033)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 26 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 26)

				if (26 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 26)) > 0 and var_142_1 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871033", "story_v_out_319871.awb") ~= 0 then
					local var_142_6 = manager.audio:GetVoiceLength("story_v_out_319871", "319871033", "story_v_out_319871.awb") / 1000

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end

					if var_142_2.prefab_name ~= "" and arg_139_1.actors_[var_142_2.prefab_name] ~= nil then
						local var_142_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_2.prefab_name].transform, "story_v_out_319871", "319871033", "story_v_out_319871.awb")

						arg_139_1:RecordAudio("319871033", var_142_7)
						arg_139_1:RecordAudio("319871033", var_142_7)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319871", "319871033", "story_v_out_319871.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319871", "319871033", "story_v_out_319871.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319871034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319871034
		arg_143_1.duration_ = 3.6

		local var_143_0 = {
			zh = 2.3,
			ja = 3.6
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
				arg_143_0:Play319871035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1084ui_story = arg_143_1.actors_["1084ui_story"].transform.localPosition

				arg_143_1:ShowWeapon(arg_143_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).z)
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles = arg_143_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_143_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1084ui_story"].transform.position).z)
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1084ui_story"].transform.localEulerAngles = arg_143_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1084ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1084ui_story == nil then
				arg_143_1.var_.characterEffect1084ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1084ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1084ui_story then
				arg_143_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["10068ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10068ui_story == nil then
				arg_143_1.var_.characterEffect10068ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_5 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 and not isNil(var_146_4) then
				if arg_143_1.var_.characterEffect10068ui_story and not isNil(var_146_4) then
					arg_143_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_5)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10068ui_story then
				arg_143_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_146_6 = 0
			local var_146_7 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(319871034)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 12 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 12)

				if (12 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 12)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871034", "story_v_out_319871.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_319871", "319871034", "story_v_out_319871.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_319871", "319871034", "story_v_out_319871.awb")

						arg_143_1:RecordAudio("319871034", var_146_13)
						arg_143_1:RecordAudio("319871034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319871", "319871034", "story_v_out_319871.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319871", "319871034", "story_v_out_319871.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play319871035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319871035
		arg_147_1.duration_ = 6.1

		local var_147_0 = {
			zh = 6.1,
			ja = 5.733
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
				arg_147_0:Play319871036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.8

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(319871035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 32 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 32)

				if (32 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 32)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871035", "story_v_out_319871.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_out_319871", "319871035", "story_v_out_319871.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_out_319871", "319871035", "story_v_out_319871.awb")

						arg_147_1:RecordAudio("319871035", var_150_7)
						arg_147_1:RecordAudio("319871035", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319871", "319871035", "story_v_out_319871.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319871", "319871035", "story_v_out_319871.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319871036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319871036
		arg_151_1.duration_ = 2.6

		local var_151_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_151_0:Play319871037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10068ui_story = arg_151_1.actors_["10068ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10068ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10068ui_story, Vector3.New(-0.7, -0.75, -6.18), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).z)
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles = arg_151_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10068ui_story"].transform.localPosition = Vector3.New(-0.7, -0.75, -6.18)
				arg_151_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10068ui_story"].transform.position).z)
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10068ui_story"].transform.localEulerAngles = arg_151_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10068ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10068ui_story == nil then
				arg_151_1.var_.characterEffect10068ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10068ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10068ui_story then
				arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action4_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_154_4 = arg_151_1.actors_["1084ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_5 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 and not isNil(var_154_4) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_4) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_5)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_154_6 = 0
			local var_154_7 = 0.1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(319871036)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 4 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 4)

				if (4 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 4)) > 0 and var_154_7 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871036", "story_v_out_319871.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_319871", "319871036", "story_v_out_319871.awb") / 1000

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_319871", "319871036", "story_v_out_319871.awb")

						arg_151_1:RecordAudio("319871036", var_154_13)
						arg_151_1:RecordAudio("319871036", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319871", "319871036", "story_v_out_319871.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319871", "319871036", "story_v_out_319871.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319871037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319871037
		arg_155_1.duration_ = 2.9

		local var_155_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_155_0:Play319871038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = arg_155_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).z)
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles = arg_155_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_155_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1084ui_story"].transform.position).z)
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1084ui_story"].transform.localEulerAngles = arg_155_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1084ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1084ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1084ui_story then
				arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_158_4 = arg_155_1.actors_["10068ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect10068ui_story == nil then
				arg_155_1.var_.characterEffect10068ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_5 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 and not isNil(var_158_4) then
				if arg_155_1.var_.characterEffect10068ui_story and not isNil(var_158_4) then
					arg_155_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_5)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect10068ui_story then
				arg_155_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_158_6 = 0
			local var_158_7 = 0.1

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(319871037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 4 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 4)

				if (4 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 4)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871037", "story_v_out_319871.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_319871", "319871037", "story_v_out_319871.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_319871", "319871037", "story_v_out_319871.awb")

						arg_155_1:RecordAudio("319871037", var_158_13)
						arg_155_1:RecordAudio("319871037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319871", "319871037", "story_v_out_319871.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319871", "319871037", "story_v_out_319871.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319871038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319871038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319871039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = arg_159_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) then
				if arg_159_1.var_.characterEffect1084ui_story and not isNil(arg_159_1.actors_["1084ui_story"]) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_162_1 = arg_159_1.actors_["1084ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_1.localPosition
			end

			local var_162_2 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 then
				var_162_1.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_2)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 then
				var_162_1.localPosition = Vector3.New(0, 100, 0)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			local var_162_3 = arg_159_1.actors_["10068ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10068ui_story = var_162_3.localPosition
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_4)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, 100, 0)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			local var_162_5 = 0
			local var_162_6 = 0.875

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(319871038).content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 35 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_7) / 35)

				if (35 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_7) / 35)) > 0 and var_162_6 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_10 and arg_159_1.time_ < var_162_5 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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
				actorName = "10068ui_story",
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
	Play319871039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319871039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319871040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.425

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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(319871039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 57 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 57)

				if (57 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 57)) > 0 and var_166_0 < var_166_3 then
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
	Play319871040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319871040
		arg_167_1.duration_ = 5.8

		local var_167_0 = {
			zh = 5.733,
			ja = 5.8
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
				arg_167_0:Play319871041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = arg_167_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).z)
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles = arg_167_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_167_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).z)
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles = arg_167_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_170_1 = arg_167_1.actors_["1084ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1084ui_story == nil then
				arg_167_1.var_.characterEffect1084ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1084ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1084ui_story then
				arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(319871040)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)

				if (32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871040", "story_v_out_319871.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871040", "story_v_out_319871.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_319871", "319871040", "story_v_out_319871.awb")

						arg_167_1:RecordAudio("319871040", var_170_11)
						arg_167_1:RecordAudio("319871040", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319871", "319871040", "story_v_out_319871.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319871", "319871040", "story_v_out_319871.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play319871041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319871041
		arg_171_1.duration_ = 6.2

		local var_171_0 = {
			zh = 4.166,
			ja = 6.2
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
				arg_171_0:Play319871042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = arg_171_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(arg_171_1.actors_["1084ui_story"]) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_174_2 = 0
			local var_174_3 = 0.5

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(319871041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 20 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 20)

				if (20 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 20)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871041", "story_v_out_319871.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_319871", "319871041", "story_v_out_319871.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_319871", "319871041", "story_v_out_319871.awb")

						arg_171_1:RecordAudio("319871041", var_174_9)
						arg_171_1:RecordAudio("319871041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319871", "319871041", "story_v_out_319871.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319871", "319871041", "story_v_out_319871.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319871042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319871042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319871043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = arg_175_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) then
				if arg_175_1.var_.characterEffect1084ui_story and not isNil(arg_175_1.actors_["1084ui_story"]) then
					arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) and arg_175_1.var_.characterEffect1084ui_story then
				arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_178_1 = arg_175_1.actors_["1084ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1084ui_story = var_178_1.localPosition
			end

			local var_178_2 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 then
				var_178_1.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_2)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 then
				var_178_1.localPosition = Vector3.New(0, 100, 0)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			local var_178_3 = 0
			local var_178_4 = 1.225

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_5 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319871042).content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 49 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 49)

				if (49 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 49)) > 0 and var_178_4 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_8 and arg_175_1.time_ < var_178_3 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play319871043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319871043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319871044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.5

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

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(319871043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 60 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 60)

				if (60 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 60)) > 0 and var_182_0 < var_182_3 then
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
	Play319871044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319871044
		arg_183_1.duration_ = 2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319871045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10068ui_story = arg_183_1.actors_["10068ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10068ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10068ui_story, Vector3.New(0, -0.75, -6.18), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).z)
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles = arg_183_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10068ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.18)
				arg_183_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).z)
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles = arg_183_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["10068ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10068ui_story == nil then
				arg_183_1.var_.characterEffect10068ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect10068ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10068ui_story then
				arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action4_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_4 = 0.433333333333333
			local var_186_5 = 0.075

			if 0.433333333333333 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_6 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_6:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:GetWordFromCfg(319871044)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 3 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_8) / 3)

				if (3 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_8) / 3)) > 0 and var_186_5 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10
					var_186_4 = var_186_4 + 0.3

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871044", "story_v_out_319871.awb") ~= 0 then
					local var_186_11 = manager.audio:GetVoiceLength("story_v_out_319871", "319871044", "story_v_out_319871.awb") / 1000

					if var_186_11 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_4
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_out_319871", "319871044", "story_v_out_319871.awb")

						arg_183_1:RecordAudio("319871044", var_186_12)
						arg_183_1:RecordAudio("319871044", var_186_12)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319871", "319871044", "story_v_out_319871.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319871", "319871044", "story_v_out_319871.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = var_186_4 + 0.3
			local var_186_14 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_13 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_13) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_13 + var_186_14 and arg_183_1.time_ < var_186_13 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play319871045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319871045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319871046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10068ui_story"]) and arg_189_1.var_.characterEffect10068ui_story == nil then
				arg_189_1.var_.characterEffect10068ui_story = arg_189_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10068ui_story"]) then
				if arg_189_1.var_.characterEffect10068ui_story and not isNil(arg_189_1.actors_["10068ui_story"]) then
					arg_189_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10068ui_story"]) and arg_189_1.var_.characterEffect10068ui_story then
				arg_189_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_192_1 = arg_189_1.actors_["10068ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10068ui_story = var_192_1.localPosition
			end

			local var_192_2 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 then
				var_192_1.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_2)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 then
				var_192_1.localPosition = Vector3.New(0, 100, 0)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles
			end

			local var_192_3 = 0
			local var_192_4 = 0.85

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(319871045).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 34 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 34)

				if (34 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 34)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play319871046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319871046
		arg_193_1.duration_ = 3.13

		local var_193_0 = {
			zh = 2.066,
			ja = 3.133
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
				arg_193_0:Play319871047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1084ui_story = arg_193_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_193_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1084ui_story"].transform.position).z)
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1084ui_story"].transform.localEulerAngles = arg_193_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1084ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
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

				local var_196_6 = arg_193_1:GetWordFromCfg(319871046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 9 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 9)

				if (9 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 9)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871046", "story_v_out_319871.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_319871", "319871046", "story_v_out_319871.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_319871", "319871046", "story_v_out_319871.awb")

						arg_193_1:RecordAudio("319871046", var_196_11)
						arg_193_1:RecordAudio("319871046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319871", "319871046", "story_v_out_319871.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319871", "319871046", "story_v_out_319871.awb")
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
	Play319871047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319871047
		arg_197_1.duration_ = 3.47

		local var_197_0 = {
			zh = 3.466,
			ja = 3
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
			arg_197_1.auto_ = false
		end

		function arg_197_1.playNext_(arg_199_0)
			arg_197_1.onStoryFinished_()
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_200_0 = 0
			local var_200_1 = 0.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(319871047)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 13 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 13)

				if (13 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 13)) > 0 and var_200_1 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319871", "319871047", "story_v_out_319871.awb") ~= 0 then
					local var_200_6 = manager.audio:GetVoiceLength("story_v_out_319871", "319871047", "story_v_out_319871.awb") / 1000

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end

					if var_200_2.prefab_name ~= "" and arg_197_1.actors_[var_200_2.prefab_name] ~= nil then
						local var_200_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_2.prefab_name].transform, "story_v_out_319871", "319871047", "story_v_out_319871.awb")

						arg_197_1:RecordAudio("319871047", var_200_7)
						arg_197_1:RecordAudio("319871047", var_200_7)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319871", "319871047", "story_v_out_319871.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319871", "319871047", "story_v_out_319871.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST71a",
		"TextureConfig/Background/ST72a"
	},
	voices = {
		"story_v_out_319871.awb"
	}
}
