return {
	Play116351001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116351001
		arg_1_1.duration_ = 5.03

		local var_1_0 = {
			zh = 4.3,
			ja = 5.033
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
				arg_1_0:Play116351002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_4_0.name = "ST03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = "10025ui_story"

			if arg_1_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_1_1.stage_.transform)

				var_4_5.name = var_4_4
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_4] = var_4_5

				local var_4_6 = var_4_5:GetComponentInChildren(typeof(CharacterEffect))

				var_4_6.enabled = true

				local var_4_7 = GameObjectTools.GetOrAddComponent(var_4_5, typeof(DynamicBoneHelper))

				if var_4_7 then
					var_4_7:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_6.transform, false)

				arg_1_1.var_[var_4_4 .. "Animator"] = var_4_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_8 = arg_1_1.actors_["10025ui_story"].transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.moveOldPos10025ui_story = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_1_1.time_ - 1.9) / var_4_9)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles
			end

			if arg_1_1.time_ >= 1.9 + var_4_9 and arg_1_1.time_ < 1.9 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, -1.1, -5.9)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles
			end

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_4_10 = arg_1_1.actors_["10025ui_story"]

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 and not isNil(var_4_10) and arg_1_1.var_.characterEffect10025ui_story == nil then
				arg_1_1.var_.characterEffect10025ui_story = var_4_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_11 = 0.2

			if 1.96666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.96666666666667 + var_4_11 and not isNil(var_4_10) then
				if arg_1_1.var_.characterEffect10025ui_story and not isNil(var_4_10) then
					arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.96666666666667 + var_4_11 and arg_1_1.time_ < 1.96666666666667 + var_4_11 + arg_4_0 and not isNil(var_4_10) and arg_1_1.var_.characterEffect10025ui_story then
				arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_14 = 2

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_14 then
				local var_4_15 = Color.New(0, 0, 0)

				var_4_15.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_13) / var_4_14)
				arg_1_1.mask_.color = var_4_15
			end

			if arg_1_1.time_ >= var_4_13 + var_4_14 and arg_1_1.time_ < var_4_13 + var_4_14 + arg_4_0 then
				local var_4_16 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_16.a = 0
				arg_1_1.mask_.color = var_4_16
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

			if 0.866666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.866666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_story_mood_daily", "bgm_story_mood_daily")

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(116351001)
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

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351001", "story_v_out_116351.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_116351", "116351001", "story_v_out_116351.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_116351", "116351001", "story_v_out_116351.awb")

						arg_1_1:RecordAudio("116351001", var_4_31)
						arg_1_1:RecordAudio("116351001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116351", "116351001", "story_v_out_116351.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116351", "116351001", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116351002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116351002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116351003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10025ui_story"]) and arg_9_1.var_.characterEffect10025ui_story == nil then
				arg_9_1.var_.characterEffect10025ui_story = arg_9_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10025ui_story"]) then
				if arg_9_1.var_.characterEffect10025ui_story and not isNil(arg_9_1.actors_["10025ui_story"]) then
					arg_9_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10025ui_story"]) and arg_9_1.var_.characterEffect10025ui_story then
				arg_9_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(116351002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 12 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 12)

				if (12 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 12)) > 0 and var_12_2 < var_12_5 then
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
	Play116351003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116351003
		arg_13_1.duration_ = 3.23

		local var_13_0 = {
			zh = 2.233,
			ja = 3.233
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
				arg_13_0:Play116351004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10025ui_story = arg_13_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).z)
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles = arg_13_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_13_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10025ui_story"].transform.position).z)
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10025ui_story"].transform.localEulerAngles = arg_13_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_16_1 = arg_13_1.actors_["10025ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10025ui_story == nil then
				arg_13_1.var_.characterEffect10025ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10025ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10025ui_story then
				arg_13_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action452")
			end

			local var_16_4 = 0
			local var_16_5 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(116351003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 9 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 9)

				if (9 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 9)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351003", "story_v_out_116351.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351003", "story_v_out_116351.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_116351", "116351003", "story_v_out_116351.awb")

						arg_13_1:RecordAudio("116351003", var_16_11)
						arg_13_1:RecordAudio("116351003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116351", "116351003", "story_v_out_116351.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116351", "116351003", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
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
	Play116351004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116351004
		arg_17_1.duration_ = 5.83

		local var_17_0 = {
			zh = 5.833,
			ja = 4.866
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
				arg_17_0:Play116351005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10025ui_story"]) and arg_17_1.var_.characterEffect10025ui_story == nil then
				arg_17_1.var_.characterEffect10025ui_story = arg_17_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10025ui_story"]) then
				if arg_17_1.var_.characterEffect10025ui_story and not isNil(arg_17_1.actors_["10025ui_story"]) then
					arg_17_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10025ui_story"]) and arg_17_1.var_.characterEffect10025ui_story then
				arg_17_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.675

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(116351004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 27 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 27)

				if (27 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 27)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351004", "story_v_out_116351.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351004", "story_v_out_116351.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_116351", "116351004", "story_v_out_116351.awb")

						arg_17_1:RecordAudio("116351004", var_20_8)
						arg_17_1:RecordAudio("116351004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116351", "116351004", "story_v_out_116351.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116351", "116351004", "story_v_out_116351.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116351005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116351005
		arg_21_1.duration_ = 4.47

		local var_21_0 = {
			zh = 3.666,
			ja = 4.466
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
				arg_21_0:Play116351006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10025ui_story = arg_21_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).z)
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles = arg_21_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_21_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10025ui_story"].transform.position).z)
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10025ui_story"].transform.localEulerAngles = arg_21_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_24_1 = arg_21_1.actors_["10025ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10025ui_story == nil then
				arg_21_1.var_.characterEffect10025ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10025ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10025ui_story then
				arg_21_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action427")
			end

			local var_24_4 = 0
			local var_24_5 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(116351005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 13 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 13)

				if (13 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 13)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351005", "story_v_out_116351.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351005", "story_v_out_116351.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_116351", "116351005", "story_v_out_116351.awb")

						arg_21_1:RecordAudio("116351005", var_24_11)
						arg_21_1:RecordAudio("116351005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116351", "116351005", "story_v_out_116351.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116351", "116351005", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
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
	Play116351006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116351006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116351007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10025ui_story"]) and arg_25_1.var_.characterEffect10025ui_story == nil then
				arg_25_1.var_.characterEffect10025ui_story = arg_25_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10025ui_story"]) then
				if arg_25_1.var_.characterEffect10025ui_story and not isNil(arg_25_1.actors_["10025ui_story"]) then
					arg_25_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10025ui_story"]) and arg_25_1.var_.characterEffect10025ui_story then
				arg_25_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.9

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(116351006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 36 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 36)

				if (36 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 36)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116351007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116351007
		arg_29_1.duration_ = 7.56

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116351008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.ST15 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_32_0.name = "ST15"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.ST15 = var_32_0
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.ST15

				arg_29_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST15" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 4
			local var_32_5 = manager.audio:GetVoiceLength("story_v_out_116351", "116351007", "story_v_out_116351.awb") / 1000

			if var_32_5 > 0 and 3.562 < var_32_5 and var_32_5 + var_32_4 > arg_29_1.duration_ then
				arg_29_1.duration_ = var_32_5 + var_32_4
			end

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:AudioAction("play", "voice", "story_v_out_116351", "116351007", "story_v_out_116351.awb")
			end

			local var_32_7 = arg_29_1.actors_["10025ui_story"].transform

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				arg_29_1.var_.moveOldPos10025ui_story = var_32_7.localPosition
			end

			local var_32_8 = 0.001

			if 2 <= arg_29_1.time_ and arg_29_1.time_ < 2 + var_32_8 then
				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 2) / var_32_8)
				var_32_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_7.position).x, (manager.ui.mainCamera.transform.position - var_32_7.position).y, (manager.ui.mainCamera.transform.position - var_32_7.position).z)
				var_32_7.localEulerAngles.z = 0
				var_32_7.localEulerAngles.x = 0
				var_32_7.localEulerAngles = var_32_7.localEulerAngles
			end

			if arg_29_1.time_ >= 2 + var_32_8 and arg_29_1.time_ < 2 + var_32_8 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, 100, 0)
				var_32_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_7.position).x, (manager.ui.mainCamera.transform.position - var_32_7.position).y, (manager.ui.mainCamera.transform.position - var_32_7.position).z)
				var_32_7.localEulerAngles.z = 0
				var_32_7.localEulerAngles.x = 0
				var_32_7.localEulerAngles = var_32_7.localEulerAngles
			end

			local var_32_9 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_10 = 2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 then
				local var_32_11 = Color.New(0, 0, 0)

				var_32_11.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_9) / var_32_10)
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 then
				local var_32_12 = Color.New(0, 0, 0)

				var_32_12.a = 1
				arg_29_1.mask_.color = var_32_12
			end

			local var_32_13 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_14 = 2

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_14 then
				local var_32_15 = Color.New(0, 0, 0)

				var_32_15.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_13) / var_32_14)
				arg_29_1.mask_.color = var_32_15
			end

			if arg_29_1.time_ >= var_32_13 + var_32_14 and arg_29_1.time_ < var_32_13 + var_32_14 + arg_32_0 then
				local var_32_16 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_16.a = 0
				arg_29_1.mask_.color = var_32_16
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				arg_29_1.fswbg_:SetActive(true)
				arg_29_1.dialog_:SetActive(false)

				arg_29_1.fswtw_.percent = 0
				arg_29_1.fswt_.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(116351007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.fswt_)

				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_29_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_29_1.fswtw_:SetDirty()

				arg_29_1.typewritterCharCountI18N = 0

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_17 = 4

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.oldValueTypewriter = arg_29_1.fswtw_.percent

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_18 = 13
			local var_32_19 = 0.866666666666667
			local var_32_20, var_32_21 = arg_29_1:GetPercentByPara(arg_29_1:FormatText(arg_29_1:GetWordFromCfg(116351007).content), 1)

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				local var_32_22 = var_32_18 <= 0 and var_32_19 or var_32_19 * ((var_32_21 - arg_29_1.typewritterCharCountI18N) / var_32_18)

				if (var_32_18 <= 0 and var_32_19 or var_32_19 * ((var_32_21 - arg_29_1.typewritterCharCountI18N) / var_32_18)) > 0 and var_32_19 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_17
					end
				end
			end

			local var_32_23 = math.max(0.866666666666667, arg_29_1.talkMaxDuration)

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_23 then
				arg_29_1.fswtw_.percent = Mathf.Lerp(arg_29_1.var_.oldValueTypewriter, var_32_20, (arg_29_1.time_ - var_32_17) / var_32_23)
				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_29_1.fswtw_:SetDirty()
			end

			if arg_29_1.time_ >= var_32_17 + var_32_23 and arg_29_1.time_ < var_32_17 + var_32_23 + arg_32_0 then
				arg_29_1.fswtw_.percent = var_32_20

				arg_29_1.fswtw_:SetDirty()
				arg_29_1:ShowNextGo(true)

				arg_29_1.typewritterCharCountI18N = var_32_21
			end

			local var_32_24 = 4

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_24 + 0.866666666666667 and arg_29_1.time_ < var_32_24 + 0.866666666666667 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play116351008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116351008
		arg_33_1.duration_ = 9.03

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116351009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.oldValueTypewriter = arg_33_1.fswtw_.percent

				SetActive(arg_33_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_33_1:ShowNextGo(false)
			end

			local var_36_0 = 32
			local var_36_1 = 2.13333333333333
			local var_36_2, var_36_3 = arg_33_1:GetPercentByPara(arg_33_1:FormatText(arg_33_1:GetWordFromCfg(116351007).content), 2)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				local var_36_4 = var_36_0 <= 0 and var_36_1 or var_36_1 * ((var_36_3 - arg_33_1.typewritterCharCountI18N) / var_36_0)

				if (var_36_0 <= 0 and var_36_1 or var_36_1 * ((var_36_3 - arg_33_1.typewritterCharCountI18N) / var_36_0)) > 0 and var_36_1 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end
			end

			local var_36_5 = math.max(2.13333333333333, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				arg_33_1.fswtw_.percent = Mathf.Lerp(arg_33_1.var_.oldValueTypewriter, var_36_2, (arg_33_1.time_ - 0) / var_36_5)
				arg_33_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_33_1.fswtw_:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				arg_33_1.fswtw_.percent = var_36_2

				arg_33_1.fswtw_:SetDirty()
				arg_33_1:ShowNextGo(true)

				arg_33_1.typewritterCharCountI18N = var_36_3
			end

			local var_36_6 = 0
			local var_36_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351008", "story_v_out_116351.awb") / 1000

			if var_36_7 > 0 and 9.027 < var_36_7 and var_36_7 + var_36_6 > arg_33_1.duration_ then
				arg_33_1.duration_ = var_36_7 + var_36_6
			end

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1:AudioAction("play", "voice", "story_v_out_116351", "116351008", "story_v_out_116351.awb")
			end

			local var_36_9 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			if arg_33_1.time_ >= var_36_9 + 2.13333333333333 and arg_33_1.time_ < var_36_9 + 2.13333333333333 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116351009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116351009
		arg_37_1.duration_ = 16.03

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116351010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.oldValueTypewriter = arg_37_1.fswtw_.percent

				SetActive(arg_37_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_37_1:ShowNextGo(false)
			end

			local var_40_0 = 52
			local var_40_1 = 3.46666666666667
			local var_40_2, var_40_3 = arg_37_1:GetPercentByPara(arg_37_1:FormatText(arg_37_1:GetWordFromCfg(116351007).content), 3)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				local var_40_4 = var_40_0 <= 0 and var_40_1 or var_40_1 * ((var_40_3 - arg_37_1.typewritterCharCountI18N) / var_40_0)

				if (var_40_0 <= 0 and var_40_1 or var_40_1 * ((var_40_3 - arg_37_1.typewritterCharCountI18N) / var_40_0)) > 0 and var_40_1 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end
			end

			local var_40_5 = math.max(3.46666666666667, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 then
				arg_37_1.fswtw_.percent = Mathf.Lerp(arg_37_1.var_.oldValueTypewriter, var_40_2, (arg_37_1.time_ - 0) / var_40_5)
				arg_37_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_37_1.fswtw_:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 then
				arg_37_1.fswtw_.percent = var_40_2

				arg_37_1.fswtw_:SetDirty()
				arg_37_1:ShowNextGo(true)

				arg_37_1.typewritterCharCountI18N = var_40_3
			end

			local var_40_6 = 0
			local var_40_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351009", "story_v_out_116351.awb") / 1000

			if var_40_7 > 0 and 16.027 < var_40_7 and var_40_7 + var_40_6 > arg_37_1.duration_ then
				arg_37_1.duration_ = var_40_7 + var_40_6
			end

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1:AudioAction("play", "voice", "story_v_out_116351", "116351009", "story_v_out_116351.awb")
			end

			local var_40_9 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_9 + 3.46666666666667 and arg_37_1.time_ < var_40_9 + 3.46666666666667 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116351010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116351010
		arg_41_1.duration_ = 1.85

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116351011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.oldValueTypewriter = arg_41_1.fswtw_.percent

				SetActive(arg_41_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_41_1:ShowNextGo(false)
			end

			local var_44_0 = 10
			local var_44_1 = 0.666666666666667
			local var_44_2, var_44_3 = arg_41_1:GetPercentByPara(arg_41_1:FormatText(arg_41_1:GetWordFromCfg(116351007).content), 4)

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				local var_44_4 = var_44_0 <= 0 and var_44_1 or var_44_1 * ((var_44_3 - arg_41_1.typewritterCharCountI18N) / var_44_0)

				if (var_44_0 <= 0 and var_44_1 or var_44_1 * ((var_44_3 - arg_41_1.typewritterCharCountI18N) / var_44_0)) > 0 and var_44_1 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end
			end

			local var_44_5 = math.max(0.666666666666667, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				arg_41_1.fswtw_.percent = Mathf.Lerp(arg_41_1.var_.oldValueTypewriter, var_44_2, (arg_41_1.time_ - 0) / var_44_5)
				arg_41_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_41_1.fswtw_:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				arg_41_1.fswtw_.percent = var_44_2

				arg_41_1.fswtw_:SetDirty()
				arg_41_1:ShowNextGo(true)

				arg_41_1.typewritterCharCountI18N = var_44_3
			end

			local var_44_6 = 0
			local var_44_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351010", "story_v_out_116351.awb") / 1000

			if var_44_7 > 0 and 1.852 < var_44_7 and var_44_7 + var_44_6 > arg_41_1.duration_ then
				arg_41_1.duration_ = var_44_7 + var_44_6
			end

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1:AudioAction("play", "voice", "story_v_out_116351", "116351010", "story_v_out_116351.awb")
			end

			local var_44_9 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_9 + 1.852 and arg_41_1.time_ < var_44_9 + 1.852 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play116351011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116351011
		arg_45_1.duration_ = 10.85

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116351012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.oldValueTypewriter = arg_45_1.fswtw_.percent

				SetActive(arg_45_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_45_1:ShowNextGo(false)
			end

			local var_48_0 = 42
			local var_48_1 = 2.8
			local var_48_2, var_48_3 = arg_45_1:GetPercentByPara(arg_45_1:FormatText(arg_45_1:GetWordFromCfg(116351007).content), 5)

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				local var_48_4 = var_48_0 <= 0 and var_48_1 or var_48_1 * ((var_48_3 - arg_45_1.typewritterCharCountI18N) / var_48_0)

				if (var_48_0 <= 0 and var_48_1 or var_48_1 * ((var_48_3 - arg_45_1.typewritterCharCountI18N) / var_48_0)) > 0 and var_48_1 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end
			end

			local var_48_5 = math.max(2.8, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				arg_45_1.fswtw_.percent = Mathf.Lerp(arg_45_1.var_.oldValueTypewriter, var_48_2, (arg_45_1.time_ - 0) / var_48_5)
				arg_45_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_45_1.fswtw_:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				arg_45_1.fswtw_.percent = var_48_2

				arg_45_1.fswtw_:SetDirty()
				arg_45_1:ShowNextGo(true)

				arg_45_1.typewritterCharCountI18N = var_48_3
			end

			local var_48_6 = 0
			local var_48_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351011", "story_v_out_116351.awb") / 1000

			if var_48_7 > 0 and 10.849 < var_48_7 and var_48_7 + var_48_6 > arg_45_1.duration_ then
				arg_45_1.duration_ = var_48_7 + var_48_6
			end

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1:AudioAction("play", "voice", "story_v_out_116351", "116351011", "story_v_out_116351.awb")
			end

			local var_48_9 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_9 + 2.8 and arg_45_1.time_ < var_48_9 + 2.8 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116351012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116351012
		arg_49_1.duration_ = 13.23

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116351013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.oldValueTypewriter = arg_49_1.fswtw_.percent

				SetActive(arg_49_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_49_1:ShowNextGo(false)
			end

			local var_52_0 = 47
			local var_52_1 = 3.13333333333333
			local var_52_2, var_52_3 = arg_49_1:GetPercentByPara(arg_49_1:FormatText(arg_49_1:GetWordFromCfg(116351007).content), 6)

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				local var_52_4 = var_52_0 <= 0 and var_52_1 or var_52_1 * ((var_52_3 - arg_49_1.typewritterCharCountI18N) / var_52_0)

				if (var_52_0 <= 0 and var_52_1 or var_52_1 * ((var_52_3 - arg_49_1.typewritterCharCountI18N) / var_52_0)) > 0 and var_52_1 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end
			end

			local var_52_5 = math.max(3.13333333333333, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				arg_49_1.fswtw_.percent = Mathf.Lerp(arg_49_1.var_.oldValueTypewriter, var_52_2, (arg_49_1.time_ - 0) / var_52_5)
				arg_49_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_49_1.fswtw_:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				arg_49_1.fswtw_.percent = var_52_2

				arg_49_1.fswtw_:SetDirty()
				arg_49_1:ShowNextGo(true)

				arg_49_1.typewritterCharCountI18N = var_52_3
			end

			local var_52_6 = 0
			local var_52_7 = manager.audio:GetVoiceLength("story_v_out_116351", "116351012", "story_v_out_116351.awb") / 1000

			if var_52_7 > 0 and 13.233 < var_52_7 and var_52_7 + var_52_6 > arg_49_1.duration_ then
				arg_49_1.duration_ = var_52_7 + var_52_6
			end

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1:AudioAction("play", "voice", "story_v_out_116351", "116351012", "story_v_out_116351.awb")
			end

			local var_52_9 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_9 + 3.13333333333333 and arg_49_1.time_ < var_52_9 + 3.13333333333333 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116351013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116351013
		arg_53_1.duration_ = 9

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116351014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 1.98333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 1.98333333333333 + arg_56_0 then
				arg_53_1.fswbg_:SetActive(false)
				arg_53_1.dialog_:SetActive(false)
				SetActive(arg_53_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_53_1:ShowNextGo(false)
			end

			local var_56_0 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_1 = 2

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_1 then
				local var_56_2 = Color.New(0, 0, 0)

				var_56_2.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_0) / var_56_1)
				arg_53_1.mask_.color = var_56_2
			end

			if arg_53_1.time_ >= var_56_0 + var_56_1 and arg_53_1.time_ < var_56_0 + var_56_1 + arg_56_0 then
				local var_56_3 = Color.New(0, 0, 0)

				var_56_3.a = 1
				arg_53_1.mask_.color = var_56_3
			end

			local var_56_4 = 2

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_5 = 2

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_5 then
				local var_56_6 = Color.New(0, 0, 0)

				var_56_6.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_4) / var_56_5)
				arg_53_1.mask_.color = var_56_6
			end

			if arg_53_1.time_ >= var_56_4 + var_56_5 and arg_53_1.time_ < var_56_4 + var_56_5 + arg_56_0 then
				local var_56_7 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_7.a = 0
				arg_53_1.mask_.color = var_56_7
			end

			local var_56_8 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_8 + 4.5 and arg_53_1.time_ < var_56_8 + 4.5 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_9 = 4
			local var_56_10 = 0.5

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_11 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_11:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_12 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(116351013).content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_14 = 20 <= 0 and var_56_10 or var_56_10 * (utf8.len(var_56_12) / 20)

				if (20 <= 0 and var_56_10 or var_56_10 * (utf8.len(var_56_12) / 20)) > 0 and var_56_10 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14
					var_56_9 = var_56_9 + 0.3

					if var_56_14 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = var_56_9 + 0.3
			local var_56_16 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116351014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116351014
		arg_59_1.duration_ = 14.83

		local var_59_0 = {
			zh = 14.833,
			ja = 11.233
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
				arg_59_0:Play116351015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10025ui_story = arg_59_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).z)
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles = arg_59_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_59_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).z)
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles = arg_59_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_62_1 = arg_59_1.actors_["10025ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10025ui_story == nil then
				arg_59_1.var_.characterEffect10025ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect10025ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10025ui_story then
				arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_62_4 = 0
			local var_62_5 = 1.05

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(116351014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 42 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 42)

				if (42 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 42)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351014", "story_v_out_116351.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351014", "story_v_out_116351.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_116351", "116351014", "story_v_out_116351.awb")

						arg_59_1:RecordAudio("116351014", var_62_11)
						arg_59_1:RecordAudio("116351014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116351", "116351014", "story_v_out_116351.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116351", "116351014", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116351015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116351015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116351016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = arg_63_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) then
				if arg_63_1.var_.characterEffect10025ui_story and not isNil(arg_63_1.actors_["10025ui_story"]) then
					arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story then
				arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.325

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(116351015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 13 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 13)

				if (13 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 13)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116351016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116351016
		arg_67_1.duration_ = 11.8

		local var_67_0 = {
			zh = 11.8,
			ja = 10.633
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
				arg_67_0:Play116351017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10025ui_story = arg_67_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).z)
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles = arg_67_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_67_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).z)
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles = arg_67_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_70_1 = arg_67_1.actors_["10025ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect10025ui_story == nil then
				arg_67_1.var_.characterEffect10025ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect10025ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect10025ui_story then
				arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 1.05

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(116351016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 42 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 42)

				if (42 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 42)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351016", "story_v_out_116351.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351016", "story_v_out_116351.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_116351", "116351016", "story_v_out_116351.awb")

						arg_67_1:RecordAudio("116351016", var_70_11)
						arg_67_1:RecordAudio("116351016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116351", "116351016", "story_v_out_116351.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116351", "116351016", "story_v_out_116351.awb")
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

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play116351017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116351017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116351018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = arg_71_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) then
				if arg_71_1.var_.characterEffect10025ui_story and not isNil(arg_71_1.actors_["10025ui_story"]) then
					arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) and arg_71_1.var_.characterEffect10025ui_story then
				arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.325

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(116351017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 13 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 13)

				if (13 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 13)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116351018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116351018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116351019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.975

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116351018).content)

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
	Play116351019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116351019
		arg_79_1.duration_ = 3.7

		local var_79_0 = {
			zh = 3.433,
			ja = 3.7
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
				arg_79_0:Play116351020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10025ui_story = arg_79_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).z)
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles = arg_79_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_79_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).z)
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles = arg_79_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_1 = arg_79_1.actors_["10025ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10025ui_story == nil then
				arg_79_1.var_.characterEffect10025ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10025ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10025ui_story then
				arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_82_4 = 0
			local var_82_5 = 0.225

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(116351019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 9 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 9)

				if (9 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 9)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351019", "story_v_out_116351.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351019", "story_v_out_116351.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_116351", "116351019", "story_v_out_116351.awb")

						arg_79_1:RecordAudio("116351019", var_82_11)
						arg_79_1:RecordAudio("116351019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116351", "116351019", "story_v_out_116351.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116351", "116351019", "story_v_out_116351.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play116351020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116351020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116351021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = arg_83_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) then
				if arg_83_1.var_.characterEffect10025ui_story and not isNil(arg_83_1.actors_["10025ui_story"]) then
					arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story then
				arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 1.075

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(116351020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 43)

				if (43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 43)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116351021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116351021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116351022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.825

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(116351021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 33 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 33)

				if (33 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 33)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116351022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116351022
		arg_91_1.duration_ = 6.97

		local var_91_0 = {
			zh = 6.966,
			ja = 6.266
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
				arg_91_0:Play116351023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10025ui_story = arg_91_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).z)
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles = arg_91_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_91_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10025ui_story"].transform.position).z)
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10025ui_story"].transform.localEulerAngles = arg_91_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_94_1 = arg_91_1.actors_["10025ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10025ui_story == nil then
				arg_91_1.var_.characterEffect10025ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10025ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10025ui_story then
				arg_91_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_94_4 = 0
			local var_94_5 = 0.575

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(116351022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 23 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 23)

				if (23 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 23)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351022", "story_v_out_116351.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351022", "story_v_out_116351.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_116351", "116351022", "story_v_out_116351.awb")

						arg_91_1:RecordAudio("116351022", var_94_11)
						arg_91_1:RecordAudio("116351022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116351", "116351022", "story_v_out_116351.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116351", "116351022", "story_v_out_116351.awb")
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

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
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
	Play116351023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116351023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116351024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) and arg_95_1.var_.characterEffect10025ui_story == nil then
				arg_95_1.var_.characterEffect10025ui_story = arg_95_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) then
				if arg_95_1.var_.characterEffect10025ui_story and not isNil(arg_95_1.actors_["10025ui_story"]) then
					arg_95_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) and arg_95_1.var_.characterEffect10025ui_story then
				arg_95_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(116351023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 22 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 22)

				if (22 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 22)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116351024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116351024
		arg_99_1.duration_ = 2.47

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116351025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10025ui_story = arg_99_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).z)
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles = arg_99_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_99_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).z)
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles = arg_99_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_102_1 = arg_99_1.actors_["10025ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10025ui_story == nil then
				arg_99_1.var_.characterEffect10025ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10025ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10025ui_story then
				arg_99_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_102_4 = 0
			local var_102_5 = 0.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(116351024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 4 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 4)

				if (4 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 4)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351024", "story_v_out_116351.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351024", "story_v_out_116351.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_116351", "116351024", "story_v_out_116351.awb")

						arg_99_1:RecordAudio("116351024", var_102_11)
						arg_99_1:RecordAudio("116351024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116351", "116351024", "story_v_out_116351.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116351", "116351024", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
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
	Play116351025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116351025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116351026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10025ui_story"]) and arg_103_1.var_.characterEffect10025ui_story == nil then
				arg_103_1.var_.characterEffect10025ui_story = arg_103_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10025ui_story"]) then
				if arg_103_1.var_.characterEffect10025ui_story and not isNil(arg_103_1.actors_["10025ui_story"]) then
					arg_103_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10025ui_story"]) and arg_103_1.var_.characterEffect10025ui_story then
				arg_103_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.3

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(116351025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 12 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 12)

				if (12 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 12)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play116351026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 116351026
		arg_107_1.duration_ = 2.4

		local var_107_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_107_0:Play116351027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10025ui_story = arg_107_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).z)
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles = arg_107_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_107_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10025ui_story"].transform.position).z)
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10025ui_story"].transform.localEulerAngles = arg_107_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_110_1 = arg_107_1.actors_["10025ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10025ui_story == nil then
				arg_107_1.var_.characterEffect10025ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect10025ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10025ui_story then
				arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_110_4 = 0
			local var_110_5 = 0.1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(116351026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)

				if (4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351026", "story_v_out_116351.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351026", "story_v_out_116351.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_116351", "116351026", "story_v_out_116351.awb")

						arg_107_1:RecordAudio("116351026", var_110_11)
						arg_107_1:RecordAudio("116351026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_116351", "116351026", "story_v_out_116351.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_116351", "116351026", "story_v_out_116351.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play116351027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116351027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116351028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10025ui_story"]) and arg_111_1.var_.characterEffect10025ui_story == nil then
				arg_111_1.var_.characterEffect10025ui_story = arg_111_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10025ui_story"]) then
				if arg_111_1.var_.characterEffect10025ui_story and not isNil(arg_111_1.actors_["10025ui_story"]) then
					arg_111_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10025ui_story"]) and arg_111_1.var_.characterEffect10025ui_story then
				arg_111_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.425

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(116351027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 17 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 17)

				if (17 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 17)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116351028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116351028
		arg_115_1.duration_ = 12.77

		local var_115_0 = {
			zh = 7.466,
			ja = 12.766
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
				arg_115_0:Play116351029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10025ui_story = arg_115_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).z)
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles = arg_115_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_115_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10025ui_story"].transform.position).z)
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10025ui_story"].transform.localEulerAngles = arg_115_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_1 = arg_115_1.actors_["10025ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10025ui_story == nil then
				arg_115_1.var_.characterEffect10025ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect10025ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10025ui_story then
				arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_118_4 = 0
			local var_118_5 = 0.75

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(116351028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 29 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 29)

				if (29 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 29)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351028", "story_v_out_116351.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351028", "story_v_out_116351.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_116351", "116351028", "story_v_out_116351.awb")

						arg_115_1:RecordAudio("116351028", var_118_11)
						arg_115_1:RecordAudio("116351028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116351", "116351028", "story_v_out_116351.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116351", "116351028", "story_v_out_116351.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play116351029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116351029
		arg_119_1.duration_ = 0.2

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"

			SetActive(arg_119_1.choicesGo_, true)

			for iter_120_0, iter_120_1 in ipairs(arg_119_1.choices_) do
				SetActive(iter_120_1.go, iter_120_0 <= 2)
			end

			arg_119_1.choices_[1].txt.text = arg_119_1:FormatText(StoryChoiceCfg[271].name)
			arg_119_1.choices_[2].txt.text = arg_119_1:FormatText(StoryChoiceCfg[272].name)
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play116351030(arg_119_1)
			end

			if arg_121_0 == 2 then
				arg_119_0:Play116351030(arg_119_1)
			end

			arg_119_1:RecordChoiceLog(116351029, 271, 272)
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10025ui_story"]) and arg_119_1.var_.characterEffect10025ui_story == nil then
				arg_119_1.var_.characterEffect10025ui_story = arg_119_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10025ui_story"]) then
				if arg_119_1.var_.characterEffect10025ui_story and not isNil(arg_119_1.actors_["10025ui_story"]) then
					arg_119_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10025ui_story"]) and arg_119_1.var_.characterEffect10025ui_story then
				arg_119_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play116351030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116351030
		arg_123_1.duration_ = 2.73

		local var_123_0 = {
			zh = 2.633,
			ja = 2.733
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
				arg_123_0:Play116351031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10025ui_story = arg_123_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).z)
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles = arg_123_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_123_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10025ui_story"].transform.position).z)
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10025ui_story"].transform.localEulerAngles = arg_123_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_126_1 = "10025ui_story"

			if arg_123_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_126_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_123_1.stage_.transform)

				var_126_2.name = var_126_1
				var_126_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_[var_126_1] = var_126_2

				local var_126_3 = var_126_2:GetComponentInChildren(typeof(CharacterEffect))

				var_126_3.enabled = true

				local var_126_4 = GameObjectTools.GetOrAddComponent(var_126_2, typeof(DynamicBoneHelper))

				if var_126_4 then
					var_126_4:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_3.transform, false)

				arg_123_1.var_[var_126_1 .. "Animator"] = var_126_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_[var_126_1 .. "Animator"].applyRootMotion = true
				arg_123_1.var_[var_126_1 .. "LipSync"] = var_126_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_126_5 = arg_123_1.actors_["10025ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10025ui_story == nil then
				arg_123_1.var_.characterEffect10025ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect10025ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10025ui_story then
				arg_123_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_126_8 = 0
			local var_126_9 = 0.15

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(116351030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 6 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 6)

				if (6 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 6)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351030", "story_v_out_116351.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_116351", "116351030", "story_v_out_116351.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_116351", "116351030", "story_v_out_116351.awb")

						arg_123_1:RecordAudio("116351030", var_126_15)
						arg_123_1:RecordAudio("116351030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116351", "116351030", "story_v_out_116351.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116351", "116351030", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play116351031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116351031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116351032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10025ui_story"]) and arg_127_1.var_.characterEffect10025ui_story == nil then
				arg_127_1.var_.characterEffect10025ui_story = arg_127_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10025ui_story"]) then
				if arg_127_1.var_.characterEffect10025ui_story and not isNil(arg_127_1.actors_["10025ui_story"]) then
					arg_127_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10025ui_story"]) and arg_127_1.var_.characterEffect10025ui_story then
				arg_127_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.15

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(116351031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 6 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 6)

				if (6 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 6)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116351032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116351032
		arg_131_1.duration_ = 8.8

		local var_131_0 = {
			zh = 6,
			ja = 8.8
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
				arg_131_0:Play116351033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10025ui_story = arg_131_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).z)
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles = arg_131_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_131_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10025ui_story"].transform.position).z)
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10025ui_story"].transform.localEulerAngles = arg_131_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_134_1 = arg_131_1.actors_["10025ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10025ui_story == nil then
				arg_131_1.var_.characterEffect10025ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10025ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10025ui_story then
				arg_131_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_134_4 = 0
			local var_134_5 = 0.475

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(116351032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 19 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 19)

				if (19 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 19)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351032", "story_v_out_116351.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351032", "story_v_out_116351.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_116351", "116351032", "story_v_out_116351.awb")

						arg_131_1:RecordAudio("116351032", var_134_11)
						arg_131_1:RecordAudio("116351032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116351", "116351032", "story_v_out_116351.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116351", "116351032", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play116351033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116351033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116351034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10025ui_story"]) and arg_135_1.var_.characterEffect10025ui_story == nil then
				arg_135_1.var_.characterEffect10025ui_story = arg_135_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10025ui_story"]) then
				if arg_135_1.var_.characterEffect10025ui_story and not isNil(arg_135_1.actors_["10025ui_story"]) then
					arg_135_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10025ui_story"]) and arg_135_1.var_.characterEffect10025ui_story then
				arg_135_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.675

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116351033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 27 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 27)

				if (27 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 27)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116351034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116351034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116351035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(116351034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 34 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 34)

				if (34 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 34)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play116351035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116351035
		arg_143_1.duration_ = 5.17

		local var_143_0 = {
			zh = 2.866,
			ja = 5.166
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
				arg_143_0:Play116351036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10025ui_story = arg_143_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).z)
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles = arg_143_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_143_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10025ui_story"].transform.position).z)
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10025ui_story"].transform.localEulerAngles = arg_143_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_146_1 = arg_143_1.actors_["10025ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10025ui_story == nil then
				arg_143_1.var_.characterEffect10025ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10025ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10025ui_story then
				arg_143_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_146_4 = 0
			local var_146_5 = 0.275

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(116351035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 11 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 11)

				if (11 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 11)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351035", "story_v_out_116351.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351035", "story_v_out_116351.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_116351", "116351035", "story_v_out_116351.awb")

						arg_143_1:RecordAudio("116351035", var_146_11)
						arg_143_1:RecordAudio("116351035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116351", "116351035", "story_v_out_116351.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116351", "116351035", "story_v_out_116351.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play116351036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116351036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116351037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10025ui_story"]) and arg_147_1.var_.characterEffect10025ui_story == nil then
				arg_147_1.var_.characterEffect10025ui_story = arg_147_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10025ui_story"]) then
				if arg_147_1.var_.characterEffect10025ui_story and not isNil(arg_147_1.actors_["10025ui_story"]) then
					arg_147_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10025ui_story"]) and arg_147_1.var_.characterEffect10025ui_story then
				arg_147_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(116351036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 20 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 20)

				if (20 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 20)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116351037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116351037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116351038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(116351037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 24)

				if (24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 24)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116351038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116351038
		arg_155_1.duration_ = 3.87

		local var_155_0 = {
			zh = 2.633,
			ja = 3.866
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
				arg_155_0:Play116351039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10025ui_story = arg_155_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).z)
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles = arg_155_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_155_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10025ui_story"].transform.position).z)
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10025ui_story"].transform.localEulerAngles = arg_155_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_158_1 = arg_155_1.actors_["10025ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10025ui_story == nil then
				arg_155_1.var_.characterEffect10025ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect10025ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10025ui_story then
				arg_155_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 0.25

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(116351038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 10 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 10)

				if (10 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 10)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351038", "story_v_out_116351.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351038", "story_v_out_116351.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_116351", "116351038", "story_v_out_116351.awb")

						arg_155_1:RecordAudio("116351038", var_158_11)
						arg_155_1:RecordAudio("116351038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_116351", "116351038", "story_v_out_116351.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_116351", "116351038", "story_v_out_116351.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play116351039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116351039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116351040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10025ui_story"]) and arg_159_1.var_.characterEffect10025ui_story == nil then
				arg_159_1.var_.characterEffect10025ui_story = arg_159_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10025ui_story"]) then
				if arg_159_1.var_.characterEffect10025ui_story and not isNil(arg_159_1.actors_["10025ui_story"]) then
					arg_159_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10025ui_story"]) and arg_159_1.var_.characterEffect10025ui_story then
				arg_159_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(116351039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 14)

				if (14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 14)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play116351040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116351040
		arg_163_1.duration_ = 6.1

		local var_163_0 = {
			zh = 6.1,
			ja = 3.2
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
				arg_163_0:Play116351041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10025ui_story = arg_163_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).z)
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles = arg_163_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_163_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10025ui_story"].transform.position).z)
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10025ui_story"].transform.localEulerAngles = arg_163_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_166_1 = arg_163_1.actors_["10025ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10025ui_story == nil then
				arg_163_1.var_.characterEffect10025ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect10025ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10025ui_story then
				arg_163_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_166_4 = 0
			local var_166_5 = 0.425

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(116351040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 17 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 17)

				if (17 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 17)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351040", "story_v_out_116351.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351040", "story_v_out_116351.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_116351", "116351040", "story_v_out_116351.awb")

						arg_163_1:RecordAudio("116351040", var_166_11)
						arg_163_1:RecordAudio("116351040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_116351", "116351040", "story_v_out_116351.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_116351", "116351040", "story_v_out_116351.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play116351041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 116351041
		arg_167_1.duration_ = 4.73

		local var_167_0 = {
			zh = 2.7,
			ja = 4.733
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
				arg_167_0:Play116351042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10025ui_story"]) and arg_167_1.var_.characterEffect10025ui_story == nil then
				arg_167_1.var_.characterEffect10025ui_story = arg_167_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10025ui_story"]) then
				if arg_167_1.var_.characterEffect10025ui_story and not isNil(arg_167_1.actors_["10025ui_story"]) then
					arg_167_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10025ui_story"]) and arg_167_1.var_.characterEffect10025ui_story then
				arg_167_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action426")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_170_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_3 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_3

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_3
						arg_167_1.bgmTxt2_.text = var_170_3
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_170_4 = 0
			local var_170_5 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_6 = arg_167_1:GetWordFromCfg(116351041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 15 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 15)

				if (15 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 15)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351041", "story_v_out_116351.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351041", "story_v_out_116351.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_116351", "116351041", "story_v_out_116351.awb")

						arg_167_1:RecordAudio("116351041", var_170_11)
						arg_167_1:RecordAudio("116351041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_116351", "116351041", "story_v_out_116351.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_116351", "116351041", "story_v_out_116351.awb")
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

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play116351042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116351042
		arg_172_1.duration_ = 4.57

		local var_172_0 = {
			zh = 4.566,
			ja = 4.5
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116351043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.5

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(116351042)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 20 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 20)

				if (20 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 20)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351042", "story_v_out_116351.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_116351", "116351042", "story_v_out_116351.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_116351", "116351042", "story_v_out_116351.awb")

						arg_172_1:RecordAudio("116351042", var_175_6)
						arg_172_1:RecordAudio("116351042", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_116351", "116351042", "story_v_out_116351.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_116351", "116351042", "story_v_out_116351.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116351043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116351043
		arg_176_1.duration_ = 5.8

		local var_176_0 = {
			zh = 5.8,
			ja = 5.6
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116351044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10025ui_story = arg_176_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).z)
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles = arg_176_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_176_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10025ui_story"].transform.position).z)
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10025ui_story"].transform.localEulerAngles = arg_176_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_179_1 = arg_176_1.actors_["10025ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect10025ui_story == nil then
				arg_176_1.var_.characterEffect10025ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect10025ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect10025ui_story then
				arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_179_4 = 0
			local var_179_5 = 0.425

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(116351043)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 17 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 17)

				if (17 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 17)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351043", "story_v_out_116351.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_116351", "116351043", "story_v_out_116351.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_116351", "116351043", "story_v_out_116351.awb")

						arg_176_1:RecordAudio("116351043", var_179_11)
						arg_176_1:RecordAudio("116351043", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_116351", "116351043", "story_v_out_116351.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_116351", "116351043", "story_v_out_116351.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play116351044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116351044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
			arg_180_1.auto_ = false
		end

		function arg_180_1.playNext_(arg_182_0)
			arg_180_1.onStoryFinished_()
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10025ui_story"]) and arg_180_1.var_.characterEffect10025ui_story == nil then
				arg_180_1.var_.characterEffect10025ui_story = arg_180_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10025ui_story"]) then
				if arg_180_1.var_.characterEffect10025ui_story and not isNil(arg_180_1.actors_["10025ui_story"]) then
					arg_180_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10025ui_story"]) and arg_180_1.var_.characterEffect10025ui_story then
				arg_180_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.25

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(116351044).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 10 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 10)

				if (10 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 10)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST15"
	},
	voices = {
		"story_v_out_116351.awb"
	}
}
