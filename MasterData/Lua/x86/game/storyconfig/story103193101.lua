return {
	Play319311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A08f")
				var_4_0.name = "A08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A08f

				arg_1_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A08f" then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319311001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 45 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 45)

				if (45 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 45)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319311002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 57 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 57)

				if (57 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 57)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319311003
		arg_13_1.duration_ = 6.13

		local var_13_0 = {
			zh = 4.166,
			ja = 6.133
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
				arg_13_0:Play319311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10079ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10079ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10079ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10079ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10079ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10079ui_story = var_16_3.localPosition

				arg_13_1:ShowWeapon(arg_13_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10079ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(319311003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 23 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 23)

				if (23 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 23)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311003", "story_v_out_319311.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311003", "story_v_out_319311.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_319311", "319311003", "story_v_out_319311.awb")

						arg_13_1:RecordAudio("319311003", var_16_15)
						arg_13_1:RecordAudio("319311003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319311", "319311003", "story_v_out_319311.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319311", "319311003", "story_v_out_319311.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319311004
		arg_17_1.duration_ = 6.7

		local var_17_0 = {
			zh = 6.033,
			ja = 6.7
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
				arg_17_0:Play319311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1095ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1095ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1095ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1095ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = arg_17_1.actors_["10079ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10079ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			local var_20_10 = arg_17_1.actors_["10079ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10079ui_story then
				arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_20_12 = 0
			local var_20_13 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
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

				local var_20_14 = arg_17_1:GetWordFromCfg(319311004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 28 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 28)

				if (28 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 28)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311004", "story_v_out_319311.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311004", "story_v_out_319311.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_319311", "319311004", "story_v_out_319311.awb")

						arg_17_1:RecordAudio("319311004", var_20_19)
						arg_17_1:RecordAudio("319311004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319311", "319311004", "story_v_out_319311.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319311", "319311004", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
	Play319311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319311005
		arg_21_1.duration_ = 1.43

		local var_21_0 = {
			zh = 1,
			ja = 1.433
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
				arg_21_0:Play319311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = arg_21_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(arg_21_1.actors_["1095ui_story"]) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(319311005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 3 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 3)

				if (3 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 3)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311005", "story_v_out_319311.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_319311", "319311005", "story_v_out_319311.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_319311", "319311005", "story_v_out_319311.awb")

						arg_21_1:RecordAudio("319311005", var_24_8)
						arg_21_1:RecordAudio("319311005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319311", "319311005", "story_v_out_319311.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319311", "319311005", "story_v_out_319311.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319311006
		arg_25_1.duration_ = 8.4

		local var_25_0 = {
			zh = 6.066,
			ja = 8.4
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
				arg_25_0:Play319311007(arg_25_1)
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
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = arg_25_1.actors_["1095ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1095ui_story = var_28_8.localPosition
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_9)
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

			local var_28_10 = arg_25_1.actors_["1095ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_10) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_11)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_28_12 = arg_25_1.actors_["10079ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10079ui_story = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_13)
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

			local var_28_14 = arg_25_1.actors_["10079ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_15 and not isNil(var_28_14) then
				if arg_25_1.var_.characterEffect10079ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_15)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_15 and arg_25_1.time_ < 0 + var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10079ui_story then
				arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_28_16 = 0
			local var_28_17 = 0.675

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

				local var_28_18 = arg_25_1:GetWordFromCfg(319311006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 27 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 27)

				if (27 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 27)) > 0 and var_28_17 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311006", "story_v_out_319311.awb") ~= 0 then
					local var_28_22 = manager.audio:GetVoiceLength("story_v_out_319311", "319311006", "story_v_out_319311.awb") / 1000

					if var_28_22 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_16
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_319311", "319311006", "story_v_out_319311.awb")

						arg_25_1:RecordAudio("319311006", var_28_23)
						arg_25_1:RecordAudio("319311006", var_28_23)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319311", "319311006", "story_v_out_319311.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319311", "319311006", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
	Play319311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319311007
		arg_29_1.duration_ = 3.87

		local var_29_0 = {
			zh = 2.933,
			ja = 3.866
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
				arg_29_0:Play319311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(319311007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 12 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 12)

				if (12 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 12)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311007", "story_v_out_319311.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_319311", "319311007", "story_v_out_319311.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_319311", "319311007", "story_v_out_319311.awb")

						arg_29_1:RecordAudio("319311007", var_32_6)
						arg_29_1:RecordAudio("319311007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319311", "319311007", "story_v_out_319311.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319311", "319311007", "story_v_out_319311.awb")
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
	Play319311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319311008
		arg_33_1.duration_ = 6.7

		local var_33_0 = {
			zh = 3.4,
			ja = 6.7
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
				arg_33_0:Play319311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = arg_33_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).z)
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles = arg_33_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
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
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = arg_33_1.actors_["4040ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos4040ui_story = var_36_4.localPosition
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_4.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_33_1.time_ - 0) / var_36_5)
				var_36_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_4.position).x, (manager.ui.mainCamera.transform.position - var_36_4.position).y, (manager.ui.mainCamera.transform.position - var_36_4.position).z)
				var_36_4.localEulerAngles.z = 0
				var_36_4.localEulerAngles.x = 0
				var_36_4.localEulerAngles = var_36_4.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				var_36_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_36_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_4.position).x, (manager.ui.mainCamera.transform.position - var_36_4.position).y, (manager.ui.mainCamera.transform.position - var_36_4.position).z)
				var_36_4.localEulerAngles.z = 0
				var_36_4.localEulerAngles.x = 0
				var_36_4.localEulerAngles = var_36_4.localEulerAngles
			end

			local var_36_6 = arg_33_1.actors_["4040ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 and not isNil(var_36_6) then
				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_7)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect4040ui_story then
				arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_36_8 = 0
			local var_36_9 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(319311008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 19 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 19)

				if (19 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 19)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311008", "story_v_out_319311.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311008", "story_v_out_319311.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_319311", "319311008", "story_v_out_319311.awb")

						arg_33_1:RecordAudio("319311008", var_36_15)
						arg_33_1:RecordAudio("319311008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319311", "319311008", "story_v_out_319311.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319311", "319311008", "story_v_out_319311.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319311009
		arg_37_1.duration_ = 3.47

		local var_37_0 = {
			zh = 2.733,
			ja = 3.466
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
				arg_37_0:Play319311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = arg_37_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(arg_37_1.actors_["1095ui_story"]) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_40_1 = arg_37_1.actors_["4040ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_40_4 = 0
			local var_40_5 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(319311009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)

				if (7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311009", "story_v_out_319311.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311009", "story_v_out_319311.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_319311", "319311009", "story_v_out_319311.awb")

						arg_37_1:RecordAudio("319311009", var_40_11)
						arg_37_1:RecordAudio("319311009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319311", "319311009", "story_v_out_319311.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319311", "319311009", "story_v_out_319311.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319311010
		arg_41_1.duration_ = 4.5

		local var_41_0 = {
			zh = 2.3,
			ja = 4.5
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
				arg_41_0:Play319311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(319311010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 15 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 15)

				if (15 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 15)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311010", "story_v_out_319311.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_319311", "319311010", "story_v_out_319311.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_319311", "319311010", "story_v_out_319311.awb")

						arg_41_1:RecordAudio("319311010", var_44_6)
						arg_41_1:RecordAudio("319311010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319311", "319311010", "story_v_out_319311.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319311", "319311010", "story_v_out_319311.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319311011
		arg_45_1.duration_ = 6.8

		local var_45_0 = {
			zh = 6.8,
			ja = 6.5
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
				arg_45_0:Play319311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1095ui_story = arg_45_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).z)
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles = arg_45_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_45_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).z)
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles = arg_45_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1095ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1095ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["4040ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = arg_45_1.actors_["4040ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_45_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_45_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_48_8 = 0
			local var_48_9 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(319311011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 30 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 30)

				if (30 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 30)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311011", "story_v_out_319311.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311011", "story_v_out_319311.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_319311", "319311011", "story_v_out_319311.awb")

						arg_45_1:RecordAudio("319311011", var_48_15)
						arg_45_1:RecordAudio("319311011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319311", "319311011", "story_v_out_319311.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319311", "319311011", "story_v_out_319311.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play319311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319311012
		arg_49_1.duration_ = 11.23

		local var_49_0 = {
			zh = 7,
			ja = 11.233
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
				arg_49_0:Play319311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = arg_49_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) then
				if arg_49_1.var_.characterEffect4040ui_story and not isNil(arg_49_1.actors_["4040ui_story"]) then
					arg_49_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["4040ui_story"]) and arg_49_1.var_.characterEffect4040ui_story then
				arg_49_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1095ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(319311012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 31 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 31)

				if (31 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 31)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311012", "story_v_out_319311.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311012", "story_v_out_319311.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_319311", "319311012", "story_v_out_319311.awb")

						arg_49_1:RecordAudio("319311012", var_52_11)
						arg_49_1:RecordAudio("319311012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319311", "319311012", "story_v_out_319311.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319311", "319311012", "story_v_out_319311.awb")
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
	Play319311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319311013
		arg_53_1.duration_ = 4.03

		local var_53_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_53_0:Play319311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10079ui_story = arg_53_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).z)
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles = arg_53_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_53_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).z)
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles = arg_53_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10079ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10079ui_story then
				arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = arg_53_1.actors_["1095ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1095ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_5)
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

			local var_56_6 = arg_53_1.actors_["1095ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_56_8 = arg_53_1.actors_["4040ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos4040ui_story = var_56_8.localPosition
			end

			local var_56_9 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 then
				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_9)
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

			local var_56_10 = arg_53_1.actors_["4040ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_11 and not isNil(var_56_10) then
				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_10) then
					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_11)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_11 and arg_53_1.time_ < 0 + var_56_11 + arg_56_0 and not isNil(var_56_10) and arg_53_1.var_.characterEffect4040ui_story then
				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_56_12 = 0
			local var_56_13 = 0.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(319311013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 7 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 7)

				if (7 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 7)) > 0 and var_56_13 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311013", "story_v_out_319311.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311013", "story_v_out_319311.awb") / 1000

					if var_56_18 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_12
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_319311", "319311013", "story_v_out_319311.awb")

						arg_53_1:RecordAudio("319311013", var_56_19)
						arg_53_1:RecordAudio("319311013", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319311", "319311013", "story_v_out_319311.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319311", "319311013", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
				actorName = "4040ui_story",
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
	Play319311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319311014
		arg_57_1.duration_ = 2.6

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_57_0:Play319311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = arg_57_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).z)
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles = arg_57_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).z)
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles = arg_57_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_60_1 = arg_57_1.actors_["4040ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos4040ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, -1.55, -5.5)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["4040ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect4040ui_story == nil then
				arg_57_1.var_.characterEffect4040ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect4040ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect4040ui_story then
				arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_60_6 = 0
			local var_60_7 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(319311014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 5 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 5)

				if (5 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 5)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311014", "story_v_out_319311.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_319311", "319311014", "story_v_out_319311.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_319311", "319311014", "story_v_out_319311.awb")

						arg_57_1:RecordAudio("319311014", var_60_13)
						arg_57_1:RecordAudio("319311014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319311", "319311014", "story_v_out_319311.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319311", "319311014", "story_v_out_319311.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play319311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319311015
		arg_61_1.duration_ = 2.73

		local var_61_0 = {
			zh = 2.433,
			ja = 2.733
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
				arg_61_0:Play319311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1095ui_story = arg_61_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).z)
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles = arg_61_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_61_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1095ui_story"].transform.position).z)
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1095ui_story"].transform.localEulerAngles = arg_61_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1095ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["4040ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect4040ui_story == nil then
				arg_61_1.var_.characterEffect4040ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect4040ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_61_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect4040ui_story then
				arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_61_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_64_6 = arg_61_1.actors_["4040ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos4040ui_story = var_64_6.localPosition
			end

			local var_64_7 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_6.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_61_1.time_ - 0) / var_64_7)
				var_64_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_6.position).x, (manager.ui.mainCamera.transform.position - var_64_6.position).y, (manager.ui.mainCamera.transform.position - var_64_6.position).z)
				var_64_6.localEulerAngles.z = 0
				var_64_6.localEulerAngles.x = 0
				var_64_6.localEulerAngles = var_64_6.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_6.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_64_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_6.position).x, (manager.ui.mainCamera.transform.position - var_64_6.position).y, (manager.ui.mainCamera.transform.position - var_64_6.position).z)
				var_64_6.localEulerAngles.z = 0
				var_64_6.localEulerAngles.x = 0
				var_64_6.localEulerAngles = var_64_6.localEulerAngles
			end

			local var_64_8 = 0
			local var_64_9 = 0.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
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

				local var_64_10 = arg_61_1:GetWordFromCfg(319311015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 7 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 7)

				if (7 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 7)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311015", "story_v_out_319311.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311015", "story_v_out_319311.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_319311", "319311015", "story_v_out_319311.awb")

						arg_61_1:RecordAudio("319311015", var_64_15)
						arg_61_1:RecordAudio("319311015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319311", "319311015", "story_v_out_319311.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319311", "319311015", "story_v_out_319311.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play319311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319311016
		arg_65_1.duration_ = 4.53

		local var_65_0 = {
			zh = 4.533,
			ja = 1.999999999999
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
				arg_65_0:Play319311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = arg_65_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(arg_65_1.actors_["1095ui_story"]) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = 0.5
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

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.45

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
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

				local var_68_6 = arg_65_1:GetWordFromCfg(319311016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 18 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 18)

				if (18 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 18)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311016", "story_v_out_319311.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311016", "story_v_out_319311.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_319311", "319311016", "story_v_out_319311.awb")

						arg_65_1:RecordAudio("319311016", var_68_11)
						arg_65_1:RecordAudio("319311016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319311", "319311016", "story_v_out_319311.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319311", "319311016", "story_v_out_319311.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319311017
		arg_69_1.duration_ = 13.17

		local var_69_0 = {
			zh = 6.1,
			ja = 13.166
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
				arg_69_0:Play319311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_0 = 0
			local var_72_1 = 0.75

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(319311017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 30 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 30)

				if (30 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 30)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311017", "story_v_out_319311.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_319311", "319311017", "story_v_out_319311.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_319311", "319311017", "story_v_out_319311.awb")

						arg_69_1:RecordAudio("319311017", var_72_7)
						arg_69_1:RecordAudio("319311017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319311", "319311017", "story_v_out_319311.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319311", "319311017", "story_v_out_319311.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319311018
		arg_73_1.duration_ = 7.33

		local var_73_0 = {
			zh = 4.766,
			ja = 7.333
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
				arg_73_0:Play319311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0.8 < arg_73_1.time_ and arg_73_1.time_ <= 0.8 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_76_1 = 0
			local var_76_2 = 0.6

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(319311018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 24 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 24)

				if (24 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 24)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311018", "story_v_out_319311.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_319311", "319311018", "story_v_out_319311.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_319311", "319311018", "story_v_out_319311.awb")

						arg_73_1:RecordAudio("319311018", var_76_8)
						arg_73_1:RecordAudio("319311018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319311", "319311018", "story_v_out_319311.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319311", "319311018", "story_v_out_319311.awb")
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
	Play319311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319311019
		arg_77_1.duration_ = 4.63

		local var_77_0 = {
			zh = 4.366,
			ja = 4.633
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
				arg_77_0:Play319311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos4040ui_story = arg_77_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).z)
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles = arg_77_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_77_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["4040ui_story"].transform.position).z)
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["4040ui_story"].transform.localEulerAngles = arg_77_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["4040ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect4040ui_story == nil then
				arg_77_1.var_.characterEffect4040ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect4040ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect4040ui_story then
				arg_77_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_80_4 = 0
			local var_80_5 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(319311019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 17 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 17)

				if (17 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 17)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311019", "story_v_out_319311.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311019", "story_v_out_319311.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_319311", "319311019", "story_v_out_319311.awb")

						arg_77_1:RecordAudio("319311019", var_80_11)
						arg_77_1:RecordAudio("319311019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319311", "319311019", "story_v_out_319311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319311", "319311019", "story_v_out_319311.awb")
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
				actorName = "4040ui_story",
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
	Play319311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319311020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["4040ui_story"]) and arg_81_1.var_.characterEffect4040ui_story == nil then
				arg_81_1.var_.characterEffect4040ui_story = arg_81_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["4040ui_story"]) then
				if arg_81_1.var_.characterEffect4040ui_story and not isNil(arg_81_1.actors_["4040ui_story"]) then
					arg_81_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_81_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["4040ui_story"]) and arg_81_1.var_.characterEffect4040ui_story then
				arg_81_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_81_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 1.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(319311020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 56 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 56)

				if (56 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 56)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319311021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319311021
		arg_85_1.duration_ = 2.8

		local var_85_0 = {
			zh = 1.766,
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
				arg_85_0:Play319311022(arg_85_1)
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

			local var_88_1 = arg_85_1.actors_["4040ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect4040ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect4040ui_story then
				arg_85_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(319311021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)

				if (7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311021", "story_v_out_319311.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311021", "story_v_out_319311.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_319311", "319311021", "story_v_out_319311.awb")

						arg_85_1:RecordAudio("319311021", var_88_11)
						arg_85_1:RecordAudio("319311021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319311", "319311021", "story_v_out_319311.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319311", "319311021", "story_v_out_319311.awb")
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
	Play319311022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319311022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319311023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1095ui_story = arg_89_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).z)
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles = arg_89_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).z)
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles = arg_89_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1095ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_2)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_92_3 = arg_89_1.actors_["4040ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos4040ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_4)
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

			local var_92_5 = arg_89_1.actors_["4040ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_5) then
					arg_89_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_89_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_6)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect4040ui_story then
				arg_89_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_89_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_92_7 = 0
			local var_92_8 = 0.975

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319311022).content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 39 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_9) / 39)

				if (39 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_9) / 39)) > 0 and var_92_8 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_12 and arg_89_1.time_ < var_92_7 + var_92_12 + arg_92_0 then
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
				actorName = "4040ui_story",
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
	Play319311023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319311023
		arg_93_1.duration_ = 5.57

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319311024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_0 = arg_93_1.var_.effect919

				if not arg_93_1.var_.effect919 then
					var_96_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_96_0.name = "919"
					arg_93_1.var_.effect919 = var_96_0
				else
					var_96_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_96_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_96_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_2 = 0.566666666666667
			local var_96_3 = 1.025

			if 0.566666666666667 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_4 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_4:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319311023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 41 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 41)

				if (41 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 41)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7
					var_96_2 = var_96_2 + 0.3

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = var_96_2 + 0.3
			local var_96_9 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319311024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319311024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319311025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				if arg_99_1.var_.effect919 then
					Object.Destroy(arg_99_1.var_.effect919)

					arg_99_1.var_.effect919 = nil
				end
			end

			local var_102_1 = 0
			local var_102_2 = 1.025

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(319311024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 41 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 41)

				if (41 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 41)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319311025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319311025
		arg_103_1.duration_ = 3.7

		local var_103_0 = {
			zh = 3.066,
			ja = 3.7
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
				arg_103_0:Play319311026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10079ui_story = arg_103_1.actors_["10079ui_story"].transform.localPosition

				arg_103_1:ShowWeapon(arg_103_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).z)
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles = arg_103_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_103_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10079ui_story"].transform.position).z)
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["10079ui_story"].transform.localEulerAngles = arg_103_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["10079ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10079ui_story == nil then
				arg_103_1.var_.characterEffect10079ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect10079ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10079ui_story then
				arg_103_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.35

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(319311025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 14 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 14)

				if (14 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 14)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311025", "story_v_out_319311.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311025", "story_v_out_319311.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_319311", "319311025", "story_v_out_319311.awb")

						arg_103_1:RecordAudio("319311025", var_106_11)
						arg_103_1:RecordAudio("319311025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_319311", "319311025", "story_v_out_319311.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_319311", "319311025", "story_v_out_319311.awb")
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

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play319311026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319311026
		arg_107_1.duration_ = 7.97

		local var_107_0 = {
			zh = 5.433,
			ja = 7.966
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
				arg_107_0:Play319311027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = arg_107_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) then
				if arg_107_1.var_.characterEffect10079ui_story and not isNil(arg_107_1.actors_["10079ui_story"]) then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_110_2 = 0
			local var_110_3 = 0.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[696].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:GetWordFromCfg(319311026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 17 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 17)

				if (17 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 17)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311026", "story_v_out_319311.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311026", "story_v_out_319311.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_319311", "319311026", "story_v_out_319311.awb")

						arg_107_1:RecordAudio("319311026", var_110_9)
						arg_107_1:RecordAudio("319311026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319311", "319311026", "story_v_out_319311.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319311", "319311026", "story_v_out_319311.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319311027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319311027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319311028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.45

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(319311027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 58 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 58)

				if (58 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 58)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319311028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319311028
		arg_115_1.duration_ = 6.67

		local var_115_0 = {
			zh = 4.7,
			ja = 6.666
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
				arg_115_0:Play319311029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10079ui_story = arg_115_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).z)
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles = arg_115_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).z)
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles = arg_115_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["10079ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10079ui_story == nil then
				arg_115_1.var_.characterEffect10079ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect10079ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_2)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10079ui_story then
				arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_118_3 = arg_115_1.actors_["4040ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos4040ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, -1.55, -5.5)
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
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_8 = 0
			local var_118_9 = 0.525

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(319311028)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 21 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 21)

				if (21 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 21)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311028", "story_v_out_319311.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311028", "story_v_out_319311.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_319311", "319311028", "story_v_out_319311.awb")

						arg_115_1:RecordAudio("319311028", var_118_15)
						arg_115_1:RecordAudio("319311028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319311", "319311028", "story_v_out_319311.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319311", "319311028", "story_v_out_319311.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319311029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319311029
		arg_119_1.duration_ = 2.93

		local var_119_0 = {
			zh = 2.633,
			ja = 2.933
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
				arg_119_0:Play319311030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["4040ui_story"]) and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = arg_119_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["4040ui_story"]) then
				if arg_119_1.var_.characterEffect4040ui_story and not isNil(arg_119_1.actors_["4040ui_story"]) then
					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["4040ui_story"]) and arg_119_1.var_.characterEffect4040ui_story then
				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_122_1 = arg_119_1.actors_["10079ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10079ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_122_4 = arg_119_1.actors_["4040ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos4040ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = arg_119_1.actors_["10079ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10079ui_story = var_122_6.localPosition
			end

			local var_122_7 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				var_122_6.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_119_1.time_ - 0) / var_122_7)
				var_122_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_6.position).x, (manager.ui.mainCamera.transform.position - var_122_6.position).y, (manager.ui.mainCamera.transform.position - var_122_6.position).z)
				var_122_6.localEulerAngles.z = 0
				var_122_6.localEulerAngles.x = 0
				var_122_6.localEulerAngles = var_122_6.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				var_122_6.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_122_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_6.position).x, (manager.ui.mainCamera.transform.position - var_122_6.position).y, (manager.ui.mainCamera.transform.position - var_122_6.position).z)
				var_122_6.localEulerAngles.z = 0
				var_122_6.localEulerAngles.x = 0
				var_122_6.localEulerAngles = var_122_6.localEulerAngles
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_122_8 = 0
			local var_122_9 = 0.3

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(319311029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 12 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 12)

				if (12 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 12)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311029", "story_v_out_319311.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311029", "story_v_out_319311.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_319311", "319311029", "story_v_out_319311.awb")

						arg_119_1:RecordAudio("319311029", var_122_15)
						arg_119_1:RecordAudio("319311029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319311", "319311029", "story_v_out_319311.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319311", "319311029", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
	Play319311030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319311030
		arg_123_1.duration_ = 9.97

		local var_123_0 = {
			zh = 7.3,
			ja = 9.966
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
				arg_123_0:Play319311031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["4040ui_story"]) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = arg_123_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["4040ui_story"]) then
				if arg_123_1.var_.characterEffect4040ui_story and not isNil(arg_123_1.actors_["4040ui_story"]) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["4040ui_story"]) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["10079ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect10079ui_story == nil then
				arg_123_1.var_.characterEffect10079ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect10079ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect10079ui_story then
				arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_126_4 = arg_123_1.actors_["4040ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos4040ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["4040ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 and not isNil(var_126_6) then
				if arg_123_1.var_.characterEffect4040ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_9 = 0
			local var_126_10 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_11 = arg_123_1:GetWordFromCfg(319311030)
				local var_126_12 = arg_123_1:FormatText(var_126_11.content)

				arg_123_1.text_.text = var_126_12

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_14 = 24 <= 0 and var_126_10 or var_126_10 * (utf8.len(var_126_12) / 24)

				if (24 <= 0 and var_126_10 or var_126_10 * (utf8.len(var_126_12) / 24)) > 0 and var_126_10 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_9 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_9
					end
				end

				arg_123_1.text_.text = var_126_12
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311030", "story_v_out_319311.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_319311", "319311030", "story_v_out_319311.awb") / 1000

					if var_126_15 + var_126_9 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_9
					end

					if var_126_11.prefab_name ~= "" and arg_123_1.actors_[var_126_11.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_11.prefab_name].transform, "story_v_out_319311", "319311030", "story_v_out_319311.awb")

						arg_123_1:RecordAudio("319311030", var_126_16)
						arg_123_1:RecordAudio("319311030", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319311", "319311030", "story_v_out_319311.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319311", "319311030", "story_v_out_319311.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_10, arg_123_1.talkMaxDuration)

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_9) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_9 + var_126_17 and arg_123_1.time_ < var_126_9 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play319311031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319311031
		arg_127_1.duration_ = 6.93

		local var_127_0 = {
			zh = 5.3,
			ja = 6.933
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
				arg_127_0:Play319311032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["4040ui_story"]) and arg_127_1.var_.characterEffect4040ui_story == nil then
				arg_127_1.var_.characterEffect4040ui_story = arg_127_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["4040ui_story"]) then
				if arg_127_1.var_.characterEffect4040ui_story and not isNil(arg_127_1.actors_["4040ui_story"]) then
					arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_127_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["4040ui_story"]) and arg_127_1.var_.characterEffect4040ui_story then
				arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_127_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["10079ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10079ui_story == nil then
				arg_127_1.var_.characterEffect10079ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10079ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10079ui_story then
				arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.55

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319311031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 22 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 22)

				if (22 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 22)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311031", "story_v_out_319311.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311031", "story_v_out_319311.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319311", "319311031", "story_v_out_319311.awb")

						arg_127_1:RecordAudio("319311031", var_130_11)
						arg_127_1:RecordAudio("319311031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319311", "319311031", "story_v_out_319311.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319311", "319311031", "story_v_out_319311.awb")
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
	Play319311032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319311032
		arg_131_1.duration_ = 6.33

		local var_131_0 = {
			zh = 6.333,
			ja = 5.733
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
				arg_131_0:Play319311033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10079ui_story = arg_131_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).z)
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles = arg_131_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_131_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10079ui_story"].transform.position).z)
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10079ui_story"].transform.localEulerAngles = arg_131_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10079ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10079ui_story == nil then
				arg_131_1.var_.characterEffect10079ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10079ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10079ui_story then
				arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.8

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

				local var_134_6 = arg_131_1:GetWordFromCfg(319311032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 32 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 32)

				if (32 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 32)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311032", "story_v_out_319311.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311032", "story_v_out_319311.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_319311", "319311032", "story_v_out_319311.awb")

						arg_131_1:RecordAudio("319311032", var_134_11)
						arg_131_1:RecordAudio("319311032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319311", "319311032", "story_v_out_319311.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319311", "319311032", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
	Play319311033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319311033
		arg_135_1.duration_ = 2

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319311034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1095ui_story = arg_135_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).z)
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles = arg_135_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_135_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1095ui_story"].transform.position).z)
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1095ui_story"].transform.localEulerAngles = arg_135_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1095ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1095ui_story == nil then
				arg_135_1.var_.characterEffect1095ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1095ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1095ui_story then
				arg_135_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = arg_135_1.actors_["4040ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos4040ui_story = var_138_4.localPosition
			end

			local var_138_5 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				var_138_4.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_5)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				var_138_4.localPosition = Vector3.New(0, 100, 0)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			local var_138_6 = arg_135_1.actors_["4040ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect4040ui_story == nil then
				arg_135_1.var_.characterEffect4040ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_7 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 and not isNil(var_138_6) then
				if arg_135_1.var_.characterEffect4040ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_7)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect4040ui_story then
				arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_138_8 = arg_135_1.actors_["10079ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10079ui_story = var_138_8.localPosition
			end

			local var_138_9 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 then
				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_9)
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

			local var_138_10 = arg_135_1.actors_["10079ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect10079ui_story == nil then
				arg_135_1.var_.characterEffect10079ui_story = var_138_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_11 and not isNil(var_138_10) then
				if arg_135_1.var_.characterEffect10079ui_story and not isNil(var_138_10) then
					arg_135_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_11)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_11 and arg_135_1.time_ < 0 + var_138_11 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect10079ui_story then
				arg_135_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_138_12 = 0
			local var_138_13 = 0.225

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(319311033)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 9 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 9)

				if (9 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 9)) > 0 and var_138_13 < var_138_17 then
					arg_135_1.talkMaxDuration = var_138_17

					if var_138_17 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311033", "story_v_out_319311.awb") ~= 0 then
					local var_138_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311033", "story_v_out_319311.awb") / 1000

					if var_138_18 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_12
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_out_319311", "319311033", "story_v_out_319311.awb")

						arg_135_1:RecordAudio("319311033", var_138_19)
						arg_135_1:RecordAudio("319311033", var_138_19)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319311", "319311033", "story_v_out_319311.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319311", "319311033", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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
	Play319311034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319311034
		arg_139_1.duration_ = 2.27

		local var_139_0 = {
			zh = 2.266,
			ja = 1.533
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
				arg_139_0:Play319311035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10079ui_story = arg_139_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).z)
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles = arg_139_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_139_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10079ui_story"].transform.position).z)
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10079ui_story"].transform.localEulerAngles = arg_139_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10079ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10079ui_story == nil then
				arg_139_1.var_.characterEffect10079ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10079ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10079ui_story then
				arg_139_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["1095ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1095ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_5)
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

			local var_142_6 = arg_139_1.actors_["1095ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_142_8 = 0
			local var_142_9 = 0.15

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(319311034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 6 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 6)

				if (6 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 6)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311034", "story_v_out_319311.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311034", "story_v_out_319311.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_319311", "319311034", "story_v_out_319311.awb")

						arg_139_1:RecordAudio("319311034", var_142_15)
						arg_139_1:RecordAudio("319311034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319311", "319311034", "story_v_out_319311.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319311", "319311034", "story_v_out_319311.awb")
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
				actorName = "10079ui_story",
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

		arg_139_1:InitPlayNodeList()
	end,
	Play319311035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319311035
		arg_143_1.duration_ = 2.83

		local var_143_0 = {
			zh = 2,
			ja = 2.833
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
				arg_143_0:Play319311036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) and arg_143_1.var_.characterEffect10079ui_story == nil then
				arg_143_1.var_.characterEffect10079ui_story = arg_143_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) then
				if arg_143_1.var_.characterEffect10079ui_story and not isNil(arg_143_1.actors_["10079ui_story"]) then
					arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) and arg_143_1.var_.characterEffect10079ui_story then
				arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.125

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[696].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(319311035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 5 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 5)

				if (5 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 5)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311035", "story_v_out_319311.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_out_319311", "319311035", "story_v_out_319311.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_319311", "319311035", "story_v_out_319311.awb")

						arg_143_1:RecordAudio("319311035", var_146_8)
						arg_143_1:RecordAudio("319311035", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319311", "319311035", "story_v_out_319311.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319311", "319311035", "story_v_out_319311.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319311036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319311036
		arg_147_1.duration_ = 11.73

		local var_147_0 = {
			zh = 9,
			ja = 11.733
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
				arg_147_0:Play319311037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_9000

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				local var_150_1 = arg_147_1.var_.effect996

				if not arg_147_1.var_.effect996 then
					var_150_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_150_1.name = "996"
					arg_147_1.var_.effect996 = var_150_1
				else
					var_150_1.transform:SetParent(var_150_9000)
				end

				var_150_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_150_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_150_3 = 1
			local var_150_4 = 0.6

			if 1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[696].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_5 = arg_147_1:GetWordFromCfg(319311036)
				local var_150_6 = arg_147_1:FormatText(var_150_5.content)

				arg_147_1.text_.text = var_150_6

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_8 = 24 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_6) / 24)

				if (24 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_6) / 24)) > 0 and var_150_4 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8

					if var_150_8 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_3
					end
				end

				arg_147_1.text_.text = var_150_6
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311036", "story_v_out_319311.awb") ~= 0 then
					local var_150_9 = manager.audio:GetVoiceLength("story_v_out_319311", "319311036", "story_v_out_319311.awb") / 1000

					if var_150_9 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_3
					end

					if var_150_5.prefab_name ~= "" and arg_147_1.actors_[var_150_5.prefab_name] ~= nil then
						local var_150_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_5.prefab_name].transform, "story_v_out_319311", "319311036", "story_v_out_319311.awb")

						arg_147_1:RecordAudio("319311036", var_150_10)
						arg_147_1:RecordAudio("319311036", var_150_10)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319311", "319311036", "story_v_out_319311.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319311", "319311036", "story_v_out_319311.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = math.max(var_150_4, arg_147_1.talkMaxDuration)

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_11 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_3) / var_150_11

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_3 + var_150_11 and arg_147_1.time_ < var_150_3 + var_150_11 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319311037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319311037
		arg_151_1.duration_ = 3.73

		local var_151_0 = {
			zh = 3.733,
			ja = 3.366
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
				arg_151_0:Play319311038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = arg_151_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) then
				if arg_151_1.var_.characterEffect10079ui_story and not isNil(arg_151_1.actors_["10079ui_story"]) then
					arg_151_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) and arg_151_1.var_.characterEffect10079ui_story then
				arg_151_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4125")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_154_2 = 0
			local var_154_3 = 0.325

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(319311037)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 13 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 13)

				if (13 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 13)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311037", "story_v_out_319311.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311037", "story_v_out_319311.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_319311", "319311037", "story_v_out_319311.awb")

						arg_151_1:RecordAudio("319311037", var_154_9)
						arg_151_1:RecordAudio("319311037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319311", "319311037", "story_v_out_319311.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319311", "319311037", "story_v_out_319311.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319311038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319311038
		arg_155_1.duration_ = 8.37

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319311039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10079ui_story"]) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = arg_155_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10079ui_story"]) then
				if arg_155_1.var_.characterEffect10079ui_story and not isNil(arg_155_1.actors_["10079ui_story"]) then
					arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10079ui_story"]) and arg_155_1.var_.characterEffect10079ui_story then
				arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_1 = arg_155_1.bgs_.A08f

				arg_155_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_2 = var_158_1:GetComponent("SpriteRenderer")

				if var_158_2 and var_158_2.sprite then
					local var_158_3 = 2 * (var_158_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_1.transform.localScale = Vector3.New(var_158_3 / var_158_2.sprite.bounds.size.y < var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x and var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x or var_158_3 / var_158_2.sprite.bounds.size.y, var_158_3 / var_158_2.sprite.bounds.size.y < var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x and var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x or var_158_3 / var_158_2.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "A08f" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.6 < arg_155_1.time_ and arg_155_1.time_ <= 0.6 + arg_158_0 then
				local var_158_4 = arg_155_1.bgs_.A08f

				arg_155_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_5 = var_158_4:GetComponent("SpriteRenderer")

				if var_158_5 and var_158_5.sprite then
					local var_158_6 = 2 * (var_158_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_4.transform.localScale = Vector3.New(var_158_6 / var_158_5.sprite.bounds.size.y < var_158_6 * manager.ui.mainCameraCom_.aspect / var_158_5.sprite.bounds.size.x and var_158_6 * manager.ui.mainCameraCom_.aspect / var_158_5.sprite.bounds.size.x or var_158_6 / var_158_5.sprite.bounds.size.y, var_158_6 / var_158_5.sprite.bounds.size.y < var_158_6 * manager.ui.mainCameraCom_.aspect / var_158_5.sprite.bounds.size.x and var_158_6 * manager.ui.mainCameraCom_.aspect / var_158_5.sprite.bounds.size.x or var_158_6 / var_158_5.sprite.bounds.size.y, 0)
				end

				for iter_158_2, iter_158_3 in pairs(arg_155_1.bgs_) do
					if iter_158_2 ~= "A08f" then
						iter_158_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.33333333333333 < arg_155_1.time_ and arg_155_1.time_ <= 1.33333333333333 + arg_158_0 then
				local var_158_7 = arg_155_1.bgs_.A08f

				arg_155_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_8 = var_158_7:GetComponent("SpriteRenderer")

				if var_158_8 and var_158_8.sprite then
					local var_158_9 = 2 * (var_158_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_7.transform.localScale = Vector3.New(var_158_9 / var_158_8.sprite.bounds.size.y < var_158_9 * manager.ui.mainCameraCom_.aspect / var_158_8.sprite.bounds.size.x and var_158_9 * manager.ui.mainCameraCom_.aspect / var_158_8.sprite.bounds.size.x or var_158_9 / var_158_8.sprite.bounds.size.y, var_158_9 / var_158_8.sprite.bounds.size.y < var_158_9 * manager.ui.mainCameraCom_.aspect / var_158_8.sprite.bounds.size.x and var_158_9 * manager.ui.mainCameraCom_.aspect / var_158_8.sprite.bounds.size.x or var_158_9 / var_158_8.sprite.bounds.size.y, 0)
				end

				for iter_158_4, iter_158_5 in pairs(arg_155_1.bgs_) do
					if iter_158_4 ~= "A08f" then
						iter_158_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2.1 < arg_155_1.time_ and arg_155_1.time_ <= 2.1 + arg_158_0 then
				local var_158_10 = arg_155_1.bgs_.A08f

				arg_155_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_11 = var_158_10:GetComponent("SpriteRenderer")

				if var_158_11 and var_158_11.sprite then
					local var_158_12 = 2 * (var_158_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_10.transform.localScale = Vector3.New(var_158_12 / var_158_11.sprite.bounds.size.y < var_158_12 * manager.ui.mainCameraCom_.aspect / var_158_11.sprite.bounds.size.x and var_158_12 * manager.ui.mainCameraCom_.aspect / var_158_11.sprite.bounds.size.x or var_158_12 / var_158_11.sprite.bounds.size.y, var_158_12 / var_158_11.sprite.bounds.size.y < var_158_12 * manager.ui.mainCameraCom_.aspect / var_158_11.sprite.bounds.size.x and var_158_12 * manager.ui.mainCameraCom_.aspect / var_158_11.sprite.bounds.size.x or var_158_12 / var_158_11.sprite.bounds.size.y, 0)
				end

				for iter_158_6, iter_158_7 in pairs(arg_155_1.bgs_) do
					if iter_158_6 ~= "A08f" then
						iter_158_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_13 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_14 = 0.6

			if var_158_13 <= arg_155_1.time_ and arg_155_1.time_ < var_158_13 + var_158_14 then
				local var_158_15 = Color.New(0, 0, 0)

				var_158_15.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_13) / var_158_14)
				arg_155_1.mask_.color = var_158_15
			end

			if arg_155_1.time_ >= var_158_13 + var_158_14 and arg_155_1.time_ < var_158_13 + var_158_14 + arg_158_0 then
				local var_158_16 = Color.New(0, 0, 0)

				var_158_16.a = 1
				arg_155_1.mask_.color = var_158_16
			end

			local var_158_17 = 0.6

			if 0.6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_18 = 0.733333333333333

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_18 then
				local var_158_19 = Color.New(0, 0, 0)

				var_158_19.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_17) / var_158_18)
				arg_155_1.mask_.color = var_158_19
			end

			if arg_155_1.time_ >= var_158_17 + var_158_18 and arg_155_1.time_ < var_158_17 + var_158_18 + arg_158_0 then
				local var_158_20 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_20.a = 0
				arg_155_1.mask_.color = var_158_20
			end

			local var_158_21 = 1.33333333333333

			if 1.33333333333333 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_22 = 0.766666666666667

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_22 then
				local var_158_23 = Color.New(0, 0, 0)

				var_158_23.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_21) / var_158_22)
				arg_155_1.mask_.color = var_158_23
			end

			if arg_155_1.time_ >= var_158_21 + var_158_22 and arg_155_1.time_ < var_158_21 + var_158_22 + arg_158_0 then
				local var_158_24 = Color.New(0, 0, 0)

				var_158_24.a = 1
				arg_155_1.mask_.color = var_158_24
			end

			local var_158_25 = 2.1

			if 2.1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_25 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_26 = 1.1

			if var_158_25 <= arg_155_1.time_ and arg_155_1.time_ < var_158_25 + var_158_26 then
				local var_158_27 = Color.New(0, 0, 0)

				var_158_27.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_25) / var_158_26)
				arg_155_1.mask_.color = var_158_27
			end

			if arg_155_1.time_ >= var_158_25 + var_158_26 and arg_155_1.time_ < var_158_25 + var_158_26 + arg_158_0 then
				local var_158_28 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_28.a = 0
				arg_155_1.mask_.color = var_158_28
			end

			local var_158_29 = arg_155_1.actors_["10079ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = var_158_29.localPosition
			end

			local var_158_30 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_30 then
				var_158_29.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_30)
				var_158_29.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_29.position).x, (manager.ui.mainCamera.transform.position - var_158_29.position).y, (manager.ui.mainCamera.transform.position - var_158_29.position).z)
				var_158_29.localEulerAngles.z = 0
				var_158_29.localEulerAngles.x = 0
				var_158_29.localEulerAngles = var_158_29.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_30 and arg_155_1.time_ < 0 + var_158_30 + arg_158_0 then
				var_158_29.localPosition = Vector3.New(0, 100, 0)
				var_158_29.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_29.position).x, (manager.ui.mainCamera.transform.position - var_158_29.position).y, (manager.ui.mainCamera.transform.position - var_158_29.position).z)
				var_158_29.localEulerAngles.z = 0
				var_158_29.localEulerAngles.x = 0
				var_158_29.localEulerAngles = var_158_29.localEulerAngles
			end

			if 0.766666666666667 < arg_155_1.time_ and arg_155_1.time_ <= 0.766666666666667 + arg_158_0 then
				if arg_155_1.var_.effect996 then
					Object.Destroy(arg_155_1.var_.effect996)

					arg_155_1.var_.effect996 = nil
				end
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_32 = 3.36666666666667
			local var_158_33 = 1.025

			if 3.36666666666667 < arg_155_1.time_ and arg_155_1.time_ <= var_158_32 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_34 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_34:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_35 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(319311038).content)

				arg_155_1.text_.text = var_158_35

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_37 = 41 <= 0 and var_158_33 or var_158_33 * (utf8.len(var_158_35) / 41)

				if (41 <= 0 and var_158_33 or var_158_33 * (utf8.len(var_158_35) / 41)) > 0 and var_158_33 < var_158_37 then
					arg_155_1.talkMaxDuration = var_158_37
					var_158_32 = var_158_32 + 0.3

					if var_158_37 + var_158_32 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_37 + var_158_32
					end
				end

				arg_155_1.text_.text = var_158_35
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_38 = var_158_32 + 0.3
			local var_158_39 = math.max(var_158_33, arg_155_1.talkMaxDuration)

			if var_158_32 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_38 + var_158_39 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_38) / var_158_39

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_38 + var_158_39 and arg_155_1.time_ < var_158_38 + var_158_39 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319311039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319311039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319311040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.15

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(319311039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 46 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 46)

				if (46 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 46)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319311040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319311040
		arg_165_1.duration_ = 9.67

		local var_165_0 = {
			zh = 5.733,
			ja = 9.666
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
				arg_165_0:Play319311041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1095ui_story = arg_165_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1095ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_4 = arg_165_1.actors_["10079ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10079ui_story = var_168_4.localPosition
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_5)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(0, 100, 0)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			local var_168_6 = arg_165_1.actors_["10079ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10079ui_story == nil then
				arg_165_1.var_.characterEffect10079ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_7 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 and not isNil(var_168_6) then
				if arg_165_1.var_.characterEffect10079ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_7)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10079ui_story then
				arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_168_8 = 0
			local var_168_9 = 0.525

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(319311040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 21 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 21)

				if (21 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 21)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311040", "story_v_out_319311.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311040", "story_v_out_319311.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_319311", "319311040", "story_v_out_319311.awb")

						arg_165_1:RecordAudio("319311040", var_168_15)
						arg_165_1:RecordAudio("319311040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319311", "319311040", "story_v_out_319311.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319311", "319311040", "story_v_out_319311.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319311041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319311041
		arg_169_1.duration_ = 5.63

		local var_169_0 = {
			zh = 5.633,
			ja = 5.066
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
				arg_169_0:Play319311042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos4040ui_story = arg_169_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).z)
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles = arg_169_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_169_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4040ui_story"].transform.position).z)
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4040ui_story"].transform.localEulerAngles = arg_169_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["4040ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4040ui_story == nil then
				arg_169_1.var_.characterEffect4040ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect4040ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4040ui_story then
				arg_169_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_172_4 = arg_169_1.actors_["1095ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = var_172_4.localPosition
			end

			local var_172_5 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 then
				var_172_4.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_169_1.time_ - 0) / var_172_5)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 then
				var_172_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			local var_172_6 = arg_169_1.actors_["1095ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_7 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 and not isNil(var_172_6) then
				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_7)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_172_8 = 0
			local var_172_9 = 0.625

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(319311041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 25 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 25)

				if (25 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 25)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311041", "story_v_out_319311.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311041", "story_v_out_319311.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_319311", "319311041", "story_v_out_319311.awb")

						arg_169_1:RecordAudio("319311041", var_172_15)
						arg_169_1:RecordAudio("319311041", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319311", "319311041", "story_v_out_319311.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319311", "319311041", "story_v_out_319311.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play319311042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319311042
		arg_173_1.duration_ = 2.4

		local var_173_0 = {
			zh = 1.866,
			ja = 2.4
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
				arg_173_0:Play319311043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["4040ui_story"]) and arg_173_1.var_.characterEffect4040ui_story == nil then
				arg_173_1.var_.characterEffect4040ui_story = arg_173_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["4040ui_story"]) then
				if arg_173_1.var_.characterEffect4040ui_story and not isNil(arg_173_1.actors_["4040ui_story"]) then
					arg_173_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_173_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["4040ui_story"]) and arg_173_1.var_.characterEffect4040ui_story then
				arg_173_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_173_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["1095ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_176_4 = 0
			local var_176_5 = 0.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(319311042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 7 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 7)

				if (7 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 7)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311042", "story_v_out_319311.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311042", "story_v_out_319311.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_319311", "319311042", "story_v_out_319311.awb")

						arg_173_1:RecordAudio("319311042", var_176_11)
						arg_173_1:RecordAudio("319311042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319311", "319311042", "story_v_out_319311.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319311", "319311042", "story_v_out_319311.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319311043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319311043
		arg_177_1.duration_ = 4.33

		local var_177_0 = {
			zh = 4.333,
			ja = 2.4
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
				arg_177_0:Play319311044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10079ui_story = arg_177_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).z)
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles = arg_177_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_177_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).z)
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles = arg_177_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10079ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_4 = arg_177_1.actors_["1095ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_5)
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

			local var_180_6 = arg_177_1.actors_["1095ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_180_8 = arg_177_1.actors_["4040ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos4040ui_story = var_180_8.localPosition
			end

			local var_180_9 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_9 then
				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_9)
				var_180_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_8.position).x, (manager.ui.mainCamera.transform.position - var_180_8.position).y, (manager.ui.mainCamera.transform.position - var_180_8.position).z)
				var_180_8.localEulerAngles.z = 0
				var_180_8.localEulerAngles.x = 0
				var_180_8.localEulerAngles = var_180_8.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_9 and arg_177_1.time_ < 0 + var_180_9 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(0, 100, 0)
				var_180_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_8.position).x, (manager.ui.mainCamera.transform.position - var_180_8.position).y, (manager.ui.mainCamera.transform.position - var_180_8.position).z)
				var_180_8.localEulerAngles.z = 0
				var_180_8.localEulerAngles.x = 0
				var_180_8.localEulerAngles = var_180_8.localEulerAngles
			end

			local var_180_10 = arg_177_1.actors_["4040ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_10) and arg_177_1.var_.characterEffect4040ui_story == nil then
				arg_177_1.var_.characterEffect4040ui_story = var_180_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_11 and not isNil(var_180_10) then
				if arg_177_1.var_.characterEffect4040ui_story and not isNil(var_180_10) then
					arg_177_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_177_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_11)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_11 and arg_177_1.time_ < 0 + var_180_11 + arg_180_0 and not isNil(var_180_10) and arg_177_1.var_.characterEffect4040ui_story then
				arg_177_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_177_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_180_12 = 0
			local var_180_13 = 0.425

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
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

				local var_180_14 = arg_177_1:GetWordFromCfg(319311043)
				local var_180_15 = arg_177_1:FormatText(var_180_14.content)

				arg_177_1.text_.text = var_180_15

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 17 <= 0 and var_180_13 or var_180_13 * (utf8.len(var_180_15) / 17)

				if (17 <= 0 and var_180_13 or var_180_13 * (utf8.len(var_180_15) / 17)) > 0 and var_180_13 < var_180_17 then
					arg_177_1.talkMaxDuration = var_180_17

					if var_180_17 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_15
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311043", "story_v_out_319311.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311043", "story_v_out_319311.awb") / 1000

					if var_180_18 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_12
					end

					if var_180_14.prefab_name ~= "" and arg_177_1.actors_[var_180_14.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_14.prefab_name].transform, "story_v_out_319311", "319311043", "story_v_out_319311.awb")

						arg_177_1:RecordAudio("319311043", var_180_19)
						arg_177_1:RecordAudio("319311043", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319311", "319311043", "story_v_out_319311.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319311", "319311043", "story_v_out_319311.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_20 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_20 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_20

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_20 and arg_177_1.time_ < var_180_12 + var_180_20 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
				actorName = "4040ui_story",
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
	Play319311044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319311044
		arg_181_1.duration_ = 8

		local var_181_0 = {
			zh = 8,
			ja = 7.533
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
				arg_181_0:Play319311045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos4040ui_story = arg_181_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).z)
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles = arg_181_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_181_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4040ui_story"].transform.position).z)
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["4040ui_story"].transform.localEulerAngles = arg_181_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["4040ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect4040ui_story == nil then
				arg_181_1.var_.characterEffect4040ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect4040ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect4040ui_story then
				arg_181_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["10079ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10079ui_story = var_184_4.localPosition
			end

			local var_184_5 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 then
				var_184_4.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_5)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 then
				var_184_4.localPosition = Vector3.New(0, 100, 0)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			local var_184_6 = arg_181_1.actors_["10079ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_7 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 and not isNil(var_184_6) then
				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_7)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect10079ui_story then
				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_8 = 0
			local var_184_9 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(319311044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 34 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 34)

				if (34 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 34)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311044", "story_v_out_319311.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311044", "story_v_out_319311.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_319311", "319311044", "story_v_out_319311.awb")

						arg_181_1:RecordAudio("319311044", var_184_15)
						arg_181_1:RecordAudio("319311044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319311", "319311044", "story_v_out_319311.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319311", "319311044", "story_v_out_319311.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319311045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319311045
		arg_185_1.duration_ = 2

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319311046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10079ui_story = arg_185_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).z)
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles = arg_185_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_185_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10079ui_story"].transform.position).z)
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10079ui_story"].transform.localEulerAngles = arg_185_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["10079ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10079ui_story == nil then
				arg_185_1.var_.characterEffect10079ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect10079ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10079ui_story then
				arg_185_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_188_4 = arg_185_1.actors_["4040ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos4040ui_story = var_188_4.localPosition
			end

			local var_188_5 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 then
				var_188_4.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_5)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 then
				var_188_4.localPosition = Vector3.New(0, 100, 0)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			local var_188_6 = arg_185_1.actors_["4040ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect4040ui_story == nil then
				arg_185_1.var_.characterEffect4040ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect4040ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_185_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect4040ui_story then
				arg_185_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_185_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_188_8 = 0
			local var_188_9 = 0.075

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(319311045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 3 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 3)

				if (3 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 3)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311045", "story_v_out_319311.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311045", "story_v_out_319311.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_319311", "319311045", "story_v_out_319311.awb")

						arg_185_1:RecordAudio("319311045", var_188_15)
						arg_185_1:RecordAudio("319311045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319311", "319311045", "story_v_out_319311.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319311", "319311045", "story_v_out_319311.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_185_1:InitPlayNodeList()
	end,
	Play319311046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319311046
		arg_189_1.duration_ = 3.3

		local var_189_0 = {
			zh = 2.566,
			ja = 3.3
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
				arg_189_0:Play319311047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1095ui_story = arg_189_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).z)
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles = arg_189_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_189_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1095ui_story"].transform.position).z)
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1095ui_story"].transform.localEulerAngles = arg_189_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1095ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_4 = arg_189_1.actors_["10079ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10079ui_story = var_192_4.localPosition
			end

			local var_192_5 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_5 then
				var_192_4.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_189_1.time_ - 0) / var_192_5)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_5 and arg_189_1.time_ < 0 + var_192_5 + arg_192_0 then
				var_192_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			local var_192_6 = arg_189_1.actors_["10079ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect10079ui_story == nil then
				arg_189_1.var_.characterEffect10079ui_story = var_192_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_7 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 and not isNil(var_192_6) then
				if arg_189_1.var_.characterEffect10079ui_story and not isNil(var_192_6) then
					arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_7)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect10079ui_story then
				arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_192_8 = 0
			local var_192_9 = 0.175

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(319311046)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 7 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 7)

				if (7 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 7)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311046", "story_v_out_319311.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311046", "story_v_out_319311.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_319311", "319311046", "story_v_out_319311.awb")

						arg_189_1:RecordAudio("319311046", var_192_15)
						arg_189_1:RecordAudio("319311046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319311", "319311046", "story_v_out_319311.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319311", "319311046", "story_v_out_319311.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319311047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319311047
		arg_193_1.duration_ = 8.13

		local var_193_0 = {
			zh = 8.133,
			ja = 7.466
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
				arg_193_0:Play319311048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.9

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(319311047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 36)

				if (36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 36)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311047", "story_v_out_319311.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_319311", "319311047", "story_v_out_319311.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_319311", "319311047", "story_v_out_319311.awb")

						arg_193_1:RecordAudio("319311047", var_196_6)
						arg_193_1:RecordAudio("319311047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319311", "319311047", "story_v_out_319311.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319311", "319311047", "story_v_out_319311.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319311048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319311048
		arg_197_1.duration_ = 4.87

		local var_197_0 = {
			zh = 2.6,
			ja = 4.866
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
				arg_197_0:Play319311049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos4040ui_story = arg_197_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).z)
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles = arg_197_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_197_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4040ui_story"].transform.position).z)
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["4040ui_story"].transform.localEulerAngles = arg_197_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["4040ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4040ui_story == nil then
				arg_197_1.var_.characterEffect4040ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect4040ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4040ui_story then
				arg_197_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1095ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1095ui_story = var_200_4.localPosition
			end

			local var_200_5 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 then
				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_5)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(0, 100, 0)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			local var_200_6 = arg_197_1.actors_["1095ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 and not isNil(var_200_6) then
				if arg_197_1.var_.characterEffect1095ui_story and not isNil(var_200_6) then
					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_7)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1095ui_story then
				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_200_8 = arg_197_1.actors_["10079ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10079ui_story = var_200_8.localPosition
			end

			local var_200_9 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_9 then
				var_200_8.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_9)
				var_200_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_8.position).x, (manager.ui.mainCamera.transform.position - var_200_8.position).y, (manager.ui.mainCamera.transform.position - var_200_8.position).z)
				var_200_8.localEulerAngles.z = 0
				var_200_8.localEulerAngles.x = 0
				var_200_8.localEulerAngles = var_200_8.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_9 and arg_197_1.time_ < 0 + var_200_9 + arg_200_0 then
				var_200_8.localPosition = Vector3.New(0, 100, 0)
				var_200_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_8.position).x, (manager.ui.mainCamera.transform.position - var_200_8.position).y, (manager.ui.mainCamera.transform.position - var_200_8.position).z)
				var_200_8.localEulerAngles.z = 0
				var_200_8.localEulerAngles.x = 0
				var_200_8.localEulerAngles = var_200_8.localEulerAngles
			end

			local var_200_10 = arg_197_1.actors_["10079ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_10) and arg_197_1.var_.characterEffect10079ui_story == nil then
				arg_197_1.var_.characterEffect10079ui_story = var_200_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_11 and not isNil(var_200_10) then
				if arg_197_1.var_.characterEffect10079ui_story and not isNil(var_200_10) then
					arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_11)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_11 and arg_197_1.time_ < 0 + var_200_11 + arg_200_0 and not isNil(var_200_10) and arg_197_1.var_.characterEffect10079ui_story then
				arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_12 = 0
			local var_200_13 = 0.125

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_14 = arg_197_1:GetWordFromCfg(319311048)
				local var_200_15 = arg_197_1:FormatText(var_200_14.content)

				arg_197_1.text_.text = var_200_15

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 5 <= 0 and var_200_13 or var_200_13 * (utf8.len(var_200_15) / 5)

				if (5 <= 0 and var_200_13 or var_200_13 * (utf8.len(var_200_15) / 5)) > 0 and var_200_13 < var_200_17 then
					arg_197_1.talkMaxDuration = var_200_17

					if var_200_17 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_17 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_15
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311048", "story_v_out_319311.awb") ~= 0 then
					local var_200_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311048", "story_v_out_319311.awb") / 1000

					if var_200_18 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_12
					end

					if var_200_14.prefab_name ~= "" and arg_197_1.actors_[var_200_14.prefab_name] ~= nil then
						local var_200_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_14.prefab_name].transform, "story_v_out_319311", "319311048", "story_v_out_319311.awb")

						arg_197_1:RecordAudio("319311048", var_200_19)
						arg_197_1:RecordAudio("319311048", var_200_19)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319311", "319311048", "story_v_out_319311.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319311", "319311048", "story_v_out_319311.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_20 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_20 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_20

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_20 and arg_197_1.time_ < var_200_12 + var_200_20 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319311049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319311049
		arg_201_1.duration_ = 5.2

		local var_201_0 = {
			zh = 5.2,
			ja = 5.066
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
				arg_201_0:Play319311050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10079ui_story = arg_201_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).z)
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles = arg_201_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_201_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10079ui_story"].transform.position).z)
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10079ui_story"].transform.localEulerAngles = arg_201_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["10079ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10079ui_story == nil then
				arg_201_1.var_.characterEffect10079ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect10079ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10079ui_story then
				arg_201_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_204_4 = arg_201_1.actors_["4040ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos4040ui_story = var_204_4.localPosition
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_4.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_5)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_4.localPosition = Vector3.New(0, 100, 0)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			local var_204_6 = arg_201_1.actors_["4040ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect4040ui_story == nil then
				arg_201_1.var_.characterEffect4040ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_7 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 and not isNil(var_204_6) then
				if arg_201_1.var_.characterEffect4040ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_201_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_7)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect4040ui_story then
				arg_201_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_201_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_204_8 = 0
			local var_204_9 = 0.675

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(319311049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 27 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 27)

				if (27 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 27)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311049", "story_v_out_319311.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311049", "story_v_out_319311.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_319311", "319311049", "story_v_out_319311.awb")

						arg_201_1:RecordAudio("319311049", var_204_15)
						arg_201_1:RecordAudio("319311049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319311", "319311049", "story_v_out_319311.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319311", "319311049", "story_v_out_319311.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_201_1:InitPlayNodeList()
	end,
	Play319311050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319311050
		arg_205_1.duration_ = 9.7

		local var_205_0 = {
			zh = 4.766,
			ja = 9.7
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
				arg_205_0:Play319311051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.6

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(319311050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 24 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 24)

				if (24 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 24)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311050", "story_v_out_319311.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_319311", "319311050", "story_v_out_319311.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_319311", "319311050", "story_v_out_319311.awb")

						arg_205_1:RecordAudio("319311050", var_208_6)
						arg_205_1:RecordAudio("319311050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319311", "319311050", "story_v_out_319311.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319311", "319311050", "story_v_out_319311.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319311051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319311051
		arg_209_1.duration_ = 6.23

		local var_209_0 = {
			zh = 4.166,
			ja = 6.233
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
				arg_209_0:Play319311052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1095ui_story = arg_209_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).z)
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles = arg_209_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_209_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1095ui_story"].transform.position).z)
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1095ui_story"].transform.localEulerAngles = arg_209_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1095ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1095ui_story == nil then
				arg_209_1.var_.characterEffect1095ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1095ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1095ui_story then
				arg_209_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_4 = arg_209_1.actors_["10079ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10079ui_story = var_212_4.localPosition
			end

			local var_212_5 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 then
				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_5)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(0, 100, 0)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			local var_212_6 = arg_209_1.actors_["10079ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10079ui_story == nil then
				arg_209_1.var_.characterEffect10079ui_story = var_212_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_7 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 and not isNil(var_212_6) then
				if arg_209_1.var_.characterEffect10079ui_story and not isNil(var_212_6) then
					arg_209_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_7)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10079ui_story then
				arg_209_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_212_8 = 0
			local var_212_9 = 0.425

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(319311051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 17 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 17)

				if (17 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 17)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311051", "story_v_out_319311.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311051", "story_v_out_319311.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_319311", "319311051", "story_v_out_319311.awb")

						arg_209_1:RecordAudio("319311051", var_212_15)
						arg_209_1:RecordAudio("319311051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319311", "319311051", "story_v_out_319311.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319311", "319311051", "story_v_out_319311.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319311052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319311052
		arg_213_1.duration_ = 5.5

		local var_213_0 = {
			zh = 5.1,
			ja = 5.5
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
				arg_213_0:Play319311053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1095ui_story"]) and arg_213_1.var_.characterEffect1095ui_story == nil then
				arg_213_1.var_.characterEffect1095ui_story = arg_213_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1095ui_story"]) then
				if arg_213_1.var_.characterEffect1095ui_story and not isNil(arg_213_1.actors_["1095ui_story"]) then
					arg_213_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1095ui_story"]) and arg_213_1.var_.characterEffect1095ui_story then
				arg_213_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(319311052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 27 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 27)

				if (27 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 27)) > 0 and var_216_2 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311052", "story_v_out_319311.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_319311", "319311052", "story_v_out_319311.awb") / 1000

					if var_216_7 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_1
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_319311", "319311052", "story_v_out_319311.awb")

						arg_213_1:RecordAudio("319311052", var_216_8)
						arg_213_1:RecordAudio("319311052", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319311", "319311052", "story_v_out_319311.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319311", "319311052", "story_v_out_319311.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_9 and arg_213_1.time_ < var_216_1 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319311053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319311053
		arg_217_1.duration_ = 7.07

		local var_217_0 = {
			zh = 6.466,
			ja = 7.066
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319311054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) and arg_217_1.var_.characterEffect1095ui_story == nil then
				arg_217_1.var_.characterEffect1095ui_story = arg_217_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) then
				if arg_217_1.var_.characterEffect1095ui_story and not isNil(arg_217_1.actors_["1095ui_story"]) then
					arg_217_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) and arg_217_1.var_.characterEffect1095ui_story then
				arg_217_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_220_2 = 0
			local var_220_3 = 0.675

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(319311053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 27)

				if (27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 27)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311053", "story_v_out_319311.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311053", "story_v_out_319311.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_319311", "319311053", "story_v_out_319311.awb")

						arg_217_1:RecordAudio("319311053", var_220_9)
						arg_217_1:RecordAudio("319311053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319311", "319311053", "story_v_out_319311.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319311", "319311053", "story_v_out_319311.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319311054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319311054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319311055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story == nil then
				arg_221_1.var_.characterEffect1095ui_story = arg_221_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) then
				if arg_221_1.var_.characterEffect1095ui_story and not isNil(arg_221_1.actors_["1095ui_story"]) then
					arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story then
				arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.875

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(319311054).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 35 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 35)

				if (35 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 35)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319311055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319311055
		arg_225_1.duration_ = 5.9

		local var_225_0 = {
			zh = 2.866,
			ja = 5.9
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
				arg_225_0:Play319311056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1095ui_story"]) and arg_225_1.var_.characterEffect1095ui_story == nil then
				arg_225_1.var_.characterEffect1095ui_story = arg_225_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1095ui_story"]) then
				if arg_225_1.var_.characterEffect1095ui_story and not isNil(arg_225_1.actors_["1095ui_story"]) then
					arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1095ui_story"]) and arg_225_1.var_.characterEffect1095ui_story then
				arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_228_2 = 0
			local var_228_3 = 0.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(319311055)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 11 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 11)

				if (11 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 11)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311055", "story_v_out_319311.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311055", "story_v_out_319311.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_319311", "319311055", "story_v_out_319311.awb")

						arg_225_1:RecordAudio("319311055", var_228_9)
						arg_225_1:RecordAudio("319311055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319311", "319311055", "story_v_out_319311.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319311", "319311055", "story_v_out_319311.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319311056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319311056
		arg_229_1.duration_ = 2.73

		local var_229_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
			arg_229_1.auto_ = false
		end

		function arg_229_1.playNext_(arg_231_0)
			arg_229_1.onStoryFinished_()
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos4040ui_story = arg_229_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).z)
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles = arg_229_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_229_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["4040ui_story"].transform.position).z)
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["4040ui_story"].transform.localEulerAngles = arg_229_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["4040ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect4040ui_story == nil then
				arg_229_1.var_.characterEffect4040ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect4040ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect4040ui_story then
				arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["1095ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1095ui_story = var_232_4.localPosition
			end

			local var_232_5 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				var_232_4.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_5)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				var_232_4.localPosition = Vector3.New(0, 100, 0)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			local var_232_6 = arg_229_1.actors_["1095ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1095ui_story == nil then
				arg_229_1.var_.characterEffect1095ui_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_7 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 and not isNil(var_232_6) then
				if arg_229_1.var_.characterEffect1095ui_story and not isNil(var_232_6) then
					arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_7)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1095ui_story then
				arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_232_8 = arg_229_1.actors_["10079ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10079ui_story = var_232_8.localPosition
			end

			local var_232_9 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_9 then
				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_9)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_9 and arg_229_1.time_ < 0 + var_232_9 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(0, 100, 0)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			local var_232_10 = arg_229_1.actors_["10079ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect10079ui_story == nil then
				arg_229_1.var_.characterEffect10079ui_story = var_232_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_11 and not isNil(var_232_10) then
				if arg_229_1.var_.characterEffect10079ui_story and not isNil(var_232_10) then
					arg_229_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_11)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_11 and arg_229_1.time_ < 0 + var_232_11 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect10079ui_story then
				arg_229_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_12 = 0
			local var_232_13 = 0.075

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(319311056)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 3 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 3)

				if (3 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 3)) > 0 and var_232_13 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311056", "story_v_out_319311.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311056", "story_v_out_319311.awb") / 1000

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_out_319311", "319311056", "story_v_out_319311.awb")

						arg_229_1:RecordAudio("319311056", var_232_19)
						arg_229_1:RecordAudio("319311056", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319311", "319311056", "story_v_out_319311.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319311", "319311056", "story_v_out_319311.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_20 and arg_229_1.time_ < var_232_12 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A08f"
	},
	voices = {
		"story_v_out_319311.awb"
	}
}
