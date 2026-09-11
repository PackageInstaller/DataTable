return {
	Play319731001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319731001
		arg_1_1.duration_ = 4.13

		local var_1_0 = {
			zh = 3.899999999999,
			ja = 4.133
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
				arg_1_0:Play319731002(arg_1_1)
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

			local var_4_9 = "10066ui_story"

			if arg_1_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10066ui_story"].transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.moveOldPos10066ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_1_1.time_ - 1.9) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.9 + var_4_14 and arg_1_1.time_ < 1.9 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.99, -5.83)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10066ui_story"]

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10066ui_story == nil then
				arg_1_1.var_.characterEffect10066ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10066ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.9 + var_4_16 and arg_1_1.time_ < 1.9 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10066ui_story then
				arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_130", "se_story_130_Fireworks", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 2
			local var_4_26 = 0.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(319731001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 2 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 2)

				if (2 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 2)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731001", "story_v_out_319731.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_319731", "319731001", "story_v_out_319731.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_319731", "319731001", "story_v_out_319731.awb")

						arg_1_1:RecordAudio("319731001", var_4_33)
						arg_1_1:RecordAudio("319731001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319731", "319731001", "story_v_out_319731.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319731", "319731001", "story_v_out_319731.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319731002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319731002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319731003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10066ui_story"]) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = arg_9_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10066ui_story"]) then
				if arg_9_1.var_.characterEffect10066ui_story and not isNil(arg_9_1.actors_["10066ui_story"]) then
					arg_9_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10066ui_story"]) and arg_9_1.var_.characterEffect10066ui_story then
				arg_9_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.65

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319731002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 66 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 66)

				if (66 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 66)) > 0 and var_12_2 < var_12_5 then
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
	Play319731003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319731003
		arg_13_1.duration_ = 5.53

		local var_13_0 = {
			zh = 3.433,
			ja = 5.533
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
				arg_13_0:Play319731004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10066ui_story = arg_13_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).z)
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles = arg_13_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_13_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10066ui_story"].transform.position).z)
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10066ui_story"].transform.localEulerAngles = arg_13_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["10066ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10066ui_story == nil then
				arg_13_1.var_.characterEffect10066ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10066ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10066ui_story then
				arg_13_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action464")
			end

			local var_16_4 = 0
			local var_16_5 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(319731003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 11 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 11)

				if (11 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 11)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731003", "story_v_out_319731.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731003", "story_v_out_319731.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_319731", "319731003", "story_v_out_319731.awb")

						arg_13_1:RecordAudio("319731003", var_16_11)
						arg_13_1:RecordAudio("319731003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319731", "319731003", "story_v_out_319731.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319731", "319731003", "story_v_out_319731.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play319731004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319731004
		arg_17_1.duration_ = 7.9

		local var_17_0 = {
			zh = 4.133,
			ja = 7.9
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
				arg_17_0:Play319731005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1084ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1084ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1084ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1084ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1084ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1084ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_20_8 = arg_17_1.actors_["10066ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10066ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			local var_20_10 = arg_17_1.actors_["10066ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect10066ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10066ui_story then
				arg_17_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_20_12 = 0
			local var_20_13 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
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

				local var_20_14 = arg_17_1:GetWordFromCfg(319731004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 19 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 19)

				if (19 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 19)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731004", "story_v_out_319731.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_319731", "319731004", "story_v_out_319731.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_319731", "319731004", "story_v_out_319731.awb")

						arg_17_1:RecordAudio("319731004", var_20_19)
						arg_17_1:RecordAudio("319731004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319731", "319731004", "story_v_out_319731.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319731", "319731004", "story_v_out_319731.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play319731005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319731005
		arg_21_1.duration_ = 5.37

		local var_21_0 = {
			zh = 4.633,
			ja = 5.366
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
				arg_21_0:Play319731006(arg_21_1)
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

			local var_24_1 = arg_21_1.actors_["10066ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10066ui_story then
				arg_21_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319731005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 15 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 15)

				if (15 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 15)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731005", "story_v_out_319731.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731005", "story_v_out_319731.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319731", "319731005", "story_v_out_319731.awb")

						arg_21_1:RecordAudio("319731005", var_24_11)
						arg_21_1:RecordAudio("319731005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319731", "319731005", "story_v_out_319731.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319731", "319731005", "story_v_out_319731.awb")
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
	Play319731006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319731006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319731007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10066ui_story"]) and arg_25_1.var_.characterEffect10066ui_story == nil then
				arg_25_1.var_.characterEffect10066ui_story = arg_25_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10066ui_story"]) then
				if arg_25_1.var_.characterEffect10066ui_story and not isNil(arg_25_1.actors_["10066ui_story"]) then
					arg_25_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10066ui_story"]) and arg_25_1.var_.characterEffect10066ui_story then
				arg_25_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_28_1 = arg_25_1.actors_["10066ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10066ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_2)
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

			local var_28_3 = arg_25_1.actors_["1084ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, 100, 0)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = 0
			local var_28_6 = 1.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319731006).content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 55 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 55)

				if (55 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 55)) > 0 and var_28_6 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_10 and arg_25_1.time_ < var_28_5 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319731007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319731007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319731008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.STblack == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_32_0.name = "STblack"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.STblack = var_32_0
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.STblack

				arg_29_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "STblack" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_4 = arg_29_1.fswbg_.transform:Find("textbox/adapt/content") or arg_29_1.fswbg_.transform:Find("textbox/content")
				local var_32_5 = arg_29_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_32_6 = var_32_4:GetComponent("RectTransform")

				var_32_4:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_32_6.offsetMin = Vector2.New(0, 0)
				var_32_6.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.fswbg_:SetActive(true)
				arg_29_1.dialog_:SetActive(false)

				arg_29_1.fswtw_.percent = 0
				arg_29_1.fswt_.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319731007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.fswt_)

				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_29_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_29_1.fswtw_:SetDirty()

				arg_29_1.typewritterCharCountI18N = 0

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_7 = 0.8

			if 0.8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.var_.oldValueTypewriter = arg_29_1.fswtw_.percent

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_8 = 7
			local var_32_9 = 0.466666666666667
			local var_32_10, var_32_11 = arg_29_1:GetPercentByPara(arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319731007).content), 1)

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				local var_32_12 = var_32_8 <= 0 and var_32_9 or var_32_9 * ((var_32_11 - arg_29_1.typewritterCharCountI18N) / var_32_8)

				if (var_32_8 <= 0 and var_32_9 or var_32_9 * ((var_32_11 - arg_29_1.typewritterCharCountI18N) / var_32_8)) > 0 and var_32_9 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_7
					end
				end
			end

			local var_32_13 = math.max(0.466666666666667, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_13 then
				arg_29_1.fswtw_.percent = Mathf.Lerp(arg_29_1.var_.oldValueTypewriter, var_32_10, (arg_29_1.time_ - var_32_7) / var_32_13)
				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_29_1.fswtw_:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_13 and arg_29_1.time_ < var_32_7 + var_32_13 + arg_32_0 then
				arg_29_1.fswtw_.percent = var_32_10

				arg_29_1.fswtw_:SetDirty()
				arg_29_1:ShowNextGo(true)

				arg_29_1.typewritterCharCountI18N = var_32_11
			end

			local var_32_14 = 0.8
			local var_32_15 = manager.audio:GetVoiceLength("story_v_out_319731", "319731007", "story_v_out_319731.awb") / 1000

			if var_32_15 > 0 and 2.1 < var_32_15 and var_32_15 + var_32_14 > arg_29_1.duration_ then
				arg_29_1.duration_ = var_32_15 + var_32_14
			end

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:AudioAction("play", "voice", "story_v_out_319731", "319731007", "story_v_out_319731.awb")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.cswbg_:SetActive(true)

				local var_32_17 = arg_29_1.cswt_:GetComponent("RectTransform")

				arg_29_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_32_17.offsetMin = Vector2.New(410, 330)
				var_32_17.offsetMax = Vector2.New(-400, -175)
				arg_29_1.cswt_.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(419047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.cswt_)

				arg_29_1.cswt_.fontSize = 180
				arg_29_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_29_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_29_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319731008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319731008
		arg_33_1.duration_ = 1.33

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319731009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.fswbg_:SetActive(true)
				arg_33_1.dialog_:SetActive(false)

				arg_33_1.fswtw_.percent = 0
				arg_33_1.fswt_.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319731008).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.fswt_)

				arg_33_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_33_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_33_1.fswtw_:SetDirty()

				arg_33_1.typewritterCharCountI18N = 0

				SetActive(arg_33_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_33_1:ShowNextGo(false)
			end

			local var_36_0 = 0.433333333333333

			if 0.433333333333333 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.var_.oldValueTypewriter = arg_33_1.fswtw_.percent

				SetActive(arg_33_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_33_1:ShowNextGo(false)
			end

			local var_36_1 = 2
			local var_36_2 = 0.133333333333333
			local var_36_3, var_36_4 = arg_33_1:GetPercentByPara(arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319731008).content), 1)

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				local var_36_5 = var_36_1 <= 0 and var_36_2 or var_36_2 * ((var_36_4 - arg_33_1.typewritterCharCountI18N) / var_36_1)

				if (var_36_1 <= 0 and var_36_2 or var_36_2 * ((var_36_4 - arg_33_1.typewritterCharCountI18N) / var_36_1)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end
			end

			local var_36_6 = math.max(0.133333333333333, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_6 then
				arg_33_1.fswtw_.percent = Mathf.Lerp(arg_33_1.var_.oldValueTypewriter, var_36_3, (arg_33_1.time_ - var_36_0) / var_36_6)
				arg_33_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_33_1.fswtw_:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_6 and arg_33_1.time_ < var_36_0 + var_36_6 + arg_36_0 then
				arg_33_1.fswtw_.percent = var_36_3

				arg_33_1.fswtw_:SetDirty()
				arg_33_1:ShowNextGo(true)

				arg_33_1.typewritterCharCountI18N = var_36_4
			end

			local var_36_7 = 0.433333333333333
			local var_36_8 = manager.audio:GetVoiceLength("story_v_out_319731", "319731008", "story_v_out_319731.awb") / 1000

			if var_36_8 > 0 and 0.9 < var_36_8 and var_36_8 + var_36_7 > arg_33_1.duration_ then
				arg_33_1.duration_ = var_36_8 + var_36_7
			end

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1:AudioAction("play", "voice", "story_v_out_319731", "319731008", "story_v_out_319731.awb")
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319731009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319731009
		arg_37_1.duration_ = 7.77

		local var_37_0 = {
			zh = 4.999999999999,
			ja = 7.766
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
				arg_37_0:Play319731010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = arg_37_1.bgs_.ST74

				arg_37_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_1 = var_40_0:GetComponent("SpriteRenderer")

				if var_40_1 and var_40_1.sprite then
					local var_40_2 = 2 * (var_40_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_0.transform.localScale = Vector3.New(var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST74" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_3 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_4 = 2

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_4 then
				local var_40_5 = Color.New(0, 0, 0)

				var_40_5.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_3) / var_40_4)
				arg_37_1.mask_.color = var_40_5
			end

			if arg_37_1.time_ >= var_40_3 + var_40_4 and arg_37_1.time_ < var_40_3 + var_40_4 + arg_40_0 then
				local var_40_6 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_6.a = 0
				arg_37_1.mask_.color = var_40_6
			end

			local var_40_7 = arg_37_1.actors_["1084ui_story"].transform

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = var_40_7.localPosition

				arg_37_1:ShowWeapon(arg_37_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_40_8 = 0.001

			if 1.86666666666667 <= arg_37_1.time_ and arg_37_1.time_ < 1.86666666666667 + var_40_8 then
				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_37_1.time_ - 1.86666666666667) / var_40_8)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			if arg_37_1.time_ >= 1.86666666666667 + var_40_8 and arg_37_1.time_ < 1.86666666666667 + var_40_8 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0, -0.97, -6)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			local var_40_9 = arg_37_1.actors_["1084ui_story"]

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_10 = 0.200000002980232

			if 1.86666666666667 <= arg_37_1.time_ and arg_37_1.time_ < 1.86666666666667 + var_40_10 and not isNil(var_40_9) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 1.86666666666667 + var_40_10 and arg_37_1.time_ < 1.86666666666667 + var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_12 = "4040ui_story"

			if arg_37_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_40_13 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_37_1.stage_.transform)

				var_40_13.name = var_40_12
				var_40_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_[var_40_12] = var_40_13

				local var_40_14 = var_40_13:GetComponentInChildren(typeof(CharacterEffect))

				var_40_14.enabled = true

				local var_40_15 = GameObjectTools.GetOrAddComponent(var_40_13, typeof(DynamicBoneHelper))

				if var_40_15 then
					var_40_15:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_14.transform, false)

				arg_37_1.var_[var_40_12 .. "Animator"] = var_40_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_[var_40_12 .. "Animator"].applyRootMotion = true
				arg_37_1.var_[var_40_12 .. "LipSync"] = var_40_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_16 = arg_37_1.actors_["4040ui_story"].transform

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = var_40_16.localPosition
			end

			local var_40_17 = 0.001

			if 1.86666666666667 <= arg_37_1.time_ and arg_37_1.time_ < 1.86666666666667 + var_40_17 then
				var_40_16.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 1.86666666666667) / var_40_17)
				var_40_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_16.position).x, (manager.ui.mainCamera.transform.position - var_40_16.position).y, (manager.ui.mainCamera.transform.position - var_40_16.position).z)
				var_40_16.localEulerAngles.z = 0
				var_40_16.localEulerAngles.x = 0
				var_40_16.localEulerAngles = var_40_16.localEulerAngles
			end

			if arg_37_1.time_ >= 1.86666666666667 + var_40_17 and arg_37_1.time_ < 1.86666666666667 + var_40_17 + arg_40_0 then
				var_40_16.localPosition = Vector3.New(0, 100, 0)
				var_40_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_16.position).x, (manager.ui.mainCamera.transform.position - var_40_16.position).y, (manager.ui.mainCamera.transform.position - var_40_16.position).z)
				var_40_16.localEulerAngles.z = 0
				var_40_16.localEulerAngles.x = 0
				var_40_16.localEulerAngles = var_40_16.localEulerAngles
			end

			local var_40_18 = arg_37_1.actors_["4040ui_story"]

			if 1.86666666666667 < arg_37_1.time_ and arg_37_1.time_ <= 1.86666666666667 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_19 = 0.200000002980232

			if 1.86666666666667 <= arg_37_1.time_ and arg_37_1.time_ < 1.86666666666667 + var_40_19 and not isNil(var_40_18) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_18) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_37_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 1.86666666666667) / var_40_19)
				end
			end

			if arg_37_1.time_ >= 1.86666666666667 + var_40_19 and arg_37_1.time_ < 1.86666666666667 + var_40_19 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_37_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.fswbg_:SetActive(false)
				arg_37_1.dialog_:SetActive(false)
				SetActive(arg_37_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_37_1:ShowNextGo(false)
			end

			if 0.0166666666666666 < arg_37_1.time_ and arg_37_1.time_ <= 0.0166666666666666 + arg_40_0 then
				arg_37_1.fswbg_:SetActive(false)
				arg_37_1.dialog_:SetActive(false)
				SetActive(arg_37_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_37_1:ShowNextGo(false)
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.cswbg_:SetActive(false)
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_20 = 2
			local var_40_21 = 0.3

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_22 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_22:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_23 = arg_37_1:GetWordFromCfg(319731009)
				local var_40_24 = arg_37_1:FormatText(var_40_23.content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 12 <= 0 and var_40_21 or var_40_21 * (utf8.len(var_40_24) / 12)

				if (12 <= 0 and var_40_21 or var_40_21 * (utf8.len(var_40_24) / 12)) > 0 and var_40_21 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26
					var_40_20 = var_40_20 + 0.3

					if var_40_26 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_20
					end
				end

				arg_37_1.text_.text = var_40_24
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731009", "story_v_out_319731.awb") ~= 0 then
					local var_40_27 = manager.audio:GetVoiceLength("story_v_out_319731", "319731009", "story_v_out_319731.awb") / 1000

					if var_40_27 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_20
					end

					if var_40_23.prefab_name ~= "" and arg_37_1.actors_[var_40_23.prefab_name] ~= nil then
						local var_40_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_23.prefab_name].transform, "story_v_out_319731", "319731009", "story_v_out_319731.awb")

						arg_37_1:RecordAudio("319731009", var_40_28)
						arg_37_1:RecordAudio("319731009", var_40_28)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319731", "319731009", "story_v_out_319731.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319731", "319731009", "story_v_out_319731.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = var_40_20 + 0.3
			local var_40_30 = math.max(var_40_21, arg_37_1.talkMaxDuration)

			if var_40_20 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_29 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_29) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_29 + var_40_30 and arg_37_1.time_ < var_40_29 + var_40_30 + arg_40_0 then
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
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319731010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319731010
		arg_43_1.duration_ = 7.63

		local var_43_0 = {
			zh = 5.5,
			ja = 7.633
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
				arg_43_0:Play319731011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos4040ui_story = arg_43_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).z)
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles = arg_43_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_43_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["4040ui_story"].transform.position).z)
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["4040ui_story"].transform.localEulerAngles = arg_43_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["4040ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect4040ui_story == nil then
				arg_43_1.var_.characterEffect4040ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect4040ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect4040ui_story then
				arg_43_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_4 = arg_43_1.actors_["1084ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1084ui_story = var_46_4.localPosition
			end

			local var_46_5 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				var_46_4.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_43_1.time_ - 0) / var_46_5)
				var_46_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_4.position).x, (manager.ui.mainCamera.transform.position - var_46_4.position).y, (manager.ui.mainCamera.transform.position - var_46_4.position).z)
				var_46_4.localEulerAngles.z = 0
				var_46_4.localEulerAngles.x = 0
				var_46_4.localEulerAngles = var_46_4.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				var_46_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_46_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_4.position).x, (manager.ui.mainCamera.transform.position - var_46_4.position).y, (manager.ui.mainCamera.transform.position - var_46_4.position).z)
				var_46_4.localEulerAngles.z = 0
				var_46_4.localEulerAngles.x = 0
				var_46_4.localEulerAngles = var_46_4.localEulerAngles
			end

			local var_46_6 = arg_43_1.actors_["1084ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = var_46_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_7 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 and not isNil(var_46_6) then
				if arg_43_1.var_.characterEffect1084ui_story and not isNil(var_46_6) then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_7)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_46_8 = 0
			local var_46_9 = 0.65

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(319731010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 26 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 26)

				if (26 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 26)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731010", "story_v_out_319731.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_319731", "319731010", "story_v_out_319731.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_319731", "319731010", "story_v_out_319731.awb")

						arg_43_1:RecordAudio("319731010", var_46_15)
						arg_43_1:RecordAudio("319731010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319731", "319731010", "story_v_out_319731.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319731", "319731010", "story_v_out_319731.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play319731011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319731011
		arg_47_1.duration_ = 8.2

		local var_47_0 = {
			zh = 4.4,
			ja = 8.2
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
				arg_47_0:Play319731012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["4040ui_story"]) and arg_47_1.var_.characterEffect4040ui_story == nil then
				arg_47_1.var_.characterEffect4040ui_story = arg_47_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["4040ui_story"]) then
				if arg_47_1.var_.characterEffect4040ui_story and not isNil(arg_47_1.actors_["4040ui_story"]) then
					arg_47_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_47_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["4040ui_story"]) and arg_47_1.var_.characterEffect4040ui_story then
				arg_47_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_47_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_50_1 = arg_47_1.actors_["1084ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1084ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1084ui_story then
				arg_47_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_50_4 = 0
			local var_50_5 = 0.6

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(319731011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 24 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 24)

				if (24 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 24)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731011", "story_v_out_319731.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731011", "story_v_out_319731.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_319731", "319731011", "story_v_out_319731.awb")

						arg_47_1:RecordAudio("319731011", var_50_11)
						arg_47_1:RecordAudio("319731011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319731", "319731011", "story_v_out_319731.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319731", "319731011", "story_v_out_319731.awb")
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
	Play319731012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319731012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319731013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1084ui_story"]) and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = arg_51_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1084ui_story"]) then
				if arg_51_1.var_.characterEffect1084ui_story and not isNil(arg_51_1.actors_["1084ui_story"]) then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1084ui_story"]) and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 1

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

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319731012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 40 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 40)

				if (40 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 40)) > 0 and var_54_2 < var_54_5 then
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
	Play319731013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319731013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319731014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.625

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

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(319731013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 25)

				if (25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 25)) > 0 and var_58_0 < var_58_3 then
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
	Play319731014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319731014
		arg_59_1.duration_ = 9.9

		local var_59_0 = {
			zh = 9.4,
			ja = 9.9
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
				arg_59_0:Play319731015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos4040ui_story = arg_59_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).z)
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles = arg_59_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_59_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).z)
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles = arg_59_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["4040ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect4040ui_story == nil then
				arg_59_1.var_.characterEffect4040ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect4040ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect4040ui_story then
				arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 1.075

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(319731014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 43 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 43)

				if (43 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 43)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731014", "story_v_out_319731.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731014", "story_v_out_319731.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_319731", "319731014", "story_v_out_319731.awb")

						arg_59_1:RecordAudio("319731014", var_62_11)
						arg_59_1:RecordAudio("319731014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319731", "319731014", "story_v_out_319731.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319731", "319731014", "story_v_out_319731.awb")
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
				actorName = "4040ui_story",
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
	Play319731015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319731015
		arg_63_1.duration_ = 12.03

		local var_63_0 = {
			zh = 8.633,
			ja = 12.033
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
				arg_63_0:Play319731016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.925

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(319731015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 37 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 37)

				if (37 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 37)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731015", "story_v_out_319731.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_319731", "319731015", "story_v_out_319731.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_319731", "319731015", "story_v_out_319731.awb")

						arg_63_1:RecordAudio("319731015", var_66_6)
						arg_63_1:RecordAudio("319731015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319731", "319731015", "story_v_out_319731.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319731", "319731015", "story_v_out_319731.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319731016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319731016
		arg_67_1.duration_ = 5.1

		local var_67_0 = {
			zh = 1.999999999999,
			ja = 5.1
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
				arg_67_0:Play319731017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["4040ui_story"]) and arg_67_1.var_.characterEffect4040ui_story == nil then
				arg_67_1.var_.characterEffect4040ui_story = arg_67_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["4040ui_story"]) then
				if arg_67_1.var_.characterEffect4040ui_story and not isNil(arg_67_1.actors_["4040ui_story"]) then
					arg_67_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_67_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["4040ui_story"]) and arg_67_1.var_.characterEffect4040ui_story then
				arg_67_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_67_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_70_1 = arg_67_1.actors_["1084ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_4 = 0
			local var_70_5 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(319731016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 9 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 9)

				if (9 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 9)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731016", "story_v_out_319731.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731016", "story_v_out_319731.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_319731", "319731016", "story_v_out_319731.awb")

						arg_67_1:RecordAudio("319731016", var_70_11)
						arg_67_1:RecordAudio("319731016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319731", "319731016", "story_v_out_319731.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319731", "319731016", "story_v_out_319731.awb")
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
	Play319731017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319731017
		arg_71_1.duration_ = 3.8

		local var_71_0 = {
			zh = 2.166,
			ja = 3.8
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
				arg_71_0:Play319731018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["4040ui_story"]) and arg_71_1.var_.characterEffect4040ui_story == nil then
				arg_71_1.var_.characterEffect4040ui_story = arg_71_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["4040ui_story"]) then
				if arg_71_1.var_.characterEffect4040ui_story and not isNil(arg_71_1.actors_["4040ui_story"]) then
					arg_71_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["4040ui_story"]) and arg_71_1.var_.characterEffect4040ui_story then
				arg_71_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_74_2 = arg_71_1.actors_["1084ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(319731017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 8 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 8)

				if (8 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 8)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731017", "story_v_out_319731.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731017", "story_v_out_319731.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_319731", "319731017", "story_v_out_319731.awb")

						arg_71_1:RecordAudio("319731017", var_74_11)
						arg_71_1:RecordAudio("319731017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319731", "319731017", "story_v_out_319731.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319731", "319731017", "story_v_out_319731.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319731018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319731018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319731019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["4040ui_story"]) and arg_75_1.var_.characterEffect4040ui_story == nil then
				arg_75_1.var_.characterEffect4040ui_story = arg_75_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["4040ui_story"]) then
				if arg_75_1.var_.characterEffect4040ui_story and not isNil(arg_75_1.actors_["4040ui_story"]) then
					arg_75_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_75_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["4040ui_story"]) and arg_75_1.var_.characterEffect4040ui_story then
				arg_75_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_75_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_1 = 0
			local var_78_2 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(319731018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 27 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 27)

				if (27 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 27)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319731019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319731019
		arg_79_1.duration_ = 2.87

		local var_79_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_79_0:Play319731020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["4040ui_story"]) and arg_79_1.var_.characterEffect4040ui_story == nil then
				arg_79_1.var_.characterEffect4040ui_story = arg_79_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["4040ui_story"]) then
				if arg_79_1.var_.characterEffect4040ui_story and not isNil(arg_79_1.actors_["4040ui_story"]) then
					arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["4040ui_story"]) and arg_79_1.var_.characterEffect4040ui_story then
				arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_2 = 0
			local var_82_3 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(319731019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 8 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 8)

				if (8 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 8)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731019", "story_v_out_319731.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_319731", "319731019", "story_v_out_319731.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_319731", "319731019", "story_v_out_319731.awb")

						arg_79_1:RecordAudio("319731019", var_82_9)
						arg_79_1:RecordAudio("319731019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319731", "319731019", "story_v_out_319731.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319731", "319731019", "story_v_out_319731.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319731020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319731020
		arg_83_1.duration_ = 2.57

		local var_83_0 = {
			zh = 2.566,
			ja = 2.233
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
				arg_83_0:Play319731021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1084ui_story = arg_83_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).z)
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles = arg_83_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_83_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).z)
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles = arg_83_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["4040ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect4040ui_story == nil then
				arg_83_1.var_.characterEffect4040ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect4040ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_83_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect4040ui_story then
				arg_83_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_83_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_86_3 = arg_83_1.actors_["1084ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_3) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_86_6 = 0
			local var_86_7 = 0.3

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(319731020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 12 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 12)

				if (12 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 12)) > 0 and var_86_7 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731020", "story_v_out_319731.awb") ~= 0 then
					local var_86_12 = manager.audio:GetVoiceLength("story_v_out_319731", "319731020", "story_v_out_319731.awb") / 1000

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_out_319731", "319731020", "story_v_out_319731.awb")

						arg_83_1:RecordAudio("319731020", var_86_13)
						arg_83_1:RecordAudio("319731020", var_86_13)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319731", "319731020", "story_v_out_319731.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319731", "319731020", "story_v_out_319731.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play319731021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319731021
		arg_87_1.duration_ = 6.3

		local var_87_0 = {
			zh = 2.633,
			ja = 6.3
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
				arg_87_0:Play319731022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["4040ui_story"]) and arg_87_1.var_.characterEffect4040ui_story == nil then
				arg_87_1.var_.characterEffect4040ui_story = arg_87_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["4040ui_story"]) then
				if arg_87_1.var_.characterEffect4040ui_story and not isNil(arg_87_1.actors_["4040ui_story"]) then
					arg_87_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["4040ui_story"]) and arg_87_1.var_.characterEffect4040ui_story then
				arg_87_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_90_2 = arg_87_1.actors_["1084ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_3)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1084ui_story then
				arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_90_4 = 0
			local var_90_5 = 0.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(319731021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 9 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 9)

				if (9 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 9)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731021", "story_v_out_319731.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731021", "story_v_out_319731.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_319731", "319731021", "story_v_out_319731.awb")

						arg_87_1:RecordAudio("319731021", var_90_11)
						arg_87_1:RecordAudio("319731021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319731", "319731021", "story_v_out_319731.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319731", "319731021", "story_v_out_319731.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play319731022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319731022
		arg_91_1.duration_ = 5.03

		local var_91_0 = {
			zh = 5.033,
			ja = 4.533
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
				arg_91_0:Play319731023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["4040ui_story"]) and arg_91_1.var_.characterEffect4040ui_story == nil then
				arg_91_1.var_.characterEffect4040ui_story = arg_91_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["4040ui_story"]) then
				if arg_91_1.var_.characterEffect4040ui_story and not isNil(arg_91_1.actors_["4040ui_story"]) then
					arg_91_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_91_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["4040ui_story"]) and arg_91_1.var_.characterEffect4040ui_story then
				arg_91_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_91_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_94_1 = arg_91_1.actors_["1084ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1084ui_story == nil then
				arg_91_1.var_.characterEffect1084ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1084ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1084ui_story then
				arg_91_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_94_4 = 0
			local var_94_5 = 0.6

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(319731022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 24 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 24)

				if (24 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 24)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731022", "story_v_out_319731.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731022", "story_v_out_319731.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_319731", "319731022", "story_v_out_319731.awb")

						arg_91_1:RecordAudio("319731022", var_94_11)
						arg_91_1:RecordAudio("319731022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_319731", "319731022", "story_v_out_319731.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_319731", "319731022", "story_v_out_319731.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319731023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319731023
		arg_95_1.duration_ = 4.8

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319731024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["4040ui_story"]) and arg_95_1.var_.characterEffect4040ui_story == nil then
				arg_95_1.var_.characterEffect4040ui_story = arg_95_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["4040ui_story"]) then
				if arg_95_1.var_.characterEffect4040ui_story and not isNil(arg_95_1.actors_["4040ui_story"]) then
					arg_95_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["4040ui_story"]) and arg_95_1.var_.characterEffect4040ui_story then
				arg_95_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_98_2 = arg_95_1.actors_["1084ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1084ui_story == nil then
				arg_95_1.var_.characterEffect1084ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.characterEffect1084ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_3)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1084ui_story then
				arg_95_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_98_4 = 0
			local var_98_5 = 0.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(319731023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 19 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 19)

				if (19 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 19)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731023", "story_v_out_319731.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731023", "story_v_out_319731.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_319731", "319731023", "story_v_out_319731.awb")

						arg_95_1:RecordAudio("319731023", var_98_11)
						arg_95_1:RecordAudio("319731023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_319731", "319731023", "story_v_out_319731.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_319731", "319731023", "story_v_out_319731.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319731024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319731024
		arg_99_1.duration_ = 3.37

		local var_99_0 = {
			zh = 2.8,
			ja = 3.366
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
				arg_99_0:Play319731025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos4040ui_story = arg_99_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).z)
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles = arg_99_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_99_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["4040ui_story"].transform.position).z)
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["4040ui_story"].transform.localEulerAngles = arg_99_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["4040ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect4040ui_story == nil then
				arg_99_1.var_.characterEffect4040ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect4040ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_99_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect4040ui_story then
				arg_99_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_99_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_102_3 = arg_99_1.actors_["1084ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_4 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 and not isNil(var_102_3) then
				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_3) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_6 = 0
			local var_102_7 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(319731024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 10 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 10)

				if (10 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 10)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731024", "story_v_out_319731.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_319731", "319731024", "story_v_out_319731.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_319731", "319731024", "story_v_out_319731.awb")

						arg_99_1:RecordAudio("319731024", var_102_13)
						arg_99_1:RecordAudio("319731024", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319731", "319731024", "story_v_out_319731.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319731", "319731024", "story_v_out_319731.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play319731025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319731025
		arg_103_1.duration_ = 2.37

		local var_103_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_103_0:Play319731026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["4040ui_story"]) and arg_103_1.var_.characterEffect4040ui_story == nil then
				arg_103_1.var_.characterEffect4040ui_story = arg_103_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["4040ui_story"]) then
				if arg_103_1.var_.characterEffect4040ui_story and not isNil(arg_103_1.actors_["4040ui_story"]) then
					arg_103_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["4040ui_story"]) and arg_103_1.var_.characterEffect4040ui_story then
				arg_103_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_106_2 = arg_103_1.actors_["1084ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_2) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_3)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.1

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(319731025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 4 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 4)

				if (4 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 4)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731025", "story_v_out_319731.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731025", "story_v_out_319731.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_319731", "319731025", "story_v_out_319731.awb")

						arg_103_1:RecordAudio("319731025", var_106_11)
						arg_103_1:RecordAudio("319731025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_319731", "319731025", "story_v_out_319731.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_319731", "319731025", "story_v_out_319731.awb")
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
	Play319731026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319731026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319731027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["4040ui_story"]) and arg_107_1.var_.characterEffect4040ui_story == nil then
				arg_107_1.var_.characterEffect4040ui_story = arg_107_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["4040ui_story"]) then
				if arg_107_1.var_.characterEffect4040ui_story and not isNil(arg_107_1.actors_["4040ui_story"]) then
					arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_107_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["4040ui_story"]) and arg_107_1.var_.characterEffect4040ui_story then
				arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_107_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.875

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319731026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 35 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 35)

				if (35 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 35)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319731027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319731027
		arg_111_1.duration_ = 6.4

		local var_111_0 = {
			zh = 6.4,
			ja = 6.166
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
				arg_111_0:Play319731028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["4040ui_story"]) and arg_111_1.var_.characterEffect4040ui_story == nil then
				arg_111_1.var_.characterEffect4040ui_story = arg_111_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["4040ui_story"]) then
				if arg_111_1.var_.characterEffect4040ui_story and not isNil(arg_111_1.actors_["4040ui_story"]) then
					arg_111_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["4040ui_story"]) and arg_111_1.var_.characterEffect4040ui_story then
				arg_111_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_114_2 = 0
			local var_114_3 = 0.8

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(319731027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 32 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 32)

				if (32 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 32)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731027", "story_v_out_319731.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_319731", "319731027", "story_v_out_319731.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_319731", "319731027", "story_v_out_319731.awb")

						arg_111_1:RecordAudio("319731027", var_114_9)
						arg_111_1:RecordAudio("319731027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319731", "319731027", "story_v_out_319731.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319731", "319731027", "story_v_out_319731.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319731028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319731028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319731029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = arg_115_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).z)
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles = arg_115_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1084ui_story"].transform.position).z)
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1084ui_story"].transform.localEulerAngles = arg_115_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_2)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_118_3 = arg_115_1.actors_["4040ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos4040ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, 100, 0)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = arg_115_1.actors_["4040ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_6 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.characterEffect4040ui_story and not isNil(var_118_5) then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_115_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_6)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_115_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_118_7 = 0
			local var_118_8 = 1.375

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_9 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(319731028).content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 55 <= 0 and var_118_8 or var_118_8 * (utf8.len(var_118_9) / 55)

				if (55 <= 0 and var_118_8 or var_118_8 * (utf8.len(var_118_9) / 55)) > 0 and var_118_8 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_7 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_7
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_8, arg_115_1.talkMaxDuration)

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_7) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_7 + var_118_12 and arg_115_1.time_ < var_118_7 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play319731029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319731029
		arg_119_1.duration_ = 9.37

		local var_119_0 = {
			zh = 4.199999999999,
			ja = 9.36600000298023
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
				arg_119_0:Play319731030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				local var_122_0 = arg_119_1.bgs_.ST74

				arg_119_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_1 = var_122_0:GetComponent("SpriteRenderer")

				if var_122_1 and var_122_1.sprite then
					local var_122_2 = 2 * (var_122_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_0.transform.localScale = Vector3.New(var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "ST74" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= 1 + arg_122_0 then
				local var_122_3 = arg_119_1.bgs_.ST74

				arg_119_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_4 = var_122_3:GetComponent("SpriteRenderer")

				if var_122_4 and var_122_4.sprite then
					local var_122_5 = 2 * (var_122_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_3.transform.localScale = Vector3.New(var_122_5 / var_122_4.sprite.bounds.size.y < var_122_5 * manager.ui.mainCameraCom_.aspect / var_122_4.sprite.bounds.size.x and var_122_5 * manager.ui.mainCameraCom_.aspect / var_122_4.sprite.bounds.size.x or var_122_5 / var_122_4.sprite.bounds.size.y, var_122_5 / var_122_4.sprite.bounds.size.y < var_122_5 * manager.ui.mainCameraCom_.aspect / var_122_4.sprite.bounds.size.x and var_122_5 * manager.ui.mainCameraCom_.aspect / var_122_4.sprite.bounds.size.x or var_122_5 / var_122_4.sprite.bounds.size.y, 0)
				end

				for iter_122_2, iter_122_3 in pairs(arg_119_1.bgs_) do
					if iter_122_2 ~= "ST74" then
						iter_122_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_6 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_6 + 0.3 and arg_119_1.time_ < var_122_6 + 0.3 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_7 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_8 = 1

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 then
				local var_122_9 = Color.New(0, 0, 0)

				var_122_9.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_7) / var_122_8)
				arg_119_1.mask_.color = var_122_9
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 then
				local var_122_10 = Color.New(0, 0, 0)

				var_122_10.a = 1
				arg_119_1.mask_.color = var_122_10
			end

			local var_122_11 = 1

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_12 = 1.33333333333333

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_12 then
				local var_122_13 = Color.New(0, 0, 0)

				var_122_13.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_11) / var_122_12)
				arg_119_1.mask_.color = var_122_13
			end

			if arg_119_1.time_ >= var_122_11 + var_122_12 and arg_119_1.time_ < var_122_11 + var_122_12 + arg_122_0 then
				local var_122_14 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_14.a = 0
				arg_119_1.mask_.color = var_122_14
			end

			local var_122_15 = arg_119_1.actors_["10066ui_story"].transform

			if 2.2 < arg_119_1.time_ and arg_119_1.time_ <= 2.2 + arg_122_0 then
				arg_119_1.var_.moveOldPos10066ui_story = var_122_15.localPosition
			end

			local var_122_16 = 0.001

			if 2.2 <= arg_119_1.time_ and arg_119_1.time_ < 2.2 + var_122_16 then
				var_122_15.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_119_1.time_ - 2.2) / var_122_16)
				var_122_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_15.position).x, (manager.ui.mainCamera.transform.position - var_122_15.position).y, (manager.ui.mainCamera.transform.position - var_122_15.position).z)
				var_122_15.localEulerAngles.z = 0
				var_122_15.localEulerAngles.x = 0
				var_122_15.localEulerAngles = var_122_15.localEulerAngles
			end

			if arg_119_1.time_ >= 2.2 + var_122_16 and arg_119_1.time_ < 2.2 + var_122_16 + arg_122_0 then
				var_122_15.localPosition = Vector3.New(0, -0.99, -5.83)
				var_122_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_15.position).x, (manager.ui.mainCamera.transform.position - var_122_15.position).y, (manager.ui.mainCamera.transform.position - var_122_15.position).z)
				var_122_15.localEulerAngles.z = 0
				var_122_15.localEulerAngles.x = 0
				var_122_15.localEulerAngles = var_122_15.localEulerAngles
			end

			local var_122_17 = arg_119_1.actors_["10066ui_story"]

			if 2.2 < arg_119_1.time_ and arg_119_1.time_ <= 2.2 + arg_122_0 and not isNil(var_122_17) and arg_119_1.var_.characterEffect10066ui_story == nil then
				arg_119_1.var_.characterEffect10066ui_story = var_122_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_18 = 0.200000002980232

			if 2.2 <= arg_119_1.time_ and arg_119_1.time_ < 2.2 + var_122_18 and not isNil(var_122_17) then
				if arg_119_1.var_.characterEffect10066ui_story and not isNil(var_122_17) then
					arg_119_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 2.2 + var_122_18 and arg_119_1.time_ < 2.2 + var_122_18 + arg_122_0 and not isNil(var_122_17) and arg_119_1.var_.characterEffect10066ui_story then
				arg_119_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 2.2 < arg_119_1.time_ and arg_119_1.time_ <= 2.2 + arg_122_0 then
				arg_119_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 2.2 < arg_119_1.time_ and arg_119_1.time_ <= 2.2 + arg_122_0 then
				arg_119_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_20 = 2.40000000298023
			local var_122_21 = 0.15

			if 2.40000000298023 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_22 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_22:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_23 = arg_119_1:GetWordFromCfg(319731029)
				local var_122_24 = arg_119_1:FormatText(var_122_23.content)

				arg_119_1.text_.text = var_122_24

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_26 = 6 <= 0 and var_122_21 or var_122_21 * (utf8.len(var_122_24) / 6)

				if (6 <= 0 and var_122_21 or var_122_21 * (utf8.len(var_122_24) / 6)) > 0 and var_122_21 < var_122_26 then
					arg_119_1.talkMaxDuration = var_122_26
					var_122_20 = var_122_20 + 0.3

					if var_122_26 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_26 + var_122_20
					end
				end

				arg_119_1.text_.text = var_122_24
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731029", "story_v_out_319731.awb") ~= 0 then
					local var_122_27 = manager.audio:GetVoiceLength("story_v_out_319731", "319731029", "story_v_out_319731.awb") / 1000

					if var_122_27 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_20
					end

					if var_122_23.prefab_name ~= "" and arg_119_1.actors_[var_122_23.prefab_name] ~= nil then
						local var_122_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_23.prefab_name].transform, "story_v_out_319731", "319731029", "story_v_out_319731.awb")

						arg_119_1:RecordAudio("319731029", var_122_28)
						arg_119_1:RecordAudio("319731029", var_122_28)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319731", "319731029", "story_v_out_319731.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319731", "319731029", "story_v_out_319731.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_29 = var_122_20 + 0.3
			local var_122_30 = math.max(var_122_21, arg_119_1.talkMaxDuration)

			if var_122_20 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_29 + var_122_30 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_29) / var_122_30

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_29 + var_122_30 and arg_119_1.time_ < var_122_29 + var_122_30 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play319731030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319731030
		arg_125_1.duration_ = 9.33

		local var_125_0 = {
			zh = 4.9,
			ja = 9.333
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
				arg_125_0:Play319731031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = arg_125_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
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
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = arg_125_1.actors_["10066ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10066ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["10066ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10066ui_story == nil then
				arg_125_1.var_.characterEffect10066ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect10066ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10066ui_story then
				arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_128_8 = 0
			local var_128_9 = 0.7

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
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

				local var_128_10 = arg_125_1:GetWordFromCfg(319731030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 28 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 28)

				if (28 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 28)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731030", "story_v_out_319731.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_319731", "319731030", "story_v_out_319731.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_319731", "319731030", "story_v_out_319731.awb")

						arg_125_1:RecordAudio("319731030", var_128_15)
						arg_125_1:RecordAudio("319731030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319731", "319731030", "story_v_out_319731.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319731", "319731030", "story_v_out_319731.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play319731031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319731031
		arg_129_1.duration_ = 14.93

		local var_129_0 = {
			zh = 11.8,
			ja = 14.933
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
				arg_129_0:Play319731032(arg_129_1)
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

			local var_132_1 = arg_129_1.actors_["10066ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10066ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10066ui_story then
				arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_132_4 = 0
			local var_132_5 = 1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(319731031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 40 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 40)

				if (40 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 40)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731031", "story_v_out_319731.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731031", "story_v_out_319731.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_319731", "319731031", "story_v_out_319731.awb")

						arg_129_1:RecordAudio("319731031", var_132_11)
						arg_129_1:RecordAudio("319731031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319731", "319731031", "story_v_out_319731.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319731", "319731031", "story_v_out_319731.awb")
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
	Play319731032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319731032
		arg_133_1.duration_ = 7.4

		local var_133_0 = {
			zh = 4.1,
			ja = 7.4
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
				arg_133_0:Play319731033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = arg_133_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(arg_133_1.actors_["1084ui_story"]) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["10066ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect10066ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10066ui_story then
				arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.55

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(319731032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 22 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 22)

				if (22 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 22)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731032", "story_v_out_319731.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731032", "story_v_out_319731.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_319731", "319731032", "story_v_out_319731.awb")

						arg_133_1:RecordAudio("319731032", var_136_11)
						arg_133_1:RecordAudio("319731032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319731", "319731032", "story_v_out_319731.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319731", "319731032", "story_v_out_319731.awb")
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
	Play319731033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319731033
		arg_137_1.duration_ = 11.73

		local var_137_0 = {
			zh = 9,
			ja = 11.733
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
				arg_137_0:Play319731034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10066ui_story = arg_137_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).z)
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles = arg_137_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_137_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10066ui_story"].transform.position).z)
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10066ui_story"].transform.localEulerAngles = arg_137_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10066ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10066ui_story == nil then
				arg_137_1.var_.characterEffect10066ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10066ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10066ui_story then
				arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = arg_137_1.actors_["1084ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_140_6 = 0
			local var_140_7 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
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

				local var_140_8 = arg_137_1:GetWordFromCfg(319731033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 33 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 33)

				if (33 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 33)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731033", "story_v_out_319731.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_319731", "319731033", "story_v_out_319731.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_319731", "319731033", "story_v_out_319731.awb")

						arg_137_1:RecordAudio("319731033", var_140_13)
						arg_137_1:RecordAudio("319731033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319731", "319731033", "story_v_out_319731.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319731", "319731033", "story_v_out_319731.awb")
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
				actorName = "10066ui_story",
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
	Play319731034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319731034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319731035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10066ui_story"]) and arg_141_1.var_.characterEffect10066ui_story == nil then
				arg_141_1.var_.characterEffect10066ui_story = arg_141_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10066ui_story"]) then
				if arg_141_1.var_.characterEffect10066ui_story and not isNil(arg_141_1.actors_["10066ui_story"]) then
					arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10066ui_story"]) and arg_141_1.var_.characterEffect10066ui_story then
				arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(319731034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 25 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 25)

				if (25 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 25)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319731035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319731035
		arg_145_1.duration_ = 13.53

		local var_145_0 = {
			zh = 6.1,
			ja = 13.533
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
				arg_145_0:Play319731036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1084ui_story = arg_145_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).z)
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles = arg_145_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_145_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1084ui_story"].transform.position).z)
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1084ui_story"].transform.localEulerAngles = arg_145_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1084ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(319731035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 26 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 26)

				if (26 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 26)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731035", "story_v_out_319731.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731035", "story_v_out_319731.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_319731", "319731035", "story_v_out_319731.awb")

						arg_145_1:RecordAudio("319731035", var_148_11)
						arg_145_1:RecordAudio("319731035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319731", "319731035", "story_v_out_319731.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319731", "319731035", "story_v_out_319731.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play319731036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319731036
		arg_149_1.duration_ = 1.67

		local var_149_0 = {
			zh = 1.233,
			ja = 1.666
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
				arg_149_0:Play319731037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1084ui_story"]) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = arg_149_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1084ui_story"]) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(arg_149_1.actors_["1084ui_story"]) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1084ui_story"]) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_152_1 = arg_149_1.actors_["10066ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10066ui_story == nil then
				arg_149_1.var_.characterEffect10066ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect10066ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10066ui_story then
				arg_149_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_152_4 = 0
			local var_152_5 = 0.075

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(319731036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 3 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 3)

				if (3 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 3)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731036", "story_v_out_319731.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731036", "story_v_out_319731.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_319731", "319731036", "story_v_out_319731.awb")

						arg_149_1:RecordAudio("319731036", var_152_11)
						arg_149_1:RecordAudio("319731036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319731", "319731036", "story_v_out_319731.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319731", "319731036", "story_v_out_319731.awb")
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
	Play319731037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319731037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play319731038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10066ui_story"]) and arg_153_1.var_.characterEffect10066ui_story == nil then
				arg_153_1.var_.characterEffect10066ui_story = arg_153_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10066ui_story"]) then
				if arg_153_1.var_.characterEffect10066ui_story and not isNil(arg_153_1.actors_["10066ui_story"]) then
					arg_153_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10066ui_story"]) and arg_153_1.var_.characterEffect10066ui_story then
				arg_153_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 1.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(319731037).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 53 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 53)

				if (53 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 53)) > 0 and var_156_2 < var_156_5 then
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
	Play319731038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319731038
		arg_157_1.duration_ = 6.8

		local var_157_0 = {
			zh = 6.3,
			ja = 6.8
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
				arg_157_0:Play319731039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1084ui_story"]) and arg_157_1.var_.characterEffect1084ui_story == nil then
				arg_157_1.var_.characterEffect1084ui_story = arg_157_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1084ui_story"]) then
				if arg_157_1.var_.characterEffect1084ui_story and not isNil(arg_157_1.actors_["1084ui_story"]) then
					arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1084ui_story"]) and arg_157_1.var_.characterEffect1084ui_story then
				arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_160_2 = 0
			local var_160_3 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(319731038)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 20 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 20)

				if (20 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 20)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731038", "story_v_out_319731.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_319731", "319731038", "story_v_out_319731.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_out_319731", "319731038", "story_v_out_319731.awb")

						arg_157_1:RecordAudio("319731038", var_160_9)
						arg_157_1:RecordAudio("319731038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319731", "319731038", "story_v_out_319731.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319731", "319731038", "story_v_out_319731.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319731039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319731039
		arg_161_1.duration_ = 7.77

		local var_161_0 = {
			zh = 6.3,
			ja = 7.766
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
				arg_161_0:Play319731040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0.666666666666667 < arg_161_1.time_ and arg_161_1.time_ <= 0.666666666666667 + arg_164_0 then
				arg_161_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_0 = 0
			local var_164_1 = 0.775

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(319731039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 31 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 31)

				if (31 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 31)) > 0 and var_164_1 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731039", "story_v_out_319731.awb") ~= 0 then
					local var_164_6 = manager.audio:GetVoiceLength("story_v_out_319731", "319731039", "story_v_out_319731.awb") / 1000

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end

					if var_164_2.prefab_name ~= "" and arg_161_1.actors_[var_164_2.prefab_name] ~= nil then
						local var_164_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_2.prefab_name].transform, "story_v_out_319731", "319731039", "story_v_out_319731.awb")

						arg_161_1:RecordAudio("319731039", var_164_7)
						arg_161_1:RecordAudio("319731039", var_164_7)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319731", "319731039", "story_v_out_319731.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319731", "319731039", "story_v_out_319731.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319731040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319731040
		arg_165_1.duration_ = 6.47

		local var_165_0 = {
			zh = 6.033,
			ja = 6.466
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
				arg_165_0:Play319731041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10066ui_story = arg_165_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).z)
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles = arg_165_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_165_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10066ui_story"].transform.position).z)
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10066ui_story"].transform.localEulerAngles = arg_165_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["10066ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10066ui_story == nil then
				arg_165_1.var_.characterEffect10066ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect10066ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10066ui_story then
				arg_165_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_168_4 = arg_165_1.actors_["1084ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_168_6 = 0
			local var_168_7 = 0.65

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(319731040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 26 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 26)

				if (26 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 26)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731040", "story_v_out_319731.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_319731", "319731040", "story_v_out_319731.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_319731", "319731040", "story_v_out_319731.awb")

						arg_165_1:RecordAudio("319731040", var_168_13)
						arg_165_1:RecordAudio("319731040", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319731", "319731040", "story_v_out_319731.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319731", "319731040", "story_v_out_319731.awb")
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
				actorName = "10066ui_story",
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
	Play319731041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319731041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319731042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) and arg_169_1.var_.characterEffect10066ui_story == nil then
				arg_169_1.var_.characterEffect10066ui_story = arg_169_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) then
				if arg_169_1.var_.characterEffect10066ui_story and not isNil(arg_169_1.actors_["10066ui_story"]) then
					arg_169_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10066ui_story"]) and arg_169_1.var_.characterEffect10066ui_story then
				arg_169_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 1.175

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(319731041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 47 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 47)

				if (47 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 47)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319731042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319731042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319731043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.825

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(319731042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 33 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 33)

				if (33 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 33)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319731043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319731043
		arg_177_1.duration_ = 3.23

		local var_177_0 = {
			zh = 2.966,
			ja = 3.233
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
			arg_177_1.auto_ = false
		end

		function arg_177_1.playNext_(arg_179_0)
			arg_177_1.onStoryFinished_()
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = arg_177_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1084ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(319731043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 16 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 16)

				if (16 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 16)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319731", "319731043", "story_v_out_319731.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_319731", "319731043", "story_v_out_319731.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_319731", "319731043", "story_v_out_319731.awb")

						arg_177_1:RecordAudio("319731043", var_180_11)
						arg_177_1:RecordAudio("319731043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319731", "319731043", "story_v_out_319731.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319731", "319731043", "story_v_out_319731.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319731.awb"
	}
}
