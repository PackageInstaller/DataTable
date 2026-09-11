return {
	Play411031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411031001
		arg_1_1.duration_ = 4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11r == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_4_0.name = "I11r"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11r = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11r

				arg_1_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11r" then
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

			local var_4_8 = "10071ui_story"

			if arg_1_1.actors_["10071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10071ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10071ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["10071ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10071ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10071ui_story, Vector3.New(0, -0.9, -6.26), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.9, -6.26)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10071ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10071ui_story == nil then
				arg_1_1.var_.characterEffect10071ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10071ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10071ui_story then
				arg_1_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

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
			local var_4_24 = 0.125

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(411031001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)

				if (5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031001", "story_v_out_411031.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_411031", "411031001", "story_v_out_411031.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_411031", "411031001", "story_v_out_411031.awb")

						arg_1_1:RecordAudio("411031001", var_4_31)
						arg_1_1:RecordAudio("411031001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411031", "411031001", "story_v_out_411031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411031", "411031001", "story_v_out_411031.awb")
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
				actorName = "10071ui_story",
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
	Play411031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10071ui_story"]) and arg_9_1.var_.characterEffect10071ui_story == nil then
				arg_9_1.var_.characterEffect10071ui_story = arg_9_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10071ui_story"]) then
				if arg_9_1.var_.characterEffect10071ui_story and not isNil(arg_9_1.actors_["10071ui_story"]) then
					arg_9_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10071ui_story"]) and arg_9_1.var_.characterEffect10071ui_story then
				arg_9_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.2

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411031002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 48 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 48)

				if (48 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 48)) > 0 and var_12_2 < var_12_5 then
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
	Play411031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411031003
		arg_13_1.duration_ = 4.8

		local var_13_0 = {
			zh = 3.966,
			ja = 4.8
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
				arg_13_0:Play411031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10058ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10058ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10058ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10058ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10058ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10058ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10058ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10058ui_story == nil then
				arg_13_1.var_.characterEffect10058ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10058ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10058ui_story then
				arg_13_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_8 = arg_13_1.actors_["10071ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10071ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["10071ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10071ui_story == nil then
				arg_13_1.var_.characterEffect10071ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect10071ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10071ui_story then
				arg_13_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
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

				local var_16_14 = arg_13_1:GetWordFromCfg(411031003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 20 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 20)

				if (20 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 20)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031003", "story_v_out_411031.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_411031", "411031003", "story_v_out_411031.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_411031", "411031003", "story_v_out_411031.awb")

						arg_13_1:RecordAudio("411031003", var_16_19)
						arg_13_1:RecordAudio("411031003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411031", "411031003", "story_v_out_411031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411031", "411031003", "story_v_out_411031.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
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
	Play411031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411031004
		arg_17_1.duration_ = 7.83

		local var_17_0 = {
			zh = 7.833,
			ja = 7.533
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
				arg_17_0:Play411031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10071ui_story = arg_17_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).z)
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles = arg_17_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				arg_17_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10071ui_story"].transform.position).z)
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10071ui_story"].transform.localEulerAngles = arg_17_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10071ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10071ui_story == nil then
				arg_17_1.var_.characterEffect10071ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10071ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10071ui_story then
				arg_17_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = arg_17_1.actors_["10058ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10058ui_story == nil then
				arg_17_1.var_.characterEffect10058ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect10058ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10058ui_story then
				arg_17_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.975

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(411031004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 39 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 39)

				if (39 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 39)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031004", "story_v_out_411031.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031004", "story_v_out_411031.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_411031", "411031004", "story_v_out_411031.awb")

						arg_17_1:RecordAudio("411031004", var_20_13)
						arg_17_1:RecordAudio("411031004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411031", "411031004", "story_v_out_411031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411031", "411031004", "story_v_out_411031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
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
	Play411031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411031005
		arg_21_1.duration_ = 6.13

		local var_21_0 = {
			zh = 4.9,
			ja = 6.133
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
				arg_21_0:Play411031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10058ui_story = arg_21_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).z)
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles = arg_21_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_21_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10058ui_story"].transform.position).z)
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10058ui_story"].transform.localEulerAngles = arg_21_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10058ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10058ui_story then
				arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = arg_21_1.actors_["10071ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10071ui_story == nil then
				arg_21_1.var_.characterEffect10071ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect10071ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10071ui_story then
				arg_21_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_24_6 = 0
			local var_24_7 = 0.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(411031005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 24 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 24)

				if (24 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 24)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031005", "story_v_out_411031.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031005", "story_v_out_411031.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_411031", "411031005", "story_v_out_411031.awb")

						arg_21_1:RecordAudio("411031005", var_24_13)
						arg_21_1:RecordAudio("411031005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411031", "411031005", "story_v_out_411031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411031", "411031005", "story_v_out_411031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411031006
		arg_25_1.duration_ = 4.1

		local var_25_0 = {
			zh = 2.5,
			ja = 4.1
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
				arg_25_0:Play411031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10071ui_story"]) and arg_25_1.var_.characterEffect10071ui_story == nil then
				arg_25_1.var_.characterEffect10071ui_story = arg_25_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10071ui_story"]) then
				if arg_25_1.var_.characterEffect10071ui_story and not isNil(arg_25_1.actors_["10071ui_story"]) then
					arg_25_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10071ui_story"]) and arg_25_1.var_.characterEffect10071ui_story then
				arg_25_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(411031006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 11 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 11)

				if (11 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 11)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031006", "story_v_out_411031.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_411031", "411031006", "story_v_out_411031.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_411031", "411031006", "story_v_out_411031.awb")

						arg_25_1:RecordAudio("411031006", var_28_8)
						arg_25_1:RecordAudio("411031006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411031", "411031006", "story_v_out_411031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411031", "411031006", "story_v_out_411031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411031007
		arg_29_1.duration_ = 7.27

		local var_29_0 = {
			zh = 7.266,
			ja = 6.6
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
				arg_29_0:Play411031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = arg_29_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) then
				if arg_29_1.var_.characterEffect10058ui_story and not isNil(arg_29_1.actors_["10058ui_story"]) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_32_1 = arg_29_1.actors_["10071ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10071ui_story == nil then
				arg_29_1.var_.characterEffect10071ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10071ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10071ui_story then
				arg_29_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(411031007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 33 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 33)

				if (33 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 33)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031007", "story_v_out_411031.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031007", "story_v_out_411031.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_411031", "411031007", "story_v_out_411031.awb")

						arg_29_1:RecordAudio("411031007", var_32_11)
						arg_29_1:RecordAudio("411031007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411031", "411031007", "story_v_out_411031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411031", "411031007", "story_v_out_411031.awb")
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
	Play411031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411031008
		arg_33_1.duration_ = 5.03

		local var_33_0 = {
			zh = 4,
			ja = 5.033
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
				arg_33_0:Play411031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.ST17 == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_36_0.name = "ST17"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.ST17 = var_36_0
			end

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.ST17

				arg_33_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "ST17" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 2

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			local var_36_12 = arg_33_1.actors_["10071ui_story"].transform

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				arg_33_1.var_.moveOldPos10071ui_story = var_36_12.localPosition
			end

			local var_36_13 = 0.001

			if 2 <= arg_33_1.time_ and arg_33_1.time_ < 2 + var_36_13 then
				var_36_12.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_33_1.time_ - 2) / var_36_13)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			if arg_33_1.time_ >= 2 + var_36_13 and arg_33_1.time_ < 2 + var_36_13 + arg_36_0 then
				var_36_12.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			local var_36_14 = arg_33_1.actors_["10071ui_story"]

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10071ui_story == nil then
				arg_33_1.var_.characterEffect10071ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_15 = 0.200000002980232

			if 2 <= arg_33_1.time_ and arg_33_1.time_ < 2 + var_36_15 and not isNil(var_36_14) then
				if arg_33_1.var_.characterEffect10071ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 2 + var_36_15 and arg_33_1.time_ < 2 + var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10071ui_story then
				arg_33_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				arg_33_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_17 = 2
			local var_36_18 = 0.2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
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

				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_20 = arg_33_1:GetWordFromCfg(411031008)
				local var_36_21 = arg_33_1:FormatText(var_36_20.content)

				arg_33_1.text_.text = var_36_21

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_23 = 8 <= 0 and var_36_18 or var_36_18 * (utf8.len(var_36_21) / 8)

				if (8 <= 0 and var_36_18 or var_36_18 * (utf8.len(var_36_21) / 8)) > 0 and var_36_18 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23
					var_36_17 = var_36_17 + 0.3

					if var_36_23 + var_36_17 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_17
					end
				end

				arg_33_1.text_.text = var_36_21
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031008", "story_v_out_411031.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_411031", "411031008", "story_v_out_411031.awb") / 1000

					if var_36_24 + var_36_17 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_17
					end

					if var_36_20.prefab_name ~= "" and arg_33_1.actors_[var_36_20.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_20.prefab_name].transform, "story_v_out_411031", "411031008", "story_v_out_411031.awb")

						arg_33_1:RecordAudio("411031008", var_36_25)
						arg_33_1:RecordAudio("411031008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411031", "411031008", "story_v_out_411031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411031", "411031008", "story_v_out_411031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = var_36_17 + 0.3
			local var_36_27 = math.max(var_36_18, arg_33_1.talkMaxDuration)

			if var_36_17 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_26 + var_36_27 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_26) / var_36_27

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_26 + var_36_27 and arg_33_1.time_ < var_36_26 + var_36_27 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411031009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 411031009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play411031010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["10071ui_story"]) and arg_39_1.var_.characterEffect10071ui_story == nil then
				arg_39_1.var_.characterEffect10071ui_story = arg_39_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["10071ui_story"]) then
				if arg_39_1.var_.characterEffect10071ui_story and not isNil(arg_39_1.actors_["10071ui_story"]) then
					arg_39_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["10071ui_story"]) and arg_39_1.var_.characterEffect10071ui_story then
				arg_39_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.95

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(411031009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 38 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 38)

				if (38 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 38)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play411031010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 411031010
		arg_43_1.duration_ = 7.37

		local var_43_0 = {
			zh = 4.1,
			ja = 7.366
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
				arg_43_0:Play411031011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10058ui_story = arg_43_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).z)
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles = arg_43_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_43_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10058ui_story"].transform.position).z)
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10058ui_story"].transform.localEulerAngles = arg_43_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["10058ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10058ui_story == nil then
				arg_43_1.var_.characterEffect10058ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect10058ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10058ui_story then
				arg_43_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.5

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
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

				local var_46_6 = arg_43_1:GetWordFromCfg(411031010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 20 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 20)

				if (20 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 20)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031010", "story_v_out_411031.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031010", "story_v_out_411031.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_411031", "411031010", "story_v_out_411031.awb")

						arg_43_1:RecordAudio("411031010", var_46_11)
						arg_43_1:RecordAudio("411031010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_411031", "411031010", "story_v_out_411031.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_411031", "411031010", "story_v_out_411031.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411031011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411031011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411031012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["10058ui_story"]) and arg_47_1.var_.characterEffect10058ui_story == nil then
				arg_47_1.var_.characterEffect10058ui_story = arg_47_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["10058ui_story"]) then
				if arg_47_1.var_.characterEffect10058ui_story and not isNil(arg_47_1.actors_["10058ui_story"]) then
					arg_47_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["10058ui_story"]) and arg_47_1.var_.characterEffect10058ui_story then
				arg_47_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(411031011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)

				if (21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play411031012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411031012
		arg_51_1.duration_ = 7.4

		local var_51_0 = {
			zh = 6.933,
			ja = 7.4
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411031013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10071ui_story"]) and arg_51_1.var_.characterEffect10071ui_story == nil then
				arg_51_1.var_.characterEffect10071ui_story = arg_51_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10071ui_story"]) then
				if arg_51_1.var_.characterEffect10071ui_story and not isNil(arg_51_1.actors_["10071ui_story"]) then
					arg_51_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10071ui_story"]) and arg_51_1.var_.characterEffect10071ui_story then
				arg_51_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_54_2 = 0
			local var_54_3 = 0.825

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(411031012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 33 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 33)

				if (33 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 33)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031012", "story_v_out_411031.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031012", "story_v_out_411031.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_411031", "411031012", "story_v_out_411031.awb")

						arg_51_1:RecordAudio("411031012", var_54_9)
						arg_51_1:RecordAudio("411031012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_411031", "411031012", "story_v_out_411031.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_411031", "411031012", "story_v_out_411031.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play411031013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411031013
		arg_55_1.duration_ = 13.07

		local var_55_0 = {
			zh = 10.733,
			ja = 13.066
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
				arg_55_0:Play411031014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_58_0 = 0
			local var_58_1 = 1.05

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(411031013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 42 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 42)

				if (42 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 42)) > 0 and var_58_1 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031013", "story_v_out_411031.awb") ~= 0 then
					local var_58_6 = manager.audio:GetVoiceLength("story_v_out_411031", "411031013", "story_v_out_411031.awb") / 1000

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end

					if var_58_2.prefab_name ~= "" and arg_55_1.actors_[var_58_2.prefab_name] ~= nil then
						local var_58_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_2.prefab_name].transform, "story_v_out_411031", "411031013", "story_v_out_411031.awb")

						arg_55_1:RecordAudio("411031013", var_58_7)
						arg_55_1:RecordAudio("411031013", var_58_7)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_411031", "411031013", "story_v_out_411031.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_411031", "411031013", "story_v_out_411031.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play411031014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411031014
		arg_59_1.duration_ = 15.1

		local var_59_0 = {
			zh = 15.1,
			ja = 8.9
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
				arg_59_0:Play411031015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(411031014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 51 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 51)

				if (51 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 51)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031014", "story_v_out_411031.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031014", "story_v_out_411031.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_411031", "411031014", "story_v_out_411031.awb")

						arg_59_1:RecordAudio("411031014", var_62_6)
						arg_59_1:RecordAudio("411031014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_411031", "411031014", "story_v_out_411031.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_411031", "411031014", "story_v_out_411031.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play411031015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411031015
		arg_63_1.duration_ = 13.47

		local var_63_0 = {
			zh = 13.466,
			ja = 10.4
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
				arg_63_0:Play411031016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.6

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(411031015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 64 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 64)

				if (64 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 64)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031015", "story_v_out_411031.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031015", "story_v_out_411031.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_411031", "411031015", "story_v_out_411031.awb")

						arg_63_1:RecordAudio("411031015", var_66_6)
						arg_63_1:RecordAudio("411031015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_411031", "411031015", "story_v_out_411031.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_411031", "411031015", "story_v_out_411031.awb")
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
	Play411031016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411031016
		arg_67_1.duration_ = 5.47

		local var_67_0 = {
			zh = 5.166,
			ja = 5.466
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
				arg_67_0:Play411031017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.575

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(411031016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 23 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 23)

				if (23 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 23)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031016", "story_v_out_411031.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031016", "story_v_out_411031.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_411031", "411031016", "story_v_out_411031.awb")

						arg_67_1:RecordAudio("411031016", var_70_6)
						arg_67_1:RecordAudio("411031016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_411031", "411031016", "story_v_out_411031.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_411031", "411031016", "story_v_out_411031.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play411031017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411031017
		arg_71_1.duration_ = 3.7

		local var_71_0 = {
			zh = 3.7,
			ja = 3.633
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
				arg_71_0:Play411031018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10058ui_story = arg_71_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).z)
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles = arg_71_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_71_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10058ui_story"].transform.position).z)
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10058ui_story"].transform.localEulerAngles = arg_71_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10058ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10058ui_story == nil then
				arg_71_1.var_.characterEffect10058ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10058ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10058ui_story then
				arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_74_4 = arg_71_1.actors_["10071ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect10071ui_story == nil then
				arg_71_1.var_.characterEffect10071ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect10071ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect10071ui_story then
				arg_71_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_74_6 = 0
			local var_74_7 = 0.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(411031017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 18 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 18)

				if (18 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 18)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031017", "story_v_out_411031.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031017", "story_v_out_411031.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_411031", "411031017", "story_v_out_411031.awb")

						arg_71_1:RecordAudio("411031017", var_74_13)
						arg_71_1:RecordAudio("411031017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_411031", "411031017", "story_v_out_411031.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_411031", "411031017", "story_v_out_411031.awb")
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
				actorName = "10058ui_story",
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
	Play411031018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411031018
		arg_75_1.duration_ = 10.93

		local var_75_0 = {
			zh = 8.533,
			ja = 10.933
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
				arg_75_0:Play411031019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10071ui_story = arg_75_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).z)
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles = arg_75_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				arg_75_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10071ui_story"].transform.position).z)
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10071ui_story"].transform.localEulerAngles = arg_75_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["10071ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10071ui_story == nil then
				arg_75_1.var_.characterEffect10071ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect10071ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10071ui_story then
				arg_75_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_4 = arg_75_1.actors_["10058ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10058ui_story == nil then
				arg_75_1.var_.characterEffect10058ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect10058ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10058ui_story then
				arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_78_6 = 0
			local var_78_7 = 0.875

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(411031018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 34 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 34)

				if (34 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 34)) > 0 and var_78_7 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031018", "story_v_out_411031.awb") ~= 0 then
					local var_78_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031018", "story_v_out_411031.awb") / 1000

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end

					if var_78_8.prefab_name ~= "" and arg_75_1.actors_[var_78_8.prefab_name] ~= nil then
						local var_78_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_8.prefab_name].transform, "story_v_out_411031", "411031018", "story_v_out_411031.awb")

						arg_75_1:RecordAudio("411031018", var_78_13)
						arg_75_1:RecordAudio("411031018", var_78_13)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_411031", "411031018", "story_v_out_411031.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_411031", "411031018", "story_v_out_411031.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play411031019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411031019
		arg_79_1.duration_ = 1.53

		local var_79_0 = {
			zh = 1.266,
			ja = 1.533
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
				arg_79_0:Play411031020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10058ui_story = arg_79_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).z)
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles = arg_79_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_79_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10058ui_story"].transform.position).z)
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10058ui_story"].transform.localEulerAngles = arg_79_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10058ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10058ui_story == nil then
				arg_79_1.var_.characterEffect10058ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10058ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10058ui_story then
				arg_79_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["10071ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect10071ui_story == nil then
				arg_79_1.var_.characterEffect10071ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_5 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 and not isNil(var_82_4) then
				if arg_79_1.var_.characterEffect10071ui_story and not isNil(var_82_4) then
					arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_5)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect10071ui_story then
				arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_82_6 = 0
			local var_82_7 = 0.125

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
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

				local var_82_8 = arg_79_1:GetWordFromCfg(411031019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 5 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 5)

				if (5 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 5)) > 0 and var_82_7 < var_82_11 then
					arg_79_1.talkMaxDuration = var_82_11

					if var_82_11 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031019", "story_v_out_411031.awb") ~= 0 then
					local var_82_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031019", "story_v_out_411031.awb") / 1000

					if var_82_12 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_6
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_411031", "411031019", "story_v_out_411031.awb")

						arg_79_1:RecordAudio("411031019", var_82_13)
						arg_79_1:RecordAudio("411031019", var_82_13)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_411031", "411031019", "story_v_out_411031.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_411031", "411031019", "story_v_out_411031.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play411031020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411031020
		arg_83_1.duration_ = 8.4

		local var_83_0 = {
			zh = 8.2,
			ja = 8.4
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
				arg_83_0:Play411031021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.925

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(411031020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 37 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 37)

				if (37 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 37)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031020", "story_v_out_411031.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031020", "story_v_out_411031.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_411031", "411031020", "story_v_out_411031.awb")

						arg_83_1:RecordAudio("411031020", var_86_6)
						arg_83_1:RecordAudio("411031020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_411031", "411031020", "story_v_out_411031.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_411031", "411031020", "story_v_out_411031.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play411031021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411031021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411031022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10058ui_story"]) and arg_87_1.var_.characterEffect10058ui_story == nil then
				arg_87_1.var_.characterEffect10058ui_story = arg_87_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10058ui_story"]) then
				if arg_87_1.var_.characterEffect10058ui_story and not isNil(arg_87_1.actors_["10058ui_story"]) then
					arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10058ui_story"]) and arg_87_1.var_.characterEffect10058ui_story then
				arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_2")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_90_1 = 0
			local var_90_2 = 0.95

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(411031021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 38 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 38)

				if (38 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 38)) > 0 and var_90_2 < var_90_5 then
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

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play411031022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411031022
		arg_91_1.duration_ = 2.67

		local var_91_0 = {
			zh = 2.666,
			ja = 2.466
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
				arg_91_0:Play411031023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[671].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(411031022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 8 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 8)

				if (8 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 8)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031022", "story_v_out_411031.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031022", "story_v_out_411031.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_411031", "411031022", "story_v_out_411031.awb")

						arg_91_1:RecordAudio("411031022", var_94_6)
						arg_91_1:RecordAudio("411031022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_411031", "411031022", "story_v_out_411031.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_411031", "411031022", "story_v_out_411031.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411031023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411031023
		arg_95_1.duration_ = 2.87

		local var_95_0 = {
			zh = 1.7,
			ja = 2.866
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411031024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10071ui_story"]) and arg_95_1.var_.characterEffect10071ui_story == nil then
				arg_95_1.var_.characterEffect10071ui_story = arg_95_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10071ui_story"]) then
				if arg_95_1.var_.characterEffect10071ui_story and not isNil(arg_95_1.actors_["10071ui_story"]) then
					arg_95_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10071ui_story"]) and arg_95_1.var_.characterEffect10071ui_story then
				arg_95_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_98_2 = 0
			local var_98_3 = 0.2

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(411031023)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 8 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 8)

				if (8 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 8)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031023", "story_v_out_411031.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031023", "story_v_out_411031.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_411031", "411031023", "story_v_out_411031.awb")

						arg_95_1:RecordAudio("411031023", var_98_9)
						arg_95_1:RecordAudio("411031023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_411031", "411031023", "story_v_out_411031.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_411031", "411031023", "story_v_out_411031.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play411031024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411031024
		arg_99_1.duration_ = 4.1

		local var_99_0 = {
			zh = 2.9,
			ja = 4.1
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
				arg_99_0:Play411031025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) and arg_99_1.var_.characterEffect10058ui_story == nil then
				arg_99_1.var_.characterEffect10058ui_story = arg_99_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) then
				if arg_99_1.var_.characterEffect10058ui_story and not isNil(arg_99_1.actors_["10058ui_story"]) then
					arg_99_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) and arg_99_1.var_.characterEffect10058ui_story then
				arg_99_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_102_2 = arg_99_1.actors_["10071ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect10071ui_story == nil then
				arg_99_1.var_.characterEffect10071ui_story = var_102_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_3 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.characterEffect10071ui_story and not isNil(var_102_2) then
					arg_99_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_3)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect10071ui_story then
				arg_99_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_102_4 = 0
			local var_102_5 = 0.375

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(411031024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 15 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 15)

				if (15 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 15)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031024", "story_v_out_411031.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031024", "story_v_out_411031.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_411031", "411031024", "story_v_out_411031.awb")

						arg_99_1:RecordAudio("411031024", var_102_11)
						arg_99_1:RecordAudio("411031024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411031", "411031024", "story_v_out_411031.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411031", "411031024", "story_v_out_411031.awb")
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

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play411031025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411031025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411031026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = arg_103_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) then
				if arg_103_1.var_.characterEffect10058ui_story and not isNil(arg_103_1.actors_["10058ui_story"]) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_106_1 = arg_103_1.actors_["10071ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10071ui_story == nil then
				arg_103_1.var_.characterEffect10071ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect10071ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_2)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10071ui_story then
				arg_103_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_106_3 = 0
			local var_106_4 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(411031025).content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 25 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 25)

				if (25 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 25)) > 0 and var_106_4 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_8 and arg_103_1.time_ < var_106_3 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411031026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411031026
		arg_107_1.duration_ = 1.43

		local var_107_0 = {
			zh = 1.433,
			ja = 1.3
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
				arg_107_0:Play411031027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10071ui_story"]) and arg_107_1.var_.characterEffect10071ui_story == nil then
				arg_107_1.var_.characterEffect10071ui_story = arg_107_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10071ui_story"]) then
				if arg_107_1.var_.characterEffect10071ui_story and not isNil(arg_107_1.actors_["10071ui_story"]) then
					arg_107_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10071ui_story"]) and arg_107_1.var_.characterEffect10071ui_story then
				arg_107_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_110_2 = 0
			local var_110_3 = 0.1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(411031026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 4 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 4)

				if (4 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 4)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031026", "story_v_out_411031.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031026", "story_v_out_411031.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_411031", "411031026", "story_v_out_411031.awb")

						arg_107_1:RecordAudio("411031026", var_110_9)
						arg_107_1:RecordAudio("411031026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_411031", "411031026", "story_v_out_411031.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_411031", "411031026", "story_v_out_411031.awb")
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
	Play411031027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411031027
		arg_111_1.duration_ = 7.9

		local var_111_0 = {
			zh = 7.9,
			ja = 6.533
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
				arg_111_0:Play411031028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10071ui_story"]) and arg_111_1.var_.characterEffect10071ui_story == nil then
				arg_111_1.var_.characterEffect10071ui_story = arg_111_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10071ui_story"]) then
				if arg_111_1.var_.characterEffect10071ui_story and not isNil(arg_111_1.actors_["10071ui_story"]) then
					arg_111_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10071ui_story"]) and arg_111_1.var_.characterEffect10071ui_story then
				arg_111_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.85

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[671].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(411031027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 34 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 34)

				if (34 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 34)) > 0 and var_114_2 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031027", "story_v_out_411031.awb") ~= 0 then
					local var_114_7 = manager.audio:GetVoiceLength("story_v_out_411031", "411031027", "story_v_out_411031.awb") / 1000

					if var_114_7 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_1
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_411031", "411031027", "story_v_out_411031.awb")

						arg_111_1:RecordAudio("411031027", var_114_8)
						arg_111_1:RecordAudio("411031027", var_114_8)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_411031", "411031027", "story_v_out_411031.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_411031", "411031027", "story_v_out_411031.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411031028
		arg_115_1.duration_ = 12.27

		local var_115_0 = {
			zh = 6.2,
			ja = 12.266
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
				arg_115_0:Play411031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = arg_115_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) then
				if arg_115_1.var_.characterEffect10058ui_story and not isNil(arg_115_1.actors_["10058ui_story"]) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_2 = 0
			local var_118_3 = 0.525

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(411031028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 21 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 21)

				if (21 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 21)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031028", "story_v_out_411031.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031028", "story_v_out_411031.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_411031", "411031028", "story_v_out_411031.awb")

						arg_115_1:RecordAudio("411031028", var_118_9)
						arg_115_1:RecordAudio("411031028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_411031", "411031028", "story_v_out_411031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_411031", "411031028", "story_v_out_411031.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play411031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411031029
		arg_119_1.duration_ = 4.13

		local var_119_0 = {
			zh = 4.133,
			ja = 2.6
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
				arg_119_0:Play411031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = arg_119_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) then
				if arg_119_1.var_.characterEffect10058ui_story and not isNil(arg_119_1.actors_["10058ui_story"]) then
					arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) and arg_119_1.var_.characterEffect10058ui_story then
				arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_122_1 = arg_119_1.actors_["10071ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10071ui_story == nil then
				arg_119_1.var_.characterEffect10071ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10071ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10071ui_story then
				arg_119_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action4_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.45

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(411031029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 18 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 18)

				if (18 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 18)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031029", "story_v_out_411031.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031029", "story_v_out_411031.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_411031", "411031029", "story_v_out_411031.awb")

						arg_119_1:RecordAudio("411031029", var_122_11)
						arg_119_1:RecordAudio("411031029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411031", "411031029", "story_v_out_411031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411031", "411031029", "story_v_out_411031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play411031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411031030
		arg_123_1.duration_ = 9.3

		local var_123_0 = {
			zh = 9.3,
			ja = 5.733
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
				arg_123_0:Play411031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10071ui_story"]) and arg_123_1.var_.characterEffect10071ui_story == nil then
				arg_123_1.var_.characterEffect10071ui_story = arg_123_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10071ui_story"]) then
				if arg_123_1.var_.characterEffect10071ui_story and not isNil(arg_123_1.actors_["10071ui_story"]) then
					arg_123_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10071ui_story"]) and arg_123_1.var_.characterEffect10071ui_story then
				arg_123_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.875

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(411031030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 35 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 35)

				if (35 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 35)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031030", "story_v_out_411031.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_411031", "411031030", "story_v_out_411031.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_411031", "411031030", "story_v_out_411031.awb")

						arg_123_1:RecordAudio("411031030", var_126_8)
						arg_123_1:RecordAudio("411031030", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_411031", "411031030", "story_v_out_411031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_411031", "411031030", "story_v_out_411031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411031031
		arg_127_1.duration_ = 2.3

		local var_127_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_127_0:Play411031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) and arg_127_1.var_.characterEffect10058ui_story == nil then
				arg_127_1.var_.characterEffect10058ui_story = arg_127_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) then
				if arg_127_1.var_.characterEffect10058ui_story and not isNil(arg_127_1.actors_["10058ui_story"]) then
					arg_127_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) and arg_127_1.var_.characterEffect10058ui_story then
				arg_127_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_130_2 = 0
			local var_130_3 = 0.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:GetWordFromCfg(411031031)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 5 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 5)

				if (5 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 5)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031031", "story_v_out_411031.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031031", "story_v_out_411031.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_411031", "411031031", "story_v_out_411031.awb")

						arg_127_1:RecordAudio("411031031", var_130_9)
						arg_127_1:RecordAudio("411031031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_411031", "411031031", "story_v_out_411031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_411031", "411031031", "story_v_out_411031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_10 and arg_127_1.time_ < var_130_2 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411031032
		arg_131_1.duration_ = 7

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.bgs_.STblack == nil then
				local var_134_0 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_134_0.name = "STblack"
				var_134_0.transform.parent = arg_131_1.stage_.transform
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_.STblack = var_134_0
			end

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 then
				local var_134_1 = arg_131_1.bgs_.STblack

				arg_131_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_134_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_2 = var_134_1:GetComponent("SpriteRenderer")

				if var_134_2 and var_134_2.sprite then
					local var_134_3 = 2 * (var_134_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_134_1.transform.localScale = Vector3.New(var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "STblack" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_4 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_5 = 0.5

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_5 then
				local var_134_6 = Color.New(0, 0, 0)

				var_134_6.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_4) / var_134_5)
				arg_131_1.mask_.color = var_134_6
			end

			if arg_131_1.time_ >= var_134_4 + var_134_5 and arg_131_1.time_ < var_134_4 + var_134_5 + arg_134_0 then
				local var_134_7 = Color.New(0, 0, 0)

				var_134_7.a = 1
				arg_131_1.mask_.color = var_134_7
			end

			local var_134_8 = 0.5

			if 0.5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_9 = 0.5

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 then
				local var_134_10 = Color.New(0, 0, 0)

				var_134_10.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_8) / var_134_9)
				arg_131_1.mask_.color = var_134_10
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 then
				local var_134_11 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_11.a = 0
				arg_131_1.mask_.color = var_134_11
			end

			local var_134_12 = 1

			if 1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_13 = 0.5

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_13 then
				local var_134_14 = Color.New(0, 0, 0)

				var_134_14.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_12) / var_134_13)
				arg_131_1.mask_.color = var_134_14
			end

			if arg_131_1.time_ >= var_134_12 + var_134_13 and arg_131_1.time_ < var_134_12 + var_134_13 + arg_134_0 then
				local var_134_15 = Color.New(0, 0, 0)

				var_134_15.a = 1
				arg_131_1.mask_.color = var_134_15
			end

			local var_134_16 = 1.5

			if 1.5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_17 = 0.5

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				local var_134_18 = Color.New(0, 0, 0)

				var_134_18.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_16) / var_134_17)
				arg_131_1.mask_.color = var_134_18
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				local var_134_19 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_19.a = 0
				arg_131_1.mask_.color = var_134_19
			end

			local var_134_20 = 2

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_20 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_21 = 2

			if var_134_20 <= arg_131_1.time_ and arg_131_1.time_ < var_134_20 + var_134_21 then
				local var_134_22 = Color.New(0, 0, 0)

				var_134_22.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_20) / var_134_21)
				arg_131_1.mask_.color = var_134_22
			end

			if arg_131_1.time_ >= var_134_20 + var_134_21 and arg_131_1.time_ < var_134_20 + var_134_21 + arg_134_0 then
				local var_134_23 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_23.a = 0
				arg_131_1.mask_.color = var_134_23
			end

			local var_134_24 = arg_131_1.actors_["10071ui_story"].transform

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 then
				arg_131_1.var_.moveOldPos10071ui_story = var_134_24.localPosition
			end

			local var_134_25 = 0.001

			if 2 <= arg_131_1.time_ and arg_131_1.time_ < 2 + var_134_25 then
				var_134_24.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10071ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 2) / var_134_25)
				var_134_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_24.position).x, (manager.ui.mainCamera.transform.position - var_134_24.position).y, (manager.ui.mainCamera.transform.position - var_134_24.position).z)
				var_134_24.localEulerAngles.z = 0
				var_134_24.localEulerAngles.x = 0
				var_134_24.localEulerAngles = var_134_24.localEulerAngles
			end

			if arg_131_1.time_ >= 2 + var_134_25 and arg_131_1.time_ < 2 + var_134_25 + arg_134_0 then
				var_134_24.localPosition = Vector3.New(0, 100, 0)
				var_134_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_24.position).x, (manager.ui.mainCamera.transform.position - var_134_24.position).y, (manager.ui.mainCamera.transform.position - var_134_24.position).z)
				var_134_24.localEulerAngles.z = 0
				var_134_24.localEulerAngles.x = 0
				var_134_24.localEulerAngles = var_134_24.localEulerAngles
			end

			local var_134_26 = arg_131_1.actors_["10071ui_story"]

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 and not isNil(var_134_26) and arg_131_1.var_.characterEffect10071ui_story == nil then
				arg_131_1.var_.characterEffect10071ui_story = var_134_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_27 = 0.200000002980232

			if 2 <= arg_131_1.time_ and arg_131_1.time_ < 2 + var_134_27 and not isNil(var_134_26) then
				if arg_131_1.var_.characterEffect10071ui_story and not isNil(var_134_26) then
					arg_131_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 2) / var_134_27)
				end
			end

			if arg_131_1.time_ >= 2 + var_134_27 and arg_131_1.time_ < 2 + var_134_27 + arg_134_0 and not isNil(var_134_26) and arg_131_1.var_.characterEffect10071ui_story then
				arg_131_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_134_28 = arg_131_1.actors_["10058ui_story"].transform

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 then
				arg_131_1.var_.moveOldPos10058ui_story = var_134_28.localPosition
			end

			local var_134_29 = 0.001

			if 2 <= arg_131_1.time_ and arg_131_1.time_ < 2 + var_134_29 then
				var_134_28.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 2) / var_134_29)
				var_134_28.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_28.position).x, (manager.ui.mainCamera.transform.position - var_134_28.position).y, (manager.ui.mainCamera.transform.position - var_134_28.position).z)
				var_134_28.localEulerAngles.z = 0
				var_134_28.localEulerAngles.x = 0
				var_134_28.localEulerAngles = var_134_28.localEulerAngles
			end

			if arg_131_1.time_ >= 2 + var_134_29 and arg_131_1.time_ < 2 + var_134_29 + arg_134_0 then
				var_134_28.localPosition = Vector3.New(0, 100, 0)
				var_134_28.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_28.position).x, (manager.ui.mainCamera.transform.position - var_134_28.position).y, (manager.ui.mainCamera.transform.position - var_134_28.position).z)
				var_134_28.localEulerAngles.z = 0
				var_134_28.localEulerAngles.x = 0
				var_134_28.localEulerAngles = var_134_28.localEulerAngles
			end

			local var_134_30 = arg_131_1.actors_["10058ui_story"]

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 and not isNil(var_134_30) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = var_134_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_31 = 0.200000002980232

			if 2 <= arg_131_1.time_ and arg_131_1.time_ < 2 + var_134_31 and not isNil(var_134_30) then
				if arg_131_1.var_.characterEffect10058ui_story and not isNil(var_134_30) then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 2) / var_134_31)
				end
			end

			if arg_131_1.time_ >= 2 + var_134_31 and arg_131_1.time_ < 2 + var_134_31 + arg_134_0 and not isNil(var_134_30) and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_134_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_34 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_34

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_34
						arg_131_1.bgmTxt2_.text = var_134_34
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_35 = 2
			local var_134_36 = 1.025

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_35 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_37 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_37:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_131_1.dialogCg_.alpha = arg_136_0
				end))
				var_134_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_38 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(411031032).content)

				arg_131_1.text_.text = var_134_38

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_40 = 41 <= 0 and var_134_36 or var_134_36 * (utf8.len(var_134_38) / 41)

				if (41 <= 0 and var_134_36 or var_134_36 * (utf8.len(var_134_38) / 41)) > 0 and var_134_36 < var_134_40 then
					arg_131_1.talkMaxDuration = var_134_40
					var_134_35 = var_134_35 + 0.3

					if var_134_40 + var_134_35 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_40 + var_134_35
					end
				end

				arg_131_1.text_.text = var_134_38
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_41 = var_134_35 + 0.3
			local var_134_42 = math.max(var_134_36, arg_131_1.talkMaxDuration)

			if var_134_35 + 0.3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_41 + var_134_42 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_41) / var_134_42

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_41 + var_134_42 and arg_131_1.time_ < var_134_41 + var_134_42 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play411031033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 411031033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play411031034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_141_1 = 0
			local var_141_2 = 1.425

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(411031033).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 57 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 57)

				if (57 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 57)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play411031034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 411031034
		arg_142_1.duration_ = 4

		local var_142_0 = {
			zh = 3.7,
			ja = 4
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
				arg_142_0:Play411031035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_145_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_2 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_2

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_2
						arg_142_1.bgmTxt2_.text = var_145_2
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_142_1.time_ and arg_142_1.time_ <= 0.166666666666667 + arg_145_0 then
				arg_142_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_145_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_5 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_5

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_5
						arg_142_1.bgmTxt2_.text = var_145_5
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_145_6 = 0
			local var_145_7 = 0.4

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_8 = arg_142_1:GetWordFromCfg(411031034)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 16 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 16)

				if (16 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 16)) > 0 and var_145_7 < var_145_11 then
					arg_142_1.talkMaxDuration = var_145_11

					if var_145_11 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031034", "story_v_out_411031.awb") ~= 0 then
					local var_145_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031034", "story_v_out_411031.awb") / 1000

					if var_145_12 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_6
					end

					if var_145_8.prefab_name ~= "" and arg_142_1.actors_[var_145_8.prefab_name] ~= nil then
						local var_145_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_8.prefab_name].transform, "story_v_out_411031", "411031034", "story_v_out_411031.awb")

						arg_142_1:RecordAudio("411031034", var_145_13)
						arg_142_1:RecordAudio("411031034", var_145_13)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_411031", "411031034", "story_v_out_411031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_411031", "411031034", "story_v_out_411031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_14 and arg_142_1.time_ < var_145_6 + var_145_14 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play411031035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411031035
		arg_148_1.duration_ = 4.5

		local var_148_0 = {
			zh = 4.5,
			ja = 4.2
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play411031036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.5

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[671].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:GetWordFromCfg(411031035)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 20 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 20)

				if (20 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 20)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031035", "story_v_out_411031.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031035", "story_v_out_411031.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_411031", "411031035", "story_v_out_411031.awb")

						arg_148_1:RecordAudio("411031035", var_151_6)
						arg_148_1:RecordAudio("411031035", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_411031", "411031035", "story_v_out_411031.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_411031", "411031035", "story_v_out_411031.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play411031036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411031036
		arg_152_1.duration_ = 11.27

		local var_152_0 = {
			zh = 6.233,
			ja = 11.266
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play411031037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.925

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(411031036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 37 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 37)

				if (37 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 37)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031036", "story_v_out_411031.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031036", "story_v_out_411031.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_411031", "411031036", "story_v_out_411031.awb")

						arg_152_1:RecordAudio("411031036", var_155_6)
						arg_152_1:RecordAudio("411031036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_411031", "411031036", "story_v_out_411031.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_411031", "411031036", "story_v_out_411031.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play411031037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411031037
		arg_156_1.duration_ = 9

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play411031038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				local var_159_0 = arg_156_1.bgs_.ST17

				arg_156_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_1 = var_159_0:GetComponent("SpriteRenderer")

				if var_159_1 and var_159_1.sprite then
					local var_159_2 = 2 * (var_159_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_0.transform.localScale = Vector3.New(var_159_2 / var_159_1.sprite.bounds.size.y < var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x and var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x or var_159_2 / var_159_1.sprite.bounds.size.y, var_159_2 / var_159_1.sprite.bounds.size.y < var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x and var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x or var_159_2 / var_159_1.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST17" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_3 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_4 = 2

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_4 then
				local var_159_5 = Color.New(0, 0, 0)

				var_159_5.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_3) / var_159_4)
				arg_156_1.mask_.color = var_159_5
			end

			if arg_156_1.time_ >= var_159_3 + var_159_4 and arg_156_1.time_ < var_159_3 + var_159_4 + arg_159_0 then
				local var_159_6 = Color.New(0, 0, 0)

				var_159_6.a = 1
				arg_156_1.mask_.color = var_159_6
			end

			local var_159_7 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_7 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_8 = 2

			if var_159_7 <= arg_156_1.time_ and arg_156_1.time_ < var_159_7 + var_159_8 then
				local var_159_9 = Color.New(0, 0, 0)

				var_159_9.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_7) / var_159_8)
				arg_156_1.mask_.color = var_159_9
			end

			if arg_156_1.time_ >= var_159_7 + var_159_8 and arg_156_1.time_ < var_159_7 + var_159_8 + arg_159_0 then
				local var_159_10 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_10.a = 0
				arg_156_1.mask_.color = var_159_10
			end

			local var_159_11 = arg_156_1.actors_["10071ui_story"].transform

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				arg_156_1.var_.moveOldPos10071ui_story = var_159_11.localPosition
			end

			local var_159_12 = 0.001

			if 2 <= arg_156_1.time_ and arg_156_1.time_ < 2 + var_159_12 then
				var_159_11.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_156_1.time_ - 2) / var_159_12)
				var_159_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_11.position).x, (manager.ui.mainCamera.transform.position - var_159_11.position).y, (manager.ui.mainCamera.transform.position - var_159_11.position).z)
				var_159_11.localEulerAngles.z = 0
				var_159_11.localEulerAngles.x = 0
				var_159_11.localEulerAngles = var_159_11.localEulerAngles
			end

			if arg_156_1.time_ >= 2 + var_159_12 and arg_156_1.time_ < 2 + var_159_12 + arg_159_0 then
				var_159_11.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				var_159_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_11.position).x, (manager.ui.mainCamera.transform.position - var_159_11.position).y, (manager.ui.mainCamera.transform.position - var_159_11.position).z)
				var_159_11.localEulerAngles.z = 0
				var_159_11.localEulerAngles.x = 0
				var_159_11.localEulerAngles = var_159_11.localEulerAngles
			end

			local var_159_13 = arg_156_1.actors_["10071ui_story"]

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 and not isNil(var_159_13) and arg_156_1.var_.characterEffect10071ui_story == nil then
				arg_156_1.var_.characterEffect10071ui_story = var_159_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_14 = 0.200000002980232

			if 2 <= arg_156_1.time_ and arg_156_1.time_ < 2 + var_159_14 and not isNil(var_159_13) then
				if arg_156_1.var_.characterEffect10071ui_story and not isNil(var_159_13) then
					arg_156_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 2) / var_159_14)
				end
			end

			if arg_156_1.time_ >= 2 + var_159_14 and arg_156_1.time_ < 2 + var_159_14 + arg_159_0 and not isNil(var_159_13) and arg_156_1.var_.characterEffect10071ui_story then
				arg_156_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_159_15 = arg_156_1.actors_["10058ui_story"].transform

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				arg_156_1.var_.moveOldPos10058ui_story = var_159_15.localPosition
			end

			local var_159_16 = 0.001

			if 2 <= arg_156_1.time_ and arg_156_1.time_ < 2 + var_159_16 then
				var_159_15.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_156_1.time_ - 2) / var_159_16)
				var_159_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_15.position).x, (manager.ui.mainCamera.transform.position - var_159_15.position).y, (manager.ui.mainCamera.transform.position - var_159_15.position).z)
				var_159_15.localEulerAngles.z = 0
				var_159_15.localEulerAngles.x = 0
				var_159_15.localEulerAngles = var_159_15.localEulerAngles
			end

			if arg_156_1.time_ >= 2 + var_159_16 and arg_156_1.time_ < 2 + var_159_16 + arg_159_0 then
				var_159_15.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_159_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_15.position).x, (manager.ui.mainCamera.transform.position - var_159_15.position).y, (manager.ui.mainCamera.transform.position - var_159_15.position).z)
				var_159_15.localEulerAngles.z = 0
				var_159_15.localEulerAngles.x = 0
				var_159_15.localEulerAngles = var_159_15.localEulerAngles
			end

			local var_159_17 = arg_156_1.actors_["10058ui_story"]

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 and not isNil(var_159_17) and arg_156_1.var_.characterEffect10058ui_story == nil then
				arg_156_1.var_.characterEffect10058ui_story = var_159_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_18 = 0.200000002980232

			if 2 <= arg_156_1.time_ and arg_156_1.time_ < 2 + var_159_18 and not isNil(var_159_17) then
				if arg_156_1.var_.characterEffect10058ui_story and not isNil(var_159_17) then
					arg_156_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 2) / var_159_18)
				end
			end

			if arg_156_1.time_ >= 2 + var_159_18 and arg_156_1.time_ < 2 + var_159_18 + arg_159_0 and not isNil(var_159_17) and arg_156_1.var_.characterEffect10058ui_story then
				arg_156_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				arg_156_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				arg_156_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2.03400000184774 < arg_156_1.time_ and arg_156_1.time_ <= 2.03400000184774 + arg_159_0 then
				arg_156_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2.03400000184774 < arg_156_1.time_ and arg_156_1.time_ <= 2.03400000184774 + arg_159_0 then
				arg_156_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_19 = 4
			local var_159_20 = 0.525

			if 4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_21 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_21:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_22 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(411031037).content)

				arg_156_1.text_.text = var_159_22

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_24 = 22 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_22) / 22)

				if (22 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_22) / 22)) > 0 and var_159_20 < var_159_24 then
					arg_156_1.talkMaxDuration = var_159_24
					var_159_19 = var_159_19 + 0.3

					if var_159_24 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_24 + var_159_19
					end
				end

				arg_156_1.text_.text = var_159_22
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = var_159_19 + 0.3
			local var_159_26 = math.max(var_159_20, arg_156_1.talkMaxDuration)

			if var_159_19 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_25 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_25) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_25 + var_159_26 and arg_156_1.time_ < var_159_25 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play411031038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 411031038
		arg_162_1.duration_ = 8.77

		local var_162_0 = {
			zh = 6.033,
			ja = 8.766
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
				arg_162_0:Play411031039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10058ui_story = arg_162_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).z)
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles = arg_162_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_162_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10058ui_story"].transform.position).z)
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10058ui_story"].transform.localEulerAngles = arg_162_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["10058ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect10058ui_story == nil then
				arg_162_1.var_.characterEffect10058ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect10058ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect10058ui_story then
				arg_162_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_165_4 = 0
			local var_165_5 = 0.825

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(411031038)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 33 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 33)

				if (33 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 33)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031038", "story_v_out_411031.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031038", "story_v_out_411031.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_411031", "411031038", "story_v_out_411031.awb")

						arg_162_1:RecordAudio("411031038", var_165_11)
						arg_162_1:RecordAudio("411031038", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_411031", "411031038", "story_v_out_411031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_411031", "411031038", "story_v_out_411031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play411031039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 411031039
		arg_166_1.duration_ = 5.83

		local var_166_0 = {
			zh = 3.8,
			ja = 5.833
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
				arg_166_0:Play411031040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10071ui_story = arg_166_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10071ui_story, Vector3.New(-0.7, -0.9, -6.26), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).z)
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles = arg_166_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(-0.7, -0.9, -6.26)
				arg_166_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10071ui_story"].transform.position).z)
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10071ui_story"].transform.localEulerAngles = arg_166_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["10071ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10071ui_story == nil then
				arg_166_1.var_.characterEffect10071ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect10071ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10071ui_story then
				arg_166_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_169_4 = arg_166_1.actors_["10058ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect10058ui_story == nil then
				arg_166_1.var_.characterEffect10058ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_5 = 0.166000001132488

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_5 and not isNil(var_169_4) then
				if arg_166_1.var_.characterEffect10058ui_story and not isNil(var_169_4) then
					arg_166_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_5)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_5 and arg_166_1.time_ < 0 + var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect10058ui_story then
				arg_166_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_169_6 = 0
			local var_169_7 = 0.45

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(411031039)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 18 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 18)

				if (18 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 18)) > 0 and var_169_7 < var_169_11 then
					arg_166_1.talkMaxDuration = var_169_11

					if var_169_11 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031039", "story_v_out_411031.awb") ~= 0 then
					local var_169_12 = manager.audio:GetVoiceLength("story_v_out_411031", "411031039", "story_v_out_411031.awb") / 1000

					if var_169_12 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_6
					end

					if var_169_8.prefab_name ~= "" and arg_166_1.actors_[var_169_8.prefab_name] ~= nil then
						local var_169_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_8.prefab_name].transform, "story_v_out_411031", "411031039", "story_v_out_411031.awb")

						arg_166_1:RecordAudio("411031039", var_169_13)
						arg_166_1:RecordAudio("411031039", var_169_13)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_411031", "411031039", "story_v_out_411031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_411031", "411031039", "story_v_out_411031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play411031040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 411031040
		arg_170_1.duration_ = 6.57

		local var_170_0 = {
			zh = 4.633,
			ja = 6.566
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
				arg_170_0:Play411031041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10071ui_story"]) and arg_170_1.var_.characterEffect10071ui_story == nil then
				arg_170_1.var_.characterEffect10071ui_story = arg_170_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10071ui_story"]) then
				if arg_170_1.var_.characterEffect10071ui_story and not isNil(arg_170_1.actors_["10071ui_story"]) then
					arg_170_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10071ui_story"]) and arg_170_1.var_.characterEffect10071ui_story then
				arg_170_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_173_1 = arg_170_1.actors_["10058ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect10058ui_story == nil then
				arg_170_1.var_.characterEffect10058ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.166000001132488

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect10058ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect10058ui_story then
				arg_170_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_173_4 = 0
			local var_173_5 = 0.625

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(411031040)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 25 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 25)

				if (25 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 25)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031040", "story_v_out_411031.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031040", "story_v_out_411031.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_411031", "411031040", "story_v_out_411031.awb")

						arg_170_1:RecordAudio("411031040", var_173_11)
						arg_170_1:RecordAudio("411031040", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_411031", "411031040", "story_v_out_411031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_411031", "411031040", "story_v_out_411031.awb")
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
	Play411031041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 411031041
		arg_174_1.duration_ = 3.93

		local var_174_0 = {
			zh = 3.933,
			ja = 3.366
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
				arg_174_0:Play411031042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10071ui_story"]) and arg_174_1.var_.characterEffect10071ui_story == nil then
				arg_174_1.var_.characterEffect10071ui_story = arg_174_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10071ui_story"]) then
				if arg_174_1.var_.characterEffect10071ui_story and not isNil(arg_174_1.actors_["10071ui_story"]) then
					arg_174_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10071ui_story"]) and arg_174_1.var_.characterEffect10071ui_story then
				arg_174_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_177_2 = arg_174_1.actors_["10058ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect10058ui_story == nil then
				arg_174_1.var_.characterEffect10058ui_story = var_177_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_3 = 0.166000001132488

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.characterEffect10058ui_story and not isNil(var_177_2) then
					arg_174_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_3)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect10058ui_story then
				arg_174_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_177_4 = 0
			local var_177_5 = 0.3

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(411031041)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 12 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 12)

				if (12 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 12)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031041", "story_v_out_411031.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031041", "story_v_out_411031.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_out_411031", "411031041", "story_v_out_411031.awb")

						arg_174_1:RecordAudio("411031041", var_177_11)
						arg_174_1:RecordAudio("411031041", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_411031", "411031041", "story_v_out_411031.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_411031", "411031041", "story_v_out_411031.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_12 and arg_174_1.time_ < var_177_4 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play411031042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411031042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play411031043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10071ui_story = arg_178_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10071ui_story, Vector3.New(0, -0.9, -6.26), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).z)
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles = arg_178_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0, -0.9, -6.26)
				arg_178_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10071ui_story"].transform.position).z)
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["10071ui_story"].transform.localEulerAngles = arg_178_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["10071ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect10071ui_story == nil then
				arg_178_1.var_.characterEffect10071ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect10071ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_2)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect10071ui_story then
				arg_178_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_181_3 = arg_178_1.actors_["10058ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10058ui_story = var_181_3.localPosition
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_3.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_4)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_3.localPosition = Vector3.New(0, 100, 0)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			local var_181_5 = arg_178_1.actors_["10058ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect10058ui_story == nil then
				arg_178_1.var_.characterEffect10058ui_story = var_181_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_6 and not isNil(var_181_5) then
				if arg_178_1.var_.characterEffect10058ui_story and not isNil(var_181_5) then
					arg_178_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_6)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_6 and arg_178_1.time_ < 0 + var_181_6 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect10058ui_story then
				arg_178_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_181_7 = 0
			local var_181_8 = 0.775

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_9 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(411031042).content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 31 <= 0 and var_181_8 or var_181_8 * (utf8.len(var_181_9) / 31)

				if (31 <= 0 and var_181_8 or var_181_8 * (utf8.len(var_181_9) / 31)) > 0 and var_181_8 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_7 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_7
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_8, arg_178_1.talkMaxDuration)

			if var_181_7 <= arg_178_1.time_ and arg_178_1.time_ < var_181_7 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_7) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_7 + var_181_12 and arg_178_1.time_ < var_181_7 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play411031043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411031043
		arg_182_1.duration_ = 6.17

		local var_182_0 = {
			zh = 6.166,
			ja = 4
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
				arg_182_0:Play411031044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10071ui_story"]) and arg_182_1.var_.characterEffect10071ui_story == nil then
				arg_182_1.var_.characterEffect10071ui_story = arg_182_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10071ui_story"]) then
				if arg_182_1.var_.characterEffect10071ui_story and not isNil(arg_182_1.actors_["10071ui_story"]) then
					arg_182_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10071ui_story"]) and arg_182_1.var_.characterEffect10071ui_story then
				arg_182_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_185_2 = 0
			local var_185_3 = 0.575

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(411031043)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 23 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 23)

				if (23 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 23)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031043", "story_v_out_411031.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031043", "story_v_out_411031.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_411031", "411031043", "story_v_out_411031.awb")

						arg_182_1:RecordAudio("411031043", var_185_9)
						arg_182_1:RecordAudio("411031043", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_411031", "411031043", "story_v_out_411031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_411031", "411031043", "story_v_out_411031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play411031044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 411031044
		arg_186_1.duration_ = 9

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play411031045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				local var_189_0 = arg_186_1.bgs_.I11r

				arg_186_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_189_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_1 = var_189_0:GetComponent("SpriteRenderer")

				if var_189_1 and var_189_1.sprite then
					local var_189_2 = 2 * (var_189_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_189_0.transform.localScale = Vector3.New(var_189_2 / var_189_1.sprite.bounds.size.y < var_189_2 * manager.ui.mainCameraCom_.aspect / var_189_1.sprite.bounds.size.x and var_189_2 * manager.ui.mainCameraCom_.aspect / var_189_1.sprite.bounds.size.x or var_189_2 / var_189_1.sprite.bounds.size.y, var_189_2 / var_189_1.sprite.bounds.size.y < var_189_2 * manager.ui.mainCameraCom_.aspect / var_189_1.sprite.bounds.size.x and var_189_2 * manager.ui.mainCameraCom_.aspect / var_189_1.sprite.bounds.size.x or var_189_2 / var_189_1.sprite.bounds.size.y, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "I11r" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_3 = 0

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_4 = 2

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_4 then
				local var_189_5 = Color.New(0, 0, 0)

				var_189_5.a = Mathf.Lerp(0, 1, (arg_186_1.time_ - var_189_3) / var_189_4)
				arg_186_1.mask_.color = var_189_5
			end

			if arg_186_1.time_ >= var_189_3 + var_189_4 and arg_186_1.time_ < var_189_3 + var_189_4 + arg_189_0 then
				local var_189_6 = Color.New(0, 0, 0)

				var_189_6.a = 1
				arg_186_1.mask_.color = var_189_6
			end

			local var_189_7 = 2

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_7 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_8 = 2

			if var_189_7 <= arg_186_1.time_ and arg_186_1.time_ < var_189_7 + var_189_8 then
				local var_189_9 = Color.New(0, 0, 0)

				var_189_9.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_7) / var_189_8)
				arg_186_1.mask_.color = var_189_9
			end

			if arg_186_1.time_ >= var_189_7 + var_189_8 and arg_186_1.time_ < var_189_7 + var_189_8 + arg_189_0 then
				local var_189_10 = Color.New(0, 0, 0)

				arg_186_1.mask_.enabled = false
				var_189_10.a = 0
				arg_186_1.mask_.color = var_189_10
			end

			local var_189_11 = arg_186_1.actors_["10071ui_story"].transform

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				arg_186_1.var_.moveOldPos10071ui_story = var_189_11.localPosition
			end

			local var_189_12 = 0.001

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_12 then
				var_189_11.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10071ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 2) / var_189_12)
				var_189_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_11.position).x, (manager.ui.mainCamera.transform.position - var_189_11.position).y, (manager.ui.mainCamera.transform.position - var_189_11.position).z)
				var_189_11.localEulerAngles.z = 0
				var_189_11.localEulerAngles.x = 0
				var_189_11.localEulerAngles = var_189_11.localEulerAngles
			end

			if arg_186_1.time_ >= 2 + var_189_12 and arg_186_1.time_ < 2 + var_189_12 + arg_189_0 then
				var_189_11.localPosition = Vector3.New(0, 100, 0)
				var_189_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_11.position).x, (manager.ui.mainCamera.transform.position - var_189_11.position).y, (manager.ui.mainCamera.transform.position - var_189_11.position).z)
				var_189_11.localEulerAngles.z = 0
				var_189_11.localEulerAngles.x = 0
				var_189_11.localEulerAngles = var_189_11.localEulerAngles
			end

			local var_189_13 = arg_186_1.actors_["10071ui_story"]

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 and not isNil(var_189_13) and arg_186_1.var_.characterEffect10071ui_story == nil then
				arg_186_1.var_.characterEffect10071ui_story = var_189_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_14 = 0.200000002980232

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_14 and not isNil(var_189_13) then
				if arg_186_1.var_.characterEffect10071ui_story and not isNil(var_189_13) then
					arg_186_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 2) / var_189_14)
				end
			end

			if arg_186_1.time_ >= 2 + var_189_14 and arg_186_1.time_ < 2 + var_189_14 + arg_189_0 and not isNil(var_189_13) and arg_186_1.var_.characterEffect10071ui_story then
				arg_186_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_15 = 4
			local var_189_16 = 1.2

			if 4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_17 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_17:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(411031044).content)

				arg_186_1.text_.text = var_189_18

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 48 <= 0 and var_189_16 or var_189_16 * (utf8.len(var_189_18) / 48)

				if (48 <= 0 and var_189_16 or var_189_16 * (utf8.len(var_189_18) / 48)) > 0 and var_189_16 < var_189_20 then
					arg_186_1.talkMaxDuration = var_189_20
					var_189_15 = var_189_15 + 0.3

					if var_189_20 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_20 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_18
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = var_189_15 + 0.3
			local var_189_22 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_21 + var_189_22 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_21) / var_189_22

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_21 + var_189_22 and arg_186_1.time_ < var_189_21 + var_189_22 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play411031045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 411031045
		arg_192_1.duration_ = 7.7

		local var_192_0 = {
			zh = 4.5,
			ja = 7.7
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play411031046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_195_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_192_1.stage_.transform)

				var_195_0.name = "1095ui_story"
				var_195_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["1095ui_story"] = var_195_0

				local var_195_1 = var_195_0:GetComponentInChildren(typeof(CharacterEffect))

				var_195_1.enabled = true

				local var_195_2 = GameObjectTools.GetOrAddComponent(var_195_0, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_1.transform, false)

				arg_192_1.var_["1095ui_story" .. "Animator"] = var_195_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_192_1.var_["1095ui_story" .. "LipSync"] = var_195_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_195_3 = arg_192_1.actors_["1095ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1095ui_story = var_195_3.localPosition
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_3.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_192_1.time_ - 0) / var_195_4)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			local var_195_5 = arg_192_1.actors_["1095ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_5) and arg_192_1.var_.characterEffect1095ui_story == nil then
				arg_192_1.var_.characterEffect1095ui_story = var_195_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 and not isNil(var_195_5) then
				if arg_192_1.var_.characterEffect1095ui_story and not isNil(var_195_5) then
					arg_192_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 and not isNil(var_195_5) and arg_192_1.var_.characterEffect1095ui_story then
				arg_192_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_195_8 = 0
			local var_195_9 = 0.575

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(411031045)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 23 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 23)

				if (23 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 23)) > 0 and var_195_9 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031045", "story_v_out_411031.awb") ~= 0 then
					local var_195_14 = manager.audio:GetVoiceLength("story_v_out_411031", "411031045", "story_v_out_411031.awb") / 1000

					if var_195_14 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_8
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_out_411031", "411031045", "story_v_out_411031.awb")

						arg_192_1:RecordAudio("411031045", var_195_15)
						arg_192_1:RecordAudio("411031045", var_195_15)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_411031", "411031045", "story_v_out_411031.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_411031", "411031045", "story_v_out_411031.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play411031046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 411031046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play411031047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1095ui_story"]) and arg_196_1.var_.characterEffect1095ui_story == nil then
				arg_196_1.var_.characterEffect1095ui_story = arg_196_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1095ui_story"]) then
				if arg_196_1.var_.characterEffect1095ui_story and not isNil(arg_196_1.actors_["1095ui_story"]) then
					arg_196_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_0)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1095ui_story"]) and arg_196_1.var_.characterEffect1095ui_story then
				arg_196_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_199_1 = 0
			local var_199_2 = 0.7

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(411031046).content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 28 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 28)

				if (28 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 28)) > 0 and var_199_2 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_6 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_6 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_6

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_6 and arg_196_1.time_ < var_199_1 + var_199_6 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play411031047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 411031047
		arg_200_1.duration_ = 9.07

		local var_200_0 = {
			zh = 8.333,
			ja = 9.066
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play411031048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.15

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:GetWordFromCfg(411031047)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 46 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 46)

				if (46 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 46)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031047", "story_v_out_411031.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031047", "story_v_out_411031.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_411031", "411031047", "story_v_out_411031.awb")

						arg_200_1:RecordAudio("411031047", var_203_6)
						arg_200_1:RecordAudio("411031047", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_411031", "411031047", "story_v_out_411031.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_411031", "411031047", "story_v_out_411031.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play411031048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 411031048
		arg_204_1.duration_ = 8.7

		local var_204_0 = {
			zh = 8.7,
			ja = 8.266
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play411031049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1095ui_story"]) and arg_204_1.var_.characterEffect1095ui_story == nil then
				arg_204_1.var_.characterEffect1095ui_story = arg_204_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1095ui_story"]) then
				if arg_204_1.var_.characterEffect1095ui_story and not isNil(arg_204_1.actors_["1095ui_story"]) then
					arg_204_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1095ui_story"]) and arg_204_1.var_.characterEffect1095ui_story then
				arg_204_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_207_2 = 0
			local var_207_3 = 1.2

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(411031048)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 48 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 48)

				if (48 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 48)) > 0 and var_207_3 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031048", "story_v_out_411031.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031048", "story_v_out_411031.awb") / 1000

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_411031", "411031048", "story_v_out_411031.awb")

						arg_204_1:RecordAudio("411031048", var_207_9)
						arg_204_1:RecordAudio("411031048", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_411031", "411031048", "story_v_out_411031.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_411031", "411031048", "story_v_out_411031.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_10 and arg_204_1.time_ < var_207_2 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play411031049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 411031049
		arg_208_1.duration_ = 7.87

		local var_208_0 = {
			zh = 5.266,
			ja = 7.866
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play411031050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.775

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(411031049)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 30 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 30)

				if (30 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 30)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031049", "story_v_out_411031.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031049", "story_v_out_411031.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_411031", "411031049", "story_v_out_411031.awb")

						arg_208_1:RecordAudio("411031049", var_211_6)
						arg_208_1:RecordAudio("411031049", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_411031", "411031049", "story_v_out_411031.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_411031", "411031049", "story_v_out_411031.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play411031050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 411031050
		arg_212_1.duration_ = 7.57

		local var_212_0 = {
			zh = 7.566,
			ja = 4.933
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play411031051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 1.075

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(411031050)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 43 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 43)

				if (43 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 43)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031050", "story_v_out_411031.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031050", "story_v_out_411031.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_411031", "411031050", "story_v_out_411031.awb")

						arg_212_1:RecordAudio("411031050", var_215_6)
						arg_212_1:RecordAudio("411031050", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_411031", "411031050", "story_v_out_411031.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_411031", "411031050", "story_v_out_411031.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play411031051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 411031051
		arg_216_1.duration_ = 1.53

		local var_216_0 = {
			zh = 1.533,
			ja = 0.999999999999
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play411031052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.075

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_1 = arg_216_1:GetWordFromCfg(411031051)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 3 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 3)

				if (3 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 3)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031051", "story_v_out_411031.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031051", "story_v_out_411031.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_411031", "411031051", "story_v_out_411031.awb")

						arg_216_1:RecordAudio("411031051", var_219_6)
						arg_216_1:RecordAudio("411031051", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_411031", "411031051", "story_v_out_411031.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_411031", "411031051", "story_v_out_411031.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play411031052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 411031052
		arg_220_1.duration_ = 7

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play411031053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if arg_220_1.bgs_.A01 == nil then
				local var_223_0 = Object.Instantiate(arg_220_1.paintGo_)

				var_223_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A01")
				var_223_0.name = "A01"
				var_223_0.transform.parent = arg_220_1.stage_.transform
				var_223_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.bgs_.A01 = var_223_0
			end

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= 2 + arg_223_0 then
				local var_223_1 = arg_220_1.bgs_.A01

				arg_220_1.bgs_.A01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_223_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_223_2 = var_223_1:GetComponent("SpriteRenderer")

				if var_223_2 and var_223_2.sprite then
					local var_223_3 = 2 * (var_223_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_223_1.transform.localScale = Vector3.New(var_223_3 / var_223_2.sprite.bounds.size.y < var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x and var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x or var_223_3 / var_223_2.sprite.bounds.size.y, var_223_3 / var_223_2.sprite.bounds.size.y < var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x and var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x or var_223_3 / var_223_2.sprite.bounds.size.y, 0)
				end

				for iter_223_0, iter_223_1 in pairs(arg_220_1.bgs_) do
					if iter_223_0 ~= "A01" then
						iter_223_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_223_4 = 0

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_5 = 2

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_5 then
				local var_223_6 = Color.New(0, 0, 0)

				var_223_6.a = Mathf.Lerp(0, 1, (arg_220_1.time_ - var_223_4) / var_223_5)
				arg_220_1.mask_.color = var_223_6
			end

			if arg_220_1.time_ >= var_223_4 + var_223_5 and arg_220_1.time_ < var_223_4 + var_223_5 + arg_223_0 then
				local var_223_7 = Color.New(0, 0, 0)

				var_223_7.a = 1
				arg_220_1.mask_.color = var_223_7
			end

			local var_223_8 = 2

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_9 = 2

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_9 then
				local var_223_10 = Color.New(0, 0, 0)

				var_223_10.a = Mathf.Lerp(1, 0, (arg_220_1.time_ - var_223_8) / var_223_9)
				arg_220_1.mask_.color = var_223_10
			end

			if arg_220_1.time_ >= var_223_8 + var_223_9 and arg_220_1.time_ < var_223_8 + var_223_9 + arg_223_0 then
				local var_223_11 = Color.New(0, 0, 0)

				arg_220_1.mask_.enabled = false
				var_223_11.a = 0
				arg_220_1.mask_.color = var_223_11
			end

			local var_223_12 = arg_220_1.actors_["1095ui_story"].transform

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= 2 + arg_223_0 then
				arg_220_1.var_.moveOldPos1095ui_story = var_223_12.localPosition
			end

			local var_223_13 = 0.001

			if 2 <= arg_220_1.time_ and arg_220_1.time_ < 2 + var_223_13 then
				var_223_12.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 2) / var_223_13)
				var_223_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_12.position).x, (manager.ui.mainCamera.transform.position - var_223_12.position).y, (manager.ui.mainCamera.transform.position - var_223_12.position).z)
				var_223_12.localEulerAngles.z = 0
				var_223_12.localEulerAngles.x = 0
				var_223_12.localEulerAngles = var_223_12.localEulerAngles
			end

			if arg_220_1.time_ >= 2 + var_223_13 and arg_220_1.time_ < 2 + var_223_13 + arg_223_0 then
				var_223_12.localPosition = Vector3.New(0, 100, 0)
				var_223_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_12.position).x, (manager.ui.mainCamera.transform.position - var_223_12.position).y, (manager.ui.mainCamera.transform.position - var_223_12.position).z)
				var_223_12.localEulerAngles.z = 0
				var_223_12.localEulerAngles.x = 0
				var_223_12.localEulerAngles = var_223_12.localEulerAngles
			end

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= 2 + arg_223_0 then
				arg_220_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_fight_loop", "")
			end

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= 2 + arg_223_0 then
				arg_220_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_16 = 2
			local var_223_17 = 0.625

			if 2 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_18 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_18:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_19 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(411031052).content)

				arg_220_1.text_.text = var_223_19

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_21 = 25 <= 0 and var_223_17 or var_223_17 * (utf8.len(var_223_19) / 25)

				if (25 <= 0 and var_223_17 or var_223_17 * (utf8.len(var_223_19) / 25)) > 0 and var_223_17 < var_223_21 then
					arg_220_1.talkMaxDuration = var_223_21
					var_223_16 = var_223_16 + 0.3

					if var_223_21 + var_223_16 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_21 + var_223_16
					end
				end

				arg_220_1.text_.text = var_223_19
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_22 = var_223_16 + 0.3
			local var_223_23 = math.max(var_223_17, arg_220_1.talkMaxDuration)

			if var_223_16 + 0.3 <= arg_220_1.time_ and arg_220_1.time_ < var_223_22 + var_223_23 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_22) / var_223_23

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_22 + var_223_23 and arg_220_1.time_ < var_223_22 + var_223_23 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play411031053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411031053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play411031054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				local var_229_0 = arg_226_1.var_.effect1

				if not arg_226_1.var_.effect1 then
					var_229_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_229_0.name = "1"
					arg_226_1.var_.effect1 = var_229_0
				else
					var_229_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_229_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_229_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.43333333333333 < arg_226_1.time_ and arg_226_1.time_ <= 1.43333333333333 + arg_229_0 then
				if arg_226_1.var_.effect1 then
					Object.Destroy(arg_226_1.var_.effect1)

					arg_226_1.var_.effect1 = nil
				end
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_131", "se_story_131__1095_skill1_2", "")
			end

			local var_229_4 = 0
			local var_229_5 = 1.225

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(411031053).content)

				arg_226_1.text_.text = var_229_6

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_8 = 49 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_6) / 49)

				if (49 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_6) / 49)) > 0 and var_229_5 < var_229_8 then
					arg_226_1.talkMaxDuration = var_229_8

					if var_229_8 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_6
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_9 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_9 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_9

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_9 and arg_226_1.time_ < var_229_4 + var_229_9 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411031054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411031054
		arg_230_1.duration_ = 2.7

		local var_230_0 = {
			zh = 2.6,
			ja = 2.7
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
				arg_230_0:Play411031055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.3

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:GetWordFromCfg(411031054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 12)

				if (12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 12)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031054", "story_v_out_411031.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_411031", "411031054", "story_v_out_411031.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_411031", "411031054", "story_v_out_411031.awb")

						arg_230_1:RecordAudio("411031054", var_233_6)
						arg_230_1:RecordAudio("411031054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_411031", "411031054", "story_v_out_411031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_411031", "411031054", "story_v_out_411031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play411031055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411031055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play411031056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 1.55

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(411031055).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 62 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 62)

				if (62 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 62)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play411031056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411031056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play411031057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.525

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(411031056).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 21 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 21)

				if (21 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 21)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play411031057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 411031057
		arg_242_1.duration_ = 2.23

		local var_242_0 = {
			zh = 2.233,
			ja = 1.933
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play411031058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1095ui_story = arg_242_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).z)
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles = arg_242_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_242_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).z)
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles = arg_242_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1095ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1095ui_story == nil then
				arg_242_1.var_.characterEffect1095ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1095ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1095ui_story then
				arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_4 = 0
			local var_245_5 = 0.3

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(411031057)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 12 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 12)

				if (12 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 12)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031057", "story_v_out_411031.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_411031", "411031057", "story_v_out_411031.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_411031", "411031057", "story_v_out_411031.awb")

						arg_242_1:RecordAudio("411031057", var_245_11)
						arg_242_1:RecordAudio("411031057", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_411031", "411031057", "story_v_out_411031.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_411031", "411031057", "story_v_out_411031.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play411031058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 411031058
		arg_246_1.duration_ = 6.3

		local var_246_0 = {
			zh = 6.3,
			ja = 3.4
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play411031059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1095ui_story"]) and arg_246_1.var_.characterEffect1095ui_story == nil then
				arg_246_1.var_.characterEffect1095ui_story = arg_246_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1095ui_story"]) then
				if arg_246_1.var_.characterEffect1095ui_story and not isNil(arg_246_1.actors_["1095ui_story"]) then
					arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1095ui_story"]) and arg_246_1.var_.characterEffect1095ui_story then
				arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.6

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(411031058)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 24 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_4) / 24)

				if (24 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_4) / 24)) > 0 and var_249_2 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031058", "story_v_out_411031.awb") ~= 0 then
					local var_249_7 = manager.audio:GetVoiceLength("story_v_out_411031", "411031058", "story_v_out_411031.awb") / 1000

					if var_249_7 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_1
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_411031", "411031058", "story_v_out_411031.awb")

						arg_246_1:RecordAudio("411031058", var_249_8)
						arg_246_1:RecordAudio("411031058", var_249_8)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_411031", "411031058", "story_v_out_411031.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_411031", "411031058", "story_v_out_411031.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_9 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_9 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_9

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_9 and arg_246_1.time_ < var_249_1 + var_249_9 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play411031059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 411031059
		arg_250_1.duration_ = 9.53

		local var_250_0 = {
			zh = 6.633,
			ja = 9.533
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
			arg_250_1.auto_ = false
		end

		function arg_250_1.playNext_(arg_252_0)
			arg_250_1.onStoryFinished_()
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1095ui_story"]) and arg_250_1.var_.characterEffect1095ui_story == nil then
				arg_250_1.var_.characterEffect1095ui_story = arg_250_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1095ui_story"]) then
				if arg_250_1.var_.characterEffect1095ui_story and not isNil(arg_250_1.actors_["1095ui_story"]) then
					arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1095ui_story"]) and arg_250_1.var_.characterEffect1095ui_story then
				arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_253_2 = 0
			local var_253_3 = 0.85

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(411031059)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 34 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 34)

				if (34 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 34)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411031", "411031059", "story_v_out_411031.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_411031", "411031059", "story_v_out_411031.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_out_411031", "411031059", "story_v_out_411031.awb")

						arg_250_1:RecordAudio("411031059", var_253_9)
						arg_250_1:RecordAudio("411031059", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_411031", "411031059", "story_v_out_411031.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_411031", "411031059", "story_v_out_411031.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A01"
	},
	voices = {
		"story_v_out_411031.awb"
	}
}
