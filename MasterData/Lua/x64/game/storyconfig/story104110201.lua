return {
	Play411021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11m == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11m")
				var_4_0.name = "I11m"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11m = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11m

				arg_1_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11m" then
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

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
			local var_4_15 = 0.85

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411021001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)

				if (34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)) > 0 and var_4_15 < var_4_19 then
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
	Play411021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411021002
		arg_9_1.duration_ = 3.87

		local var_9_0 = {
			zh = 3.866,
			ja = 3.766
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
				arg_9_0:Play411021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(411021002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)

				if (22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021002", "story_v_out_411021.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021002", "story_v_out_411021.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_411021", "411021002", "story_v_out_411021.awb")

						arg_9_1:RecordAudio("411021002", var_12_6)
						arg_9_1:RecordAudio("411021002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411021", "411021002", "story_v_out_411021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411021", "411021002", "story_v_out_411021.awb")
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
	Play411021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411021003
		arg_13_1.duration_ = 4.27

		local var_13_0 = {
			zh = 3.633,
			ja = 4.266
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
				arg_13_0:Play411021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1095ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1095ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1095ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1095ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1095ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1095ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1095ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1095ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
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

				local var_16_10 = arg_13_1:GetWordFromCfg(411021003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 16 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 16)

				if (16 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 16)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021003", "story_v_out_411021.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_411021", "411021003", "story_v_out_411021.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_411021", "411021003", "story_v_out_411021.awb")

						arg_13_1:RecordAudio("411021003", var_16_15)
						arg_13_1:RecordAudio("411021003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411021", "411021003", "story_v_out_411021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411021", "411021003", "story_v_out_411021.awb")
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
				actorName = "1095ui_story",
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
	Play411021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411021004
		arg_17_1.duration_ = 8.5

		local var_17_0 = {
			zh = 7.433,
			ja = 8.5
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
				arg_17_0:Play411021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = arg_17_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(arg_17_1.actors_["1095ui_story"]) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.95

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(411021004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 38 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 38)

				if (38 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 38)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021004", "story_v_out_411021.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_411021", "411021004", "story_v_out_411021.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_411021", "411021004", "story_v_out_411021.awb")

						arg_17_1:RecordAudio("411021004", var_20_8)
						arg_17_1:RecordAudio("411021004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411021", "411021004", "story_v_out_411021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411021", "411021004", "story_v_out_411021.awb")
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
	Play411021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411021005
		arg_21_1.duration_ = 10.2

		local var_21_0 = {
			zh = 6.533,
			ja = 10.2
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
				arg_21_0:Play411021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = arg_21_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(arg_21_1.actors_["1095ui_story"]) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
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

				local var_24_4 = arg_21_1:GetWordFromCfg(411021005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 29 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 29)

				if (29 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 29)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021005", "story_v_out_411021.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_411021", "411021005", "story_v_out_411021.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_411021", "411021005", "story_v_out_411021.awb")

						arg_21_1:RecordAudio("411021005", var_24_9)
						arg_21_1:RecordAudio("411021005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411021", "411021005", "story_v_out_411021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411021", "411021005", "story_v_out_411021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play411021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = arg_25_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(arg_25_1.actors_["1095ui_story"]) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(411021006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)

				if (23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)) > 0 and var_28_2 < var_28_5 then
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
	Play411021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411021007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = arg_29_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(arg_29_1.actors_["1095ui_story"]) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
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

				local var_32_4 = arg_29_1:GetWordFromCfg(411021007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 7 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 7)

				if (7 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 7)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021007", "story_v_out_411021.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_411021", "411021007", "story_v_out_411021.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_411021", "411021007", "story_v_out_411021.awb")

						arg_29_1:RecordAudio("411021007", var_32_9)
						arg_29_1:RecordAudio("411021007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411021", "411021007", "story_v_out_411021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411021", "411021007", "story_v_out_411021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play411021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411021008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411021009(arg_33_1)
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

			local var_36_1 = 0
			local var_36_2 = 0.975

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(411021008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 39 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 39)

				if (39 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 39)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411021009
		arg_37_1.duration_ = 7

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_0 = arg_37_1.bgs_.I11m

				arg_37_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_1 = var_40_0:GetComponent("SpriteRenderer")

				if var_40_1 and var_40_1.sprite then
					local var_40_2 = 2 * (var_40_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_0.transform.localScale = Vector3.New(var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I11m" then
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

				var_40_5.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_3) / var_40_4)
				arg_37_1.mask_.color = var_40_5
			end

			if arg_37_1.time_ >= var_40_3 + var_40_4 and arg_37_1.time_ < var_40_3 + var_40_4 + arg_40_0 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = 1
				arg_37_1.mask_.color = var_40_6
			end

			local var_40_7 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_8 = 2

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 then
				local var_40_9 = Color.New(0, 0, 0)

				var_40_9.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_7) / var_40_8)
				arg_37_1.mask_.color = var_40_9
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 then
				local var_40_10 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_10.a = 0
				arg_37_1.mask_.color = var_40_10
			end

			local var_40_11 = arg_37_1.actors_["1095ui_story"]

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_12 = 0.200000002980232

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_12 and not isNil(var_40_11) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_11) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 2) / var_40_12)
				end
			end

			if arg_37_1.time_ >= 2 + var_40_12 and arg_37_1.time_ < 2 + var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_40_13 = arg_37_1.actors_["1095ui_story"].transform

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = var_40_13.localPosition
			end

			local var_40_14 = 0.001

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_14 then
				var_40_13.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_37_1.time_ - 2) / var_40_14)
				var_40_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_13.position).x, (manager.ui.mainCamera.transform.position - var_40_13.position).y, (manager.ui.mainCamera.transform.position - var_40_13.position).z)
				var_40_13.localEulerAngles.z = 0
				var_40_13.localEulerAngles.x = 0
				var_40_13.localEulerAngles = var_40_13.localEulerAngles
			end

			if arg_37_1.time_ >= 2 + var_40_14 and arg_37_1.time_ < 2 + var_40_14 + arg_40_0 then
				var_40_13.localPosition = Vector3.New(0, -0.98, -6.1)
				var_40_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_13.position).x, (manager.ui.mainCamera.transform.position - var_40_13.position).y, (manager.ui.mainCamera.transform.position - var_40_13.position).z)
				var_40_13.localEulerAngles.z = 0
				var_40_13.localEulerAngles.x = 0
				var_40_13.localEulerAngles = var_40_13.localEulerAngles
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_15 = 2
			local var_40_16 = 1.05

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_17 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_17:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411021009).content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 46 <= 0 and var_40_16 or var_40_16 * (utf8.len(var_40_18) / 46)

				if (46 <= 0 and var_40_16 or var_40_16 * (utf8.len(var_40_18) / 46)) > 0 and var_40_16 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20
					var_40_15 = var_40_15 + 0.3

					if var_40_20 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = var_40_15 + 0.3
			local var_40_22 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_22 and arg_37_1.time_ < var_40_21 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play411021010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 411021010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play411021011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.7

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(411021010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 28 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 28)

				if (28 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 28)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play411021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411021011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411021012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.875

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(411021011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 35 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 35)

				if (35 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 35)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play411021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411021012
		arg_51_1.duration_ = 4.57

		local var_51_0 = {
			zh = 4.533,
			ja = 4.566
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
				arg_51_0:Play411021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.bgs_.ST74a == nil then
				local var_54_0 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74a")
				var_54_0.name = "ST74a"
				var_54_0.transform.parent = arg_51_1.stage_.transform
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_.ST74a = var_54_0
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				local var_54_1 = arg_51_1.bgs_.ST74a

				arg_51_1.bgs_.ST74a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_2 = var_54_1:GetComponent("SpriteRenderer")

				if var_54_2 and var_54_2.sprite then
					local var_54_3 = 2 * (var_54_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_1.transform.localScale = Vector3.New(var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "ST74a" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_54_4 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_5 = 2

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_5 then
				local var_54_6 = Color.New(0, 0, 0)

				var_54_6.a = Mathf.Lerp(0, 1, (arg_51_1.time_ - var_54_4) / var_54_5)
				arg_51_1.mask_.color = var_54_6
			end

			if arg_51_1.time_ >= var_54_4 + var_54_5 and arg_51_1.time_ < var_54_4 + var_54_5 + arg_54_0 then
				local var_54_7 = Color.New(0, 0, 0)

				var_54_7.a = 1
				arg_51_1.mask_.color = var_54_7
			end

			local var_54_8 = 2

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_9 = 2

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 then
				local var_54_10 = Color.New(0, 0, 0)

				var_54_10.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_8) / var_54_9)
				arg_51_1.mask_.color = var_54_10
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 then
				local var_54_11 = Color.New(0, 0, 0)

				arg_51_1.mask_.enabled = false
				var_54_11.a = 0
				arg_51_1.mask_.color = var_54_11
			end

			local var_54_12 = arg_51_1.actors_["1095ui_story"].transform

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				arg_51_1.var_.moveOldPos1095ui_story = var_54_12.localPosition
			end

			local var_54_13 = 0.001

			if 2 <= arg_51_1.time_ and arg_51_1.time_ < 2 + var_54_13 then
				var_54_12.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_51_1.time_ - 2) / var_54_13)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			if arg_51_1.time_ >= 2 + var_54_13 and arg_51_1.time_ < 2 + var_54_13 + arg_54_0 then
				var_54_12.localPosition = Vector3.New(0, -0.98, -6.1)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			local var_54_14 = arg_51_1.actors_["1095ui_story"]

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1095ui_story == nil then
				arg_51_1.var_.characterEffect1095ui_story = var_54_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_15 = 0.200000002980232

			if 2 <= arg_51_1.time_ and arg_51_1.time_ < 2 + var_54_15 and not isNil(var_54_14) then
				if arg_51_1.var_.characterEffect1095ui_story and not isNil(var_54_14) then
					arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 2 + var_54_15 and arg_51_1.time_ < 2 + var_54_15 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1095ui_story then
				arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				arg_51_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_54_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_19 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_19

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_19
						arg_51_1.bgmTxt2_.text = var_54_19
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_51_1.time_ and arg_51_1.time_ <= 0.6 + arg_54_0 then
				arg_51_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_54_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if "" ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_22 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_22

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_22
						arg_51_1.bgmTxt2_.text = var_54_22
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_23 = 2
			local var_54_24 = 0.225

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_25 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_25:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_51_1.dialogCg_.alpha = arg_57_0
				end))
				var_54_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_26 = arg_51_1:GetWordFromCfg(411021012)
				local var_54_27 = arg_51_1:FormatText(var_54_26.content)

				arg_51_1.text_.text = var_54_27

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_29 = 9 <= 0 and var_54_24 or var_54_24 * (utf8.len(var_54_27) / 9)

				if (9 <= 0 and var_54_24 or var_54_24 * (utf8.len(var_54_27) / 9)) > 0 and var_54_24 < var_54_29 then
					arg_51_1.talkMaxDuration = var_54_29
					var_54_23 = var_54_23 + 0.3

					if var_54_29 + var_54_23 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_29 + var_54_23
					end
				end

				arg_51_1.text_.text = var_54_27
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021012", "story_v_out_411021.awb") ~= 0 then
					local var_54_30 = manager.audio:GetVoiceLength("story_v_out_411021", "411021012", "story_v_out_411021.awb") / 1000

					if var_54_30 + var_54_23 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_30 + var_54_23
					end

					if var_54_26.prefab_name ~= "" and arg_51_1.actors_[var_54_26.prefab_name] ~= nil then
						local var_54_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_26.prefab_name].transform, "story_v_out_411021", "411021012", "story_v_out_411021.awb")

						arg_51_1:RecordAudio("411021012", var_54_31)
						arg_51_1:RecordAudio("411021012", var_54_31)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_411021", "411021012", "story_v_out_411021.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_411021", "411021012", "story_v_out_411021.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_32 = var_54_23 + 0.3
			local var_54_33 = math.max(var_54_24, arg_51_1.talkMaxDuration)

			if var_54_23 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_32 + var_54_33 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_32) / var_54_33

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_32 + var_54_33 and arg_51_1.time_ < var_54_32 + var_54_33 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play411021013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411021013
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411021014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1095ui_story"]) and arg_59_1.var_.characterEffect1095ui_story == nil then
				arg_59_1.var_.characterEffect1095ui_story = arg_59_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1095ui_story"]) then
				if arg_59_1.var_.characterEffect1095ui_story and not isNil(arg_59_1.actors_["1095ui_story"]) then
					arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1095ui_story"]) and arg_59_1.var_.characterEffect1095ui_story then
				arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.75

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(411021013).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 30 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 30)

				if (30 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 30)) > 0 and var_62_2 < var_62_5 then
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
	Play411021014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411021014
		arg_63_1.duration_ = 1.1

		local var_63_0 = {
			zh = 1.066,
			ja = 1.1
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
				arg_63_0:Play411021015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_131", "se_story_131__bookfall", "")
			end

			local var_66_1 = 0
			local var_66_2 = 0.1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(411021014)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 4 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 4)

				if (4 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 4)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021014", "story_v_out_411021.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_out_411021", "411021014", "story_v_out_411021.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_411021", "411021014", "story_v_out_411021.awb")

						arg_63_1:RecordAudio("411021014", var_66_8)
						arg_63_1:RecordAudio("411021014", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_411021", "411021014", "story_v_out_411021.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_411021", "411021014", "story_v_out_411021.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_9 and arg_63_1.time_ < var_66_1 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play411021015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411021015
		arg_67_1.duration_ = 2

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play411021016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1095ui_story = arg_67_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).z)
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles = arg_67_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_67_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1095ui_story"].transform.position).z)
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1095ui_story"].transform.localEulerAngles = arg_67_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1095ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1095ui_story == nil then
				arg_67_1.var_.characterEffect1095ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1095ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1095ui_story then
				arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_70_4 = 0
			local var_70_5 = 0.125

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

				local var_70_6 = arg_67_1:GetWordFromCfg(411021015)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 5 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 5)

				if (5 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 5)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021015", "story_v_out_411021.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021015", "story_v_out_411021.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_411021", "411021015", "story_v_out_411021.awb")

						arg_67_1:RecordAudio("411021015", var_70_11)
						arg_67_1:RecordAudio("411021015", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_411021", "411021015", "story_v_out_411021.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_411021", "411021015", "story_v_out_411021.awb")
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play411021016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411021016
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play411021017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1095ui_story"]) and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = arg_71_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1095ui_story"]) then
				if arg_71_1.var_.characterEffect1095ui_story and not isNil(arg_71_1.actors_["1095ui_story"]) then
					arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1095ui_story"]) and arg_71_1.var_.characterEffect1095ui_story then
				arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_74_1 = arg_71_1.actors_["1095ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1095ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0, 100, 0)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			local var_74_3 = 0
			local var_74_4 = 0.975

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

				local var_74_5 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(411021016).content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 40 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 40)

				if (40 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 40)) > 0 and var_74_4 < var_74_7 then
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
				actorName = "1095ui_story",
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
	Play411021017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411021017
		arg_75_1.duration_ = 4.97

		local var_75_0 = {
			zh = 3.566,
			ja = 4.966
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
				arg_75_0:Play411021018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["10071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10071ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "10071ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "10071ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10071ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["10071ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["10071ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["10071ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["10071ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10071ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0.7, -0.9, -6.26)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["10071ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10071ui_story == nil then
				arg_75_1.var_.characterEffect10071ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect10071ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10071ui_story then
				arg_75_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_8 = arg_75_1.actors_["1095ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1095ui_story = var_78_8.localPosition
			end

			local var_78_9 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_9 then
				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_75_1.time_ - 0) / var_78_9)
				var_78_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_8.position).x, (manager.ui.mainCamera.transform.position - var_78_8.position).y, (manager.ui.mainCamera.transform.position - var_78_8.position).z)
				var_78_8.localEulerAngles.z = 0
				var_78_8.localEulerAngles.x = 0
				var_78_8.localEulerAngles = var_78_8.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_9 and arg_75_1.time_ < 0 + var_78_9 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_78_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_8.position).x, (manager.ui.mainCamera.transform.position - var_78_8.position).y, (manager.ui.mainCamera.transform.position - var_78_8.position).z)
				var_78_8.localEulerAngles.z = 0
				var_78_8.localEulerAngles.x = 0
				var_78_8.localEulerAngles = var_78_8.localEulerAngles
			end

			local var_78_10 = arg_75_1.actors_["1095ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_11 and not isNil(var_78_10) then
				if arg_75_1.var_.characterEffect1095ui_story and not isNil(var_78_10) then
					arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_11)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_11 and arg_75_1.time_ < 0 + var_78_11 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect1095ui_story then
				arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_78_12 = 0
			local var_78_13 = 0.225

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
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

				local var_78_14 = arg_75_1:GetWordFromCfg(411021017)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 9 <= 0 and var_78_13 or var_78_13 * (utf8.len(var_78_15) / 9)

				if (9 <= 0 and var_78_13 or var_78_13 * (utf8.len(var_78_15) / 9)) > 0 and var_78_13 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_12
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021017", "story_v_out_411021.awb") ~= 0 then
					local var_78_18 = manager.audio:GetVoiceLength("story_v_out_411021", "411021017", "story_v_out_411021.awb") / 1000

					if var_78_18 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_12
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_out_411021", "411021017", "story_v_out_411021.awb")

						arg_75_1:RecordAudio("411021017", var_78_19)
						arg_75_1:RecordAudio("411021017", var_78_19)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_411021", "411021017", "story_v_out_411021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_411021", "411021017", "story_v_out_411021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_13, arg_75_1.talkMaxDuration)

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_12) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_12 + var_78_20 and arg_75_1.time_ < var_78_12 + var_78_20 + arg_78_0 then
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

		arg_75_1:InitPlayNodeList()
	end,
	Play411021018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411021018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411021019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10071ui_story"]) and arg_79_1.var_.characterEffect10071ui_story == nil then
				arg_79_1.var_.characterEffect10071ui_story = arg_79_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10071ui_story"]) then
				if arg_79_1.var_.characterEffect10071ui_story and not isNil(arg_79_1.actors_["10071ui_story"]) then
					arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10071ui_story"]) and arg_79_1.var_.characterEffect10071ui_story then
				arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.325

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(411021018).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 13 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 13)

				if (13 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 13)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play411021019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411021019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411021020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_86_0 = 0
			local var_86_1 = 0.75

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(411021019).content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 30 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_2) / 30)

				if (30 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_2) / 30)) > 0 and var_86_1 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_5 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_5 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_5

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_5 and arg_83_1.time_ < var_86_0 + var_86_5 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play411021020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411021020
		arg_87_1.duration_ = 6

		local var_87_0 = {
			zh = 5.933,
			ja = 6
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
				arg_87_0:Play411021021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1095ui_story = arg_87_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1095ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story == nil then
				arg_87_1.var_.characterEffect1095ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1095ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action463")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.7

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(411021020)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 28 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 28)

				if (28 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 28)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021020", "story_v_out_411021.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021020", "story_v_out_411021.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_411021", "411021020", "story_v_out_411021.awb")

						arg_87_1:RecordAudio("411021020", var_90_11)
						arg_87_1:RecordAudio("411021020", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_411021", "411021020", "story_v_out_411021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_411021", "411021020", "story_v_out_411021.awb")
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

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play411021021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411021021
		arg_91_1.duration_ = 8.9

		local var_91_0 = {
			zh = 8.9,
			ja = 6.366
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
				arg_91_0:Play411021022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10071ui_story = arg_91_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).z)
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles = arg_91_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_91_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10071ui_story"].transform.position).z)
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10071ui_story"].transform.localEulerAngles = arg_91_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10071ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10071ui_story == nil then
				arg_91_1.var_.characterEffect10071ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10071ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10071ui_story then
				arg_91_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_4 = arg_91_1.actors_["1095ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1095ui_story == nil then
				arg_91_1.var_.characterEffect1095ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_5 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 and not isNil(var_94_4) then
				if arg_91_1.var_.characterEffect1095ui_story and not isNil(var_94_4) then
					arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_5)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1095ui_story then
				arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_94_6 = 0
			local var_94_7 = 0.825

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(411021021)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 33 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 33)

				if (33 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 33)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021021", "story_v_out_411021.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021021", "story_v_out_411021.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_411021", "411021021", "story_v_out_411021.awb")

						arg_91_1:RecordAudio("411021021", var_94_13)
						arg_91_1:RecordAudio("411021021", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_411021", "411021021", "story_v_out_411021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_411021", "411021021", "story_v_out_411021.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play411021022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411021022
		arg_95_1.duration_ = 10.8

		local var_95_0 = {
			zh = 10.6,
			ja = 10.8
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
				arg_95_0:Play411021023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_2")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_98_0 = 0
			local var_98_1 = 1.025

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
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

				local var_98_2 = arg_95_1:GetWordFromCfg(411021022)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 41 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 41)

				if (41 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 41)) > 0 and var_98_1 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021022", "story_v_out_411021.awb") ~= 0 then
					local var_98_6 = manager.audio:GetVoiceLength("story_v_out_411021", "411021022", "story_v_out_411021.awb") / 1000

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end

					if var_98_2.prefab_name ~= "" and arg_95_1.actors_[var_98_2.prefab_name] ~= nil then
						local var_98_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_2.prefab_name].transform, "story_v_out_411021", "411021022", "story_v_out_411021.awb")

						arg_95_1:RecordAudio("411021022", var_98_7)
						arg_95_1:RecordAudio("411021022", var_98_7)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_411021", "411021022", "story_v_out_411021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_411021", "411021022", "story_v_out_411021.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play411021023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411021023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411021024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10071ui_story"]) and arg_99_1.var_.characterEffect10071ui_story == nil then
				arg_99_1.var_.characterEffect10071ui_story = arg_99_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10071ui_story"]) then
				if arg_99_1.var_.characterEffect10071ui_story and not isNil(arg_99_1.actors_["10071ui_story"]) then
					arg_99_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10071ui_story"]) and arg_99_1.var_.characterEffect10071ui_story then
				arg_99_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.675

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

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(411021023).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 27 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 27)

				if (27 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 27)) > 0 and var_102_2 < var_102_5 then
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
	Play411021024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411021024
		arg_103_1.duration_ = 4.5

		local var_103_0 = {
			zh = 3.4,
			ja = 4.5
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
				arg_103_0:Play411021025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1095ui_story = arg_103_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).z)
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles = arg_103_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_103_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1095ui_story"].transform.position).z)
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1095ui_story"].transform.localEulerAngles = arg_103_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1095ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1095ui_story == nil then
				arg_103_1.var_.characterEffect1095ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1095ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1095ui_story then
				arg_103_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.375

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(411021024)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 15 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 15)

				if (15 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 15)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021024", "story_v_out_411021.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021024", "story_v_out_411021.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_411021", "411021024", "story_v_out_411021.awb")

						arg_103_1:RecordAudio("411021024", var_106_11)
						arg_103_1:RecordAudio("411021024", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_411021", "411021024", "story_v_out_411021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_411021", "411021024", "story_v_out_411021.awb")
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
				actorName = "1095ui_story",
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
	Play411021025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411021025
		arg_107_1.duration_ = 6.13

		local var_107_0 = {
			zh = 3.766,
			ja = 6.133
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
				arg_107_0:Play411021026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10071ui_story = arg_107_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).z)
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles = arg_107_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_107_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10071ui_story"].transform.position).z)
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10071ui_story"].transform.localEulerAngles = arg_107_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["10071ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10071ui_story == nil then
				arg_107_1.var_.characterEffect10071ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect10071ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10071ui_story then
				arg_107_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_110_4 = arg_107_1.actors_["1095ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1095ui_story == nil then
				arg_107_1.var_.characterEffect1095ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_5 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 and not isNil(var_110_4) then
				if arg_107_1.var_.characterEffect1095ui_story and not isNil(var_110_4) then
					arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_5)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1095ui_story then
				arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_110_6 = 0
			local var_110_7 = 0.225

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
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

				local var_110_8 = arg_107_1:GetWordFromCfg(411021025)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 9 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 9)

				if (9 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 9)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021025", "story_v_out_411021.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021025", "story_v_out_411021.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_411021", "411021025", "story_v_out_411021.awb")

						arg_107_1:RecordAudio("411021025", var_110_13)
						arg_107_1:RecordAudio("411021025", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_411021", "411021025", "story_v_out_411021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_411021", "411021025", "story_v_out_411021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play411021026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411021026
		arg_111_1.duration_ = 7.93

		local var_111_0 = {
			zh = 3.666,
			ja = 7.933
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
				arg_111_0:Play411021027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_114_0 = arg_111_1.actors_["10071ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10071ui_story == nil then
				arg_111_1.var_.characterEffect10071ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_1 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 and not isNil(var_114_0) then
				if arg_111_1.var_.characterEffect10071ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10071ui_story then
				arg_111_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_2")
			end

			local var_114_3 = 0
			local var_114_4 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(411021026)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 12 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 12)

				if (12 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 12)) > 0 and var_114_4 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021026", "story_v_out_411021.awb") ~= 0 then
					local var_114_9 = manager.audio:GetVoiceLength("story_v_out_411021", "411021026", "story_v_out_411021.awb") / 1000

					if var_114_9 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_3
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_411021", "411021026", "story_v_out_411021.awb")

						arg_111_1:RecordAudio("411021026", var_114_10)
						arg_111_1:RecordAudio("411021026", var_114_10)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_411021", "411021026", "story_v_out_411021.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_411021", "411021026", "story_v_out_411021.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_11 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_11

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_11 and arg_111_1.time_ < var_114_3 + var_114_11 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411021027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411021027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play411021028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10071ui_story"]) and arg_115_1.var_.characterEffect10071ui_story == nil then
				arg_115_1.var_.characterEffect10071ui_story = arg_115_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10071ui_story"]) then
				if arg_115_1.var_.characterEffect10071ui_story and not isNil(arg_115_1.actors_["10071ui_story"]) then
					arg_115_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10071ui_story"]) and arg_115_1.var_.characterEffect10071ui_story then
				arg_115_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.45

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(411021027).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 18 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 18)

				if (18 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 18)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play411021028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411021028
		arg_119_1.duration_ = 3.6

		local var_119_0 = {
			zh = 3.6,
			ja = 3.5
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
				arg_119_0:Play411021029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10071ui_story = arg_119_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).z)
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles = arg_119_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_119_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10071ui_story"].transform.position).z)
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10071ui_story"].transform.localEulerAngles = arg_119_1.actors_["10071ui_story"].transform.localEulerAngles
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
				arg_119_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
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

				local var_122_6 = arg_119_1:GetWordFromCfg(411021028)
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

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021028", "story_v_out_411021.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021028", "story_v_out_411021.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_411021", "411021028", "story_v_out_411021.awb")

						arg_119_1:RecordAudio("411021028", var_122_11)
						arg_119_1:RecordAudio("411021028", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411021", "411021028", "story_v_out_411021.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411021", "411021028", "story_v_out_411021.awb")
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

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play411021029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411021029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play411021030(arg_123_1)
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
			local var_126_2 = 0.975

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(411021029).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 39 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 39)

				if (39 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 39)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411021030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411021030
		arg_127_1.duration_ = 7.47

		local var_127_0 = {
			zh = 7.466,
			ja = 4.366
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
				arg_127_0:Play411021031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10071ui_story"]) and arg_127_1.var_.characterEffect10071ui_story == nil then
				arg_127_1.var_.characterEffect10071ui_story = arg_127_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10071ui_story"]) then
				if arg_127_1.var_.characterEffect10071ui_story and not isNil(arg_127_1.actors_["10071ui_story"]) then
					arg_127_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10071ui_story"]) and arg_127_1.var_.characterEffect10071ui_story then
				arg_127_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_130_2 = 0
			local var_130_3 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:GetWordFromCfg(411021030)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 14 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 14)

				if (14 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 14)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021030", "story_v_out_411021.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_411021", "411021030", "story_v_out_411021.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_411021", "411021030", "story_v_out_411021.awb")

						arg_127_1:RecordAudio("411021030", var_130_9)
						arg_127_1:RecordAudio("411021030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_411021", "411021030", "story_v_out_411021.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_411021", "411021030", "story_v_out_411021.awb")
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
	Play411021031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411021031
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411021032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1095ui_story = arg_131_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).z)
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles = arg_131_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_131_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1095ui_story"].transform.position).z)
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1095ui_story"].transform.localEulerAngles = arg_131_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1095ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1095ui_story == nil then
				arg_131_1.var_.characterEffect1095ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1095ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1095ui_story then
				arg_131_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_134_4 = arg_131_1.actors_["10071ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10071ui_story == nil then
				arg_131_1.var_.characterEffect10071ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect10071ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10071ui_story then
				arg_131_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_134_6 = 0
			local var_134_7 = 0.1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(411021031)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 4 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 4)

				if (4 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 4)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021031", "story_v_out_411021.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021031", "story_v_out_411021.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_411021", "411021031", "story_v_out_411021.awb")

						arg_131_1:RecordAudio("411021031", var_134_13)
						arg_131_1:RecordAudio("411021031", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411021", "411021031", "story_v_out_411021.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411021", "411021031", "story_v_out_411021.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play411021032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411021032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411021033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) and arg_135_1.var_.characterEffect1095ui_story == nil then
				arg_135_1.var_.characterEffect1095ui_story = arg_135_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) then
				if arg_135_1.var_.characterEffect1095ui_story and not isNil(arg_135_1.actors_["1095ui_story"]) then
					arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) and arg_135_1.var_.characterEffect1095ui_story then
				arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_138_1 = arg_135_1.actors_["10071ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10071ui_story == nil then
				arg_135_1.var_.characterEffect10071ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10071ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_2)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10071ui_story then
				arg_135_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_138_3 = 0
			local var_138_4 = 1.125

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(411021032).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 45 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 45)

				if (45 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 45)) > 0 and var_138_4 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_8 and arg_135_1.time_ < var_138_3 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play411021033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411021033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411021034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.825

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(411021033).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 33 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 33)

				if (33 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 33)) > 0 and var_142_0 < var_142_3 then
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
	Play411021034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411021034
		arg_143_1.duration_ = 5.6

		local var_143_0 = {
			zh = 5.6,
			ja = 4.533
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
				arg_143_0:Play411021035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10071ui_story = arg_143_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).z)
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles = arg_143_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_143_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10071ui_story"].transform.position).z)
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10071ui_story"].transform.localEulerAngles = arg_143_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10071ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10071ui_story == nil then
				arg_143_1.var_.characterEffect10071ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10071ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10071ui_story then
				arg_143_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(411021034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)

				if (13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021034", "story_v_out_411021.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021034", "story_v_out_411021.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_411021", "411021034", "story_v_out_411021.awb")

						arg_143_1:RecordAudio("411021034", var_146_11)
						arg_143_1:RecordAudio("411021034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411021", "411021034", "story_v_out_411021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411021", "411021034", "story_v_out_411021.awb")
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
				actorName = "10071ui_story",
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
	Play411021035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411021035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411021036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10071ui_story"]) and arg_147_1.var_.characterEffect10071ui_story == nil then
				arg_147_1.var_.characterEffect10071ui_story = arg_147_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10071ui_story"]) then
				if arg_147_1.var_.characterEffect10071ui_story and not isNil(arg_147_1.actors_["10071ui_story"]) then
					arg_147_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10071ui_story"]) and arg_147_1.var_.characterEffect10071ui_story then
				arg_147_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.65

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(411021035).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 26 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 26)

				if (26 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 26)) > 0 and var_150_2 < var_150_5 then
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
	Play411021036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411021036
		arg_151_1.duration_ = 4.3

		local var_151_0 = {
			zh = 2.4,
			ja = 4.3
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
				arg_151_0:Play411021037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1095ui_story = arg_151_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).z)
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles = arg_151_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_151_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).z)
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles = arg_151_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1095ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1095ui_story == nil then
				arg_151_1.var_.characterEffect1095ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1095ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1095ui_story then
				arg_151_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(411021036)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)

				if (9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021036", "story_v_out_411021.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021036", "story_v_out_411021.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_411021", "411021036", "story_v_out_411021.awb")

						arg_151_1:RecordAudio("411021036", var_154_11)
						arg_151_1:RecordAudio("411021036", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411021", "411021036", "story_v_out_411021.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411021", "411021036", "story_v_out_411021.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play411021037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411021037
		arg_155_1.duration_ = 3.7

		local var_155_0 = {
			zh = 3.7,
			ja = 2.166
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
				arg_155_0:Play411021038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_158_0 = 0
			local var_158_1 = 0.4

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(411021037)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 16 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 16)

				if (16 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 16)) > 0 and var_158_1 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021037", "story_v_out_411021.awb") ~= 0 then
					local var_158_6 = manager.audio:GetVoiceLength("story_v_out_411021", "411021037", "story_v_out_411021.awb") / 1000

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end

					if var_158_2.prefab_name ~= "" and arg_155_1.actors_[var_158_2.prefab_name] ~= nil then
						local var_158_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_2.prefab_name].transform, "story_v_out_411021", "411021037", "story_v_out_411021.awb")

						arg_155_1:RecordAudio("411021037", var_158_7)
						arg_155_1:RecordAudio("411021037", var_158_7)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411021", "411021037", "story_v_out_411021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411021", "411021037", "story_v_out_411021.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play411021038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411021038
		arg_159_1.duration_ = 4.4

		local var_159_0 = {
			zh = 4.4,
			ja = 3.733
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411021039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10071ui_story = arg_159_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).z)
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles = arg_159_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_159_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10071ui_story"].transform.position).z)
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10071ui_story"].transform.localEulerAngles = arg_159_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["10071ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10071ui_story == nil then
				arg_159_1.var_.characterEffect10071ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect10071ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10071ui_story then
				arg_159_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_2")
			end

			local var_162_4 = arg_159_1.actors_["1095ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1095ui_story == nil then
				arg_159_1.var_.characterEffect1095ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_5 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 and not isNil(var_162_4) then
				if arg_159_1.var_.characterEffect1095ui_story and not isNil(var_162_4) then
					arg_159_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_5)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1095ui_story then
				arg_159_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_162_6 = 0
			local var_162_7 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(411021038)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 10 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 10)

				if (10 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 10)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021038", "story_v_out_411021.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021038", "story_v_out_411021.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_411021", "411021038", "story_v_out_411021.awb")

						arg_159_1:RecordAudio("411021038", var_162_13)
						arg_159_1:RecordAudio("411021038", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411021", "411021038", "story_v_out_411021.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411021", "411021038", "story_v_out_411021.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play411021039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411021039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411021040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10071ui_story"]) and arg_163_1.var_.characterEffect10071ui_story == nil then
				arg_163_1.var_.characterEffect10071ui_story = arg_163_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10071ui_story"]) then
				if arg_163_1.var_.characterEffect10071ui_story and not isNil(arg_163_1.actors_["10071ui_story"]) then
					arg_163_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10071ui_story"]) and arg_163_1.var_.characterEffect10071ui_story then
				arg_163_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.775

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(411021039).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 31 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 31)

				if (31 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 31)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411021040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411021040
		arg_167_1.duration_ = 7.6

		local var_167_0 = {
			zh = 3.866,
			ja = 7.6
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
				arg_167_0:Play411021041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) and arg_167_1.var_.characterEffect1095ui_story == nil then
				arg_167_1.var_.characterEffect1095ui_story = arg_167_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) then
				if arg_167_1.var_.characterEffect1095ui_story and not isNil(arg_167_1.actors_["1095ui_story"]) then
					arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) and arg_167_1.var_.characterEffect1095ui_story then
				arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_170_2 = 0
			local var_170_3 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(411021040)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 17 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 17)

				if (17 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 17)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021040", "story_v_out_411021.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_411021", "411021040", "story_v_out_411021.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_411021", "411021040", "story_v_out_411021.awb")

						arg_167_1:RecordAudio("411021040", var_170_9)
						arg_167_1:RecordAudio("411021040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411021", "411021040", "story_v_out_411021.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411021", "411021040", "story_v_out_411021.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411021041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411021041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411021042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) and arg_171_1.var_.characterEffect1095ui_story == nil then
				arg_171_1.var_.characterEffect1095ui_story = arg_171_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) then
				if arg_171_1.var_.characterEffect1095ui_story and not isNil(arg_171_1.actors_["1095ui_story"]) then
					arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) and arg_171_1.var_.characterEffect1095ui_story then
				arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.675

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411021041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 27 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 27)

				if (27 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 27)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play411021042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411021042
		arg_175_1.duration_ = 5.5

		local var_175_0 = {
			zh = 4.266,
			ja = 5.5
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411021043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1095ui_story = arg_175_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).z)
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles = arg_175_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_175_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1095ui_story"].transform.position).z)
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1095ui_story"].transform.localEulerAngles = arg_175_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1095ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1095ui_story == nil then
				arg_175_1.var_.characterEffect1095ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1095ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1095ui_story then
				arg_175_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = 0
			local var_178_5 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(411021042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 18 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 18)

				if (18 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 18)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021042", "story_v_out_411021.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021042", "story_v_out_411021.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_411021", "411021042", "story_v_out_411021.awb")

						arg_175_1:RecordAudio("411021042", var_178_11)
						arg_175_1:RecordAudio("411021042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411021", "411021042", "story_v_out_411021.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411021", "411021042", "story_v_out_411021.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play411021043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411021043
		arg_179_1.duration_ = 4.77

		local var_179_0 = {
			zh = 4.766,
			ja = 2.866
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
				arg_179_0:Play411021044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10071ui_story = arg_179_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).z)
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles = arg_179_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_179_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10071ui_story"].transform.position).z)
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10071ui_story"].transform.localEulerAngles = arg_179_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["10071ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10071ui_story == nil then
				arg_179_1.var_.characterEffect10071ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10071ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10071ui_story then
				arg_179_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["1095ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1095ui_story == nil then
				arg_179_1.var_.characterEffect1095ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_5 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 and not isNil(var_182_4) then
				if arg_179_1.var_.characterEffect1095ui_story and not isNil(var_182_4) then
					arg_179_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_5)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1095ui_story then
				arg_179_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_182_6 = 0
			local var_182_7 = 0.5

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(411021043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 20 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 20)

				if (20 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 20)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021043", "story_v_out_411021.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021043", "story_v_out_411021.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_411021", "411021043", "story_v_out_411021.awb")

						arg_179_1:RecordAudio("411021043", var_182_13)
						arg_179_1:RecordAudio("411021043", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411021", "411021043", "story_v_out_411021.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411021", "411021043", "story_v_out_411021.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play411021044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411021044
		arg_183_1.duration_ = 9.63

		local var_183_0 = {
			zh = 7.233,
			ja = 9.633
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
				arg_183_0:Play411021045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.85

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(411021044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 34 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 34)

				if (34 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 34)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021044", "story_v_out_411021.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021044", "story_v_out_411021.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_411021", "411021044", "story_v_out_411021.awb")

						arg_183_1:RecordAudio("411021044", var_186_6)
						arg_183_1:RecordAudio("411021044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411021", "411021044", "story_v_out_411021.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411021", "411021044", "story_v_out_411021.awb")
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
	Play411021045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411021045
		arg_187_1.duration_ = 10.9

		local var_187_0 = {
			zh = 8.066,
			ja = 10.9
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
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411021046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10071ui_story"]) and arg_187_1.var_.characterEffect10071ui_story == nil then
				arg_187_1.var_.characterEffect10071ui_story = arg_187_1.actors_["10071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10071ui_story"]) then
				if arg_187_1.var_.characterEffect10071ui_story and not isNil(arg_187_1.actors_["10071ui_story"]) then
					arg_187_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10071ui_story"]) and arg_187_1.var_.characterEffect10071ui_story then
				arg_187_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_190_1 = arg_187_1.actors_["1095ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1095ui_story == nil then
				arg_187_1.var_.characterEffect1095ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1095ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1095ui_story then
				arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 1.05

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

				local var_190_6 = arg_187_1:GetWordFromCfg(411021045)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 42 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 42)

				if (42 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 42)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021045", "story_v_out_411021.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021045", "story_v_out_411021.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_411021", "411021045", "story_v_out_411021.awb")

						arg_187_1:RecordAudio("411021045", var_190_11)
						arg_187_1:RecordAudio("411021045", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411021", "411021045", "story_v_out_411021.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411021", "411021045", "story_v_out_411021.awb")
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

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411021046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411021046
		arg_191_1.duration_ = 8.63

		local var_191_0 = {
			zh = 7.8,
			ja = 8.633
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
				arg_191_0:Play411021047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(411021046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 40 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 40)

				if (40 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 40)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021046", "story_v_out_411021.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021046", "story_v_out_411021.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_411021", "411021046", "story_v_out_411021.awb")

						arg_191_1:RecordAudio("411021046", var_194_6)
						arg_191_1:RecordAudio("411021046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411021", "411021046", "story_v_out_411021.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411021", "411021046", "story_v_out_411021.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play411021047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411021047
		arg_195_1.duration_ = 6

		local var_195_0 = {
			zh = 5.433,
			ja = 6
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
				arg_195_0:Play411021048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10071ui_story = arg_195_1.actors_["10071ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10071ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10071ui_story, Vector3.New(0.7, -0.9, -6.26), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).z)
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles = arg_195_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10071ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -6.26)
				arg_195_1.actors_["10071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10071ui_story"].transform.position).z)
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10071ui_story"].transform.localEulerAngles = arg_195_1.actors_["10071ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10071ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10071ui_story == nil then
				arg_195_1.var_.characterEffect10071ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10071ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10071ui_story then
				arg_195_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = arg_195_1.actors_["1095ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1095ui_story == nil then
				arg_195_1.var_.characterEffect1095ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect1095ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_5)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1095ui_story then
				arg_195_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_198_6 = 0
			local var_198_7 = 0.575

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(411021047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 23 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 23)

				if (23 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 23)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021047", "story_v_out_411021.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021047", "story_v_out_411021.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_411021", "411021047", "story_v_out_411021.awb")

						arg_195_1:RecordAudio("411021047", var_198_13)
						arg_195_1:RecordAudio("411021047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411021", "411021047", "story_v_out_411021.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411021", "411021047", "story_v_out_411021.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play411021048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411021048
		arg_199_1.duration_ = 7

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411021049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if arg_199_1.bgs_.ML0502 == nil then
				local var_202_0 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0502")
				var_202_0.name = "ML0502"
				var_202_0.transform.parent = arg_199_1.stage_.transform
				var_202_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_.ML0502 = var_202_0
			end

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				local var_202_1 = arg_199_1.bgs_.ML0502

				arg_199_1.bgs_.ML0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_2 = var_202_1:GetComponent("SpriteRenderer")

				if var_202_2 and var_202_2.sprite then
					local var_202_3 = 2 * (var_202_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_1.transform.localScale = Vector3.New(var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "ML0502" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_4 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_5 = 2

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_5 then
				local var_202_6 = Color.New(0, 0, 0)

				var_202_6.a = Mathf.Lerp(0, 1, (arg_199_1.time_ - var_202_4) / var_202_5)
				arg_199_1.mask_.color = var_202_6
			end

			if arg_199_1.time_ >= var_202_4 + var_202_5 and arg_199_1.time_ < var_202_4 + var_202_5 + arg_202_0 then
				local var_202_7 = Color.New(0, 0, 0)

				var_202_7.a = 1
				arg_199_1.mask_.color = var_202_7
			end

			local var_202_8 = 2

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_9 = 2

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 then
				local var_202_10 = Color.New(0, 0, 0)

				var_202_10.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_8) / var_202_9)
				arg_199_1.mask_.color = var_202_10
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 then
				local var_202_11 = Color.New(0, 0, 0)

				arg_199_1.mask_.enabled = false
				var_202_11.a = 0
				arg_199_1.mask_.color = var_202_11
			end

			local var_202_12 = arg_199_1.actors_["10071ui_story"]

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 and not isNil(var_202_12) and arg_199_1.var_.characterEffect10071ui_story == nil then
				arg_199_1.var_.characterEffect10071ui_story = var_202_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_13 = 0.200000002980232

			if 2 <= arg_199_1.time_ and arg_199_1.time_ < 2 + var_202_13 and not isNil(var_202_12) then
				if arg_199_1.var_.characterEffect10071ui_story and not isNil(var_202_12) then
					arg_199_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 2) / var_202_13)
				end
			end

			if arg_199_1.time_ >= 2 + var_202_13 and arg_199_1.time_ < 2 + var_202_13 + arg_202_0 and not isNil(var_202_12) and arg_199_1.var_.characterEffect10071ui_story then
				arg_199_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10071ui_story.fillRatio = 0.5
			end

			local var_202_14 = arg_199_1.actors_["10071ui_story"].transform

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				arg_199_1.var_.moveOldPos10071ui_story = var_202_14.localPosition
			end

			local var_202_15 = 0.001

			if 2 <= arg_199_1.time_ and arg_199_1.time_ < 2 + var_202_15 then
				var_202_14.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10071ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 2) / var_202_15)
				var_202_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_14.position).x, (manager.ui.mainCamera.transform.position - var_202_14.position).y, (manager.ui.mainCamera.transform.position - var_202_14.position).z)
				var_202_14.localEulerAngles.z = 0
				var_202_14.localEulerAngles.x = 0
				var_202_14.localEulerAngles = var_202_14.localEulerAngles
			end

			if arg_199_1.time_ >= 2 + var_202_15 and arg_199_1.time_ < 2 + var_202_15 + arg_202_0 then
				var_202_14.localPosition = Vector3.New(0, 100, 0)
				var_202_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_14.position).x, (manager.ui.mainCamera.transform.position - var_202_14.position).y, (manager.ui.mainCamera.transform.position - var_202_14.position).z)
				var_202_14.localEulerAngles.z = 0
				var_202_14.localEulerAngles.x = 0
				var_202_14.localEulerAngles = var_202_14.localEulerAngles
			end

			local var_202_16 = arg_199_1.actors_["1095ui_story"].transform

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				arg_199_1.var_.moveOldPos1095ui_story = var_202_16.localPosition
			end

			local var_202_17 = 0.001

			if 2 <= arg_199_1.time_ and arg_199_1.time_ < 2 + var_202_17 then
				var_202_16.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 2) / var_202_17)
				var_202_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_16.position).x, (manager.ui.mainCamera.transform.position - var_202_16.position).y, (manager.ui.mainCamera.transform.position - var_202_16.position).z)
				var_202_16.localEulerAngles.z = 0
				var_202_16.localEulerAngles.x = 0
				var_202_16.localEulerAngles = var_202_16.localEulerAngles
			end

			if arg_199_1.time_ >= 2 + var_202_17 and arg_199_1.time_ < 2 + var_202_17 + arg_202_0 then
				var_202_16.localPosition = Vector3.New(0, 100, 0)
				var_202_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_16.position).x, (manager.ui.mainCamera.transform.position - var_202_16.position).y, (manager.ui.mainCamera.transform.position - var_202_16.position).z)
				var_202_16.localEulerAngles.z = 0
				var_202_16.localEulerAngles.x = 0
				var_202_16.localEulerAngles = var_202_16.localEulerAngles
			end

			local var_202_18 = arg_199_1.bgs_.ML0502.transform

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				arg_199_1.var_.moveOldPosML0502 = var_202_18.localPosition
			end

			local var_202_19 = 0.001

			if 2 <= arg_199_1.time_ and arg_199_1.time_ < 2 + var_202_19 then
				var_202_18.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPosML0502, Vector3.New(0, 1, 9.5), (arg_199_1.time_ - 2) / var_202_19)
			end

			if arg_199_1.time_ >= 2 + var_202_19 and arg_199_1.time_ < 2 + var_202_19 + arg_202_0 then
				var_202_18.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_202_20 = arg_199_1.bgs_.ML0502.transform

			if 2.01666666666667 < arg_199_1.time_ and arg_199_1.time_ <= 2.01666666666667 + arg_202_0 then
				arg_199_1.var_.moveOldPosML0502 = var_202_20.localPosition
			end

			local var_202_21 = 4

			if 2.01666666666667 <= arg_199_1.time_ and arg_199_1.time_ < 2.01666666666667 + var_202_21 then
				var_202_20.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPosML0502, Vector3.New(0, 1, 10), (arg_199_1.time_ - 2.01666666666667) / var_202_21)
			end

			if arg_199_1.time_ >= 2.01666666666667 + var_202_21 and arg_199_1.time_ < 2.01666666666667 + var_202_21 + arg_202_0 then
				var_202_20.localPosition = Vector3.New(0, 1, 10)
			end

			local var_202_22 = 4

			if 4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_22 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_22 + 2.01666666666667 and arg_199_1.time_ < var_202_22 + 2.01666666666667 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_23 = 2
			local var_202_24 = 1.425

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_23 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_25 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_25:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_26 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(411021048).content)

				arg_199_1.text_.text = var_202_26

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_28 = 57 <= 0 and var_202_24 or var_202_24 * (utf8.len(var_202_26) / 57)

				if (57 <= 0 and var_202_24 or var_202_24 * (utf8.len(var_202_26) / 57)) > 0 and var_202_24 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28
					var_202_23 = var_202_23 + 0.3

					if var_202_28 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_23
					end
				end

				arg_199_1.text_.text = var_202_26
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_29 = var_202_23 + 0.3
			local var_202_30 = math.max(var_202_24, arg_199_1.talkMaxDuration)

			if var_202_23 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_29 + var_202_30 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_29) / var_202_30

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_29 + var_202_30 and arg_199_1.time_ < var_202_29 + var_202_30 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play411021049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411021049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play411021050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.95

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(411021049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 38 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 38)

				if (38 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 38)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play411021050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 411021050
		arg_209_1.duration_ = 5.93

		local var_209_0 = {
			zh = 5.4,
			ja = 5.933
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
				arg_209_0:Play411021051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.55

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(411021050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 22 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 22)

				if (22 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 22)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021050", "story_v_out_411021.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021050", "story_v_out_411021.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_411021", "411021050", "story_v_out_411021.awb")

						arg_209_1:RecordAudio("411021050", var_212_6)
						arg_209_1:RecordAudio("411021050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_411021", "411021050", "story_v_out_411021.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_411021", "411021050", "story_v_out_411021.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play411021051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 411021051
		arg_213_1.duration_ = 12.1

		local var_213_0 = {
			zh = 7.9,
			ja = 12.1
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
				arg_213_0:Play411021052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.825

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(411021051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 33 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 33)

				if (33 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 33)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021051", "story_v_out_411021.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021051", "story_v_out_411021.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_411021", "411021051", "story_v_out_411021.awb")

						arg_213_1:RecordAudio("411021051", var_216_6)
						arg_213_1:RecordAudio("411021051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_411021", "411021051", "story_v_out_411021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_411021", "411021051", "story_v_out_411021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play411021052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 411021052
		arg_217_1.duration_ = 9.47

		local var_217_0 = {
			zh = 9.466,
			ja = 8.3
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
				arg_217_0:Play411021053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.925

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(411021052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 37 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 37)

				if (37 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 37)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021052", "story_v_out_411021.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021052", "story_v_out_411021.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_411021", "411021052", "story_v_out_411021.awb")

						arg_217_1:RecordAudio("411021052", var_220_6)
						arg_217_1:RecordAudio("411021052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_411021", "411021052", "story_v_out_411021.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_411021", "411021052", "story_v_out_411021.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play411021053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 411021053
		arg_221_1.duration_ = 7.73

		local var_221_0 = {
			zh = 7.4,
			ja = 7.733
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play411021054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.725

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(411021053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 29 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 29)

				if (29 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 29)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021053", "story_v_out_411021.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021053", "story_v_out_411021.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_411021", "411021053", "story_v_out_411021.awb")

						arg_221_1:RecordAudio("411021053", var_224_6)
						arg_221_1:RecordAudio("411021053", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_411021", "411021053", "story_v_out_411021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_411021", "411021053", "story_v_out_411021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play411021054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 411021054
		arg_225_1.duration_ = 16.1

		local var_225_0 = {
			zh = 16.1,
			ja = 11.9
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
				arg_225_0:Play411021055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(411021054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 53 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 53)

				if (53 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 53)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021054", "story_v_out_411021.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021054", "story_v_out_411021.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_411021", "411021054", "story_v_out_411021.awb")

						arg_225_1:RecordAudio("411021054", var_228_6)
						arg_225_1:RecordAudio("411021054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_411021", "411021054", "story_v_out_411021.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_411021", "411021054", "story_v_out_411021.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play411021055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 411021055
		arg_229_1.duration_ = 14.57

		local var_229_0 = {
			zh = 14.566,
			ja = 11.2
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
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play411021056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.bgs_.ML0501 == nil then
				local var_232_0 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0501")
				var_232_0.name = "ML0501"
				var_232_0.transform.parent = arg_229_1.stage_.transform
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_.ML0501 = var_232_0
			end

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				local var_232_1 = arg_229_1.bgs_.ML0501

				arg_229_1.bgs_.ML0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_2 = var_232_1:GetComponent("SpriteRenderer")

				if var_232_2 and var_232_2.sprite then
					local var_232_3 = 2 * (var_232_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_1.transform.localScale = Vector3.New(var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ML0501" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			local var_232_12 = arg_229_1.bgs_.ML0501.transform

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				arg_229_1.var_.moveOldPosML0501 = var_232_12.localPosition
			end

			local var_232_13 = 0.001

			if 2 <= arg_229_1.time_ and arg_229_1.time_ < 2 + var_232_13 then
				var_232_12.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosML0501, Vector3.New(0.5, 0, 5), (arg_229_1.time_ - 2) / var_232_13)
			end

			if arg_229_1.time_ >= 2 + var_232_13 and arg_229_1.time_ < 2 + var_232_13 + arg_232_0 then
				var_232_12.localPosition = Vector3.New(0.5, 0, 5)
			end

			local var_232_14 = arg_229_1.bgs_.ML0501.transform

			if 2.01666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 2.01666666666667 + arg_232_0 then
				arg_229_1.var_.moveOldPosML0501 = var_232_14.localPosition
			end

			local var_232_15 = 6.2

			if 2.01666666666667 <= arg_229_1.time_ and arg_229_1.time_ < 2.01666666666667 + var_232_15 then
				var_232_14.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosML0501, Vector3.New(-1, 0, 5), (arg_229_1.time_ - 2.01666666666667) / var_232_15)
			end

			if arg_229_1.time_ >= 2.01666666666667 + var_232_15 and arg_229_1.time_ < 2.01666666666667 + var_232_15 + arg_232_0 then
				var_232_14.localPosition = Vector3.New(-1, 0, 5)
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_16 = 4
			local var_232_17 = 0.975

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_18 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_18:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_19 = arg_229_1:GetWordFromCfg(411021055)
				local var_232_20 = arg_229_1:FormatText(var_232_19.content)

				arg_229_1.text_.text = var_232_20

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_22 = 39 <= 0 and var_232_17 or var_232_17 * (utf8.len(var_232_20) / 39)

				if (39 <= 0 and var_232_17 or var_232_17 * (utf8.len(var_232_20) / 39)) > 0 and var_232_17 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22
					var_232_16 = var_232_16 + 0.3

					if var_232_22 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_16
					end
				end

				arg_229_1.text_.text = var_232_20
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021055", "story_v_out_411021.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_411021", "411021055", "story_v_out_411021.awb") / 1000

					if var_232_23 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_16
					end

					if var_232_19.prefab_name ~= "" and arg_229_1.actors_[var_232_19.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_19.prefab_name].transform, "story_v_out_411021", "411021055", "story_v_out_411021.awb")

						arg_229_1:RecordAudio("411021055", var_232_24)
						arg_229_1:RecordAudio("411021055", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_411021", "411021055", "story_v_out_411021.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_411021", "411021055", "story_v_out_411021.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = var_232_16 + 0.3
			local var_232_26 = math.max(var_232_17, arg_229_1.talkMaxDuration)

			if var_232_16 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_25 + var_232_26 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_25) / var_232_26

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_25 + var_232_26 and arg_229_1.time_ < var_232_25 + var_232_26 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6.2,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play411021056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411021056
		arg_235_1.duration_ = 11.8

		local var_235_0 = {
			zh = 10.466,
			ja = 11.8
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
				arg_235_0:Play411021057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(411021056)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 46 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 46)

				if (46 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 46)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021056", "story_v_out_411021.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021056", "story_v_out_411021.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_411021", "411021056", "story_v_out_411021.awb")

						arg_235_1:RecordAudio("411021056", var_238_6)
						arg_235_1:RecordAudio("411021056", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411021", "411021056", "story_v_out_411021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411021", "411021056", "story_v_out_411021.awb")
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
	Play411021057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411021057
		arg_239_1.duration_ = 11.43

		local var_239_0 = {
			zh = 11.433,
			ja = 11.366
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
				arg_239_0:Play411021058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(411021057)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 49 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 49)

				if (49 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 49)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021057", "story_v_out_411021.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021057", "story_v_out_411021.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_411021", "411021057", "story_v_out_411021.awb")

						arg_239_1:RecordAudio("411021057", var_242_6)
						arg_239_1:RecordAudio("411021057", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411021", "411021057", "story_v_out_411021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411021", "411021057", "story_v_out_411021.awb")
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
	Play411021058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411021058
		arg_243_1.duration_ = 17.77

		local var_243_0 = {
			zh = 17.766,
			ja = 9.966
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
				arg_243_0:Play411021059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.475

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(411021058)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 60 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 60)

				if (60 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 60)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021058", "story_v_out_411021.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021058", "story_v_out_411021.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_411021", "411021058", "story_v_out_411021.awb")

						arg_243_1:RecordAudio("411021058", var_246_6)
						arg_243_1:RecordAudio("411021058", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411021", "411021058", "story_v_out_411021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411021", "411021058", "story_v_out_411021.awb")
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
	Play411021059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411021059
		arg_247_1.duration_ = 13.57

		local var_247_0 = {
			zh = 13.566,
			ja = 12.966
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
				arg_247_0:Play411021060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.125

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(411021059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 45 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 45)

				if (45 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 45)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021059", "story_v_out_411021.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021059", "story_v_out_411021.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_411021", "411021059", "story_v_out_411021.awb")

						arg_247_1:RecordAudio("411021059", var_250_6)
						arg_247_1:RecordAudio("411021059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411021", "411021059", "story_v_out_411021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411021", "411021059", "story_v_out_411021.awb")
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
	Play411021060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411021060
		arg_251_1.duration_ = 16.37

		local var_251_0 = {
			zh = 16.366,
			ja = 12.1
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
				arg_251_0:Play411021061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.325

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(411021060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 53 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 53)

				if (53 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 53)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021060", "story_v_out_411021.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021060", "story_v_out_411021.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_411021", "411021060", "story_v_out_411021.awb")

						arg_251_1:RecordAudio("411021060", var_254_6)
						arg_251_1:RecordAudio("411021060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411021", "411021060", "story_v_out_411021.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411021", "411021060", "story_v_out_411021.awb")
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
	Play411021061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411021061
		arg_255_1.duration_ = 10.9

		local var_255_0 = {
			zh = 10.9,
			ja = 6
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
				arg_255_0:Play411021062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.95

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(411021061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 38 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 38)

				if (38 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 38)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021061", "story_v_out_411021.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021061", "story_v_out_411021.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_411021", "411021061", "story_v_out_411021.awb")

						arg_255_1:RecordAudio("411021061", var_258_6)
						arg_255_1:RecordAudio("411021061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411021", "411021061", "story_v_out_411021.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411021", "411021061", "story_v_out_411021.awb")
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
	Play411021062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411021062
		arg_259_1.duration_ = 4.77

		local var_259_0 = {
			zh = 4.766,
			ja = 3.999999999999
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
				arg_259_0:Play411021063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 2 < arg_259_1.time_ and arg_259_1.time_ <= 2 + arg_262_0 then
				local var_262_0 = arg_259_1.bgs_.ML0502

				arg_259_1.bgs_.ML0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_262_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_1 = var_262_0:GetComponent("SpriteRenderer")

				if var_262_1 and var_262_1.sprite then
					local var_262_2 = 2 * (var_262_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_262_0.transform.localScale = Vector3.New(var_262_2 / var_262_1.sprite.bounds.size.y < var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x and var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x or var_262_2 / var_262_1.sprite.bounds.size.y, var_262_2 / var_262_1.sprite.bounds.size.y < var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x and var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x or var_262_2 / var_262_1.sprite.bounds.size.y, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "ML0502" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_3 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_4 = 2

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_4 then
				local var_262_5 = Color.New(1, 1, 1)

				var_262_5.a = Mathf.Lerp(0, 1, (arg_259_1.time_ - var_262_3) / var_262_4)
				arg_259_1.mask_.color = var_262_5
			end

			if arg_259_1.time_ >= var_262_3 + var_262_4 and arg_259_1.time_ < var_262_3 + var_262_4 + arg_262_0 then
				local var_262_6 = Color.New(1, 1, 1)

				var_262_6.a = 1
				arg_259_1.mask_.color = var_262_6
			end

			local var_262_7 = 2

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_7 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_8 = 2

			if var_262_7 <= arg_259_1.time_ and arg_259_1.time_ < var_262_7 + var_262_8 then
				local var_262_9 = Color.New(1, 1, 1)

				var_262_9.a = Mathf.Lerp(1, 0, (arg_259_1.time_ - var_262_7) / var_262_8)
				arg_259_1.mask_.color = var_262_9
			end

			if arg_259_1.time_ >= var_262_7 + var_262_8 and arg_259_1.time_ < var_262_7 + var_262_8 + arg_262_0 then
				local var_262_10 = Color.New(1, 1, 1)

				arg_259_1.mask_.enabled = false
				var_262_10.a = 0
				arg_259_1.mask_.color = var_262_10
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_11 = 2
			local var_262_12 = 0.05

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_11 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_13 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_13:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_14 = arg_259_1:GetWordFromCfg(411021062)
				local var_262_15 = arg_259_1:FormatText(var_262_14.content)

				arg_259_1.text_.text = var_262_15

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_17 = 2 <= 0 and var_262_12 or var_262_12 * (utf8.len(var_262_15) / 2)

				if (2 <= 0 and var_262_12 or var_262_12 * (utf8.len(var_262_15) / 2)) > 0 and var_262_12 < var_262_17 then
					arg_259_1.talkMaxDuration = var_262_17
					var_262_11 = var_262_11 + 0.3

					if var_262_17 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_11
					end
				end

				arg_259_1.text_.text = var_262_15
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021062", "story_v_out_411021.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_411021", "411021062", "story_v_out_411021.awb") / 1000

					if var_262_18 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_11
					end

					if var_262_14.prefab_name ~= "" and arg_259_1.actors_[var_262_14.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_14.prefab_name].transform, "story_v_out_411021", "411021062", "story_v_out_411021.awb")

						arg_259_1:RecordAudio("411021062", var_262_19)
						arg_259_1:RecordAudio("411021062", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411021", "411021062", "story_v_out_411021.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411021", "411021062", "story_v_out_411021.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_20 = var_262_11 + 0.3
			local var_262_21 = math.max(var_262_12, arg_259_1.talkMaxDuration)

			if var_262_11 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_20 + var_262_21 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_20) / var_262_21

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_20 + var_262_21 and arg_259_1.time_ < var_262_20 + var_262_21 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play411021063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 411021063
		arg_265_1.duration_ = 2.9

		local var_265_0 = {
			zh = 2.9,
			ja = 1.766
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
				arg_265_0:Play411021064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.2

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(411021063)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 8 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 8)

				if (8 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 8)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021063", "story_v_out_411021.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021063", "story_v_out_411021.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_411021", "411021063", "story_v_out_411021.awb")

						arg_265_1:RecordAudio("411021063", var_268_6)
						arg_265_1:RecordAudio("411021063", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_411021", "411021063", "story_v_out_411021.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_411021", "411021063", "story_v_out_411021.awb")
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
	Play411021064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 411021064
		arg_269_1.duration_ = 5.9

		local var_269_0 = {
			zh = 5.866,
			ja = 5.9
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
				arg_269_0:Play411021065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.625

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(411021064)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 25)

				if (25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 25)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021064", "story_v_out_411021.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021064", "story_v_out_411021.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_411021", "411021064", "story_v_out_411021.awb")

						arg_269_1:RecordAudio("411021064", var_272_6)
						arg_269_1:RecordAudio("411021064", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_411021", "411021064", "story_v_out_411021.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_411021", "411021064", "story_v_out_411021.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play411021065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 411021065
		arg_273_1.duration_ = 8.7

		local var_273_0 = {
			zh = 7.6,
			ja = 8.7
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play411021066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.8

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(411021065)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 32 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 32)

				if (32 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 32)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021065", "story_v_out_411021.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021065", "story_v_out_411021.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_411021", "411021065", "story_v_out_411021.awb")

						arg_273_1:RecordAudio("411021065", var_276_6)
						arg_273_1:RecordAudio("411021065", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_411021", "411021065", "story_v_out_411021.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_411021", "411021065", "story_v_out_411021.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play411021066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 411021066
		arg_277_1.duration_ = 13

		local var_277_0 = {
			zh = 3.833,
			ja = 13
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
				arg_277_0:Play411021067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.425

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(411021066)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 17 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 17)

				if (17 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 17)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021066", "story_v_out_411021.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021066", "story_v_out_411021.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_411021", "411021066", "story_v_out_411021.awb")

						arg_277_1:RecordAudio("411021066", var_280_6)
						arg_277_1:RecordAudio("411021066", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_411021", "411021066", "story_v_out_411021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_411021", "411021066", "story_v_out_411021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play411021067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 411021067
		arg_281_1.duration_ = 10.37

		local var_281_0 = {
			zh = 10.366,
			ja = 8.133
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
				arg_281_0:Play411021068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.15

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(411021067)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 46 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 46)

				if (46 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 46)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021067", "story_v_out_411021.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021067", "story_v_out_411021.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_411021", "411021067", "story_v_out_411021.awb")

						arg_281_1:RecordAudio("411021067", var_284_6)
						arg_281_1:RecordAudio("411021067", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_411021", "411021067", "story_v_out_411021.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_411021", "411021067", "story_v_out_411021.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play411021068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411021068
		arg_285_1.duration_ = 6

		local var_285_0 = {
			zh = 6,
			ja = 5.733
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
				arg_285_0:Play411021069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.6

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(411021068)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 24 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 24)

				if (24 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 24)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021068", "story_v_out_411021.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021068", "story_v_out_411021.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_411021", "411021068", "story_v_out_411021.awb")

						arg_285_1:RecordAudio("411021068", var_288_6)
						arg_285_1:RecordAudio("411021068", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_411021", "411021068", "story_v_out_411021.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_411021", "411021068", "story_v_out_411021.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play411021069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 411021069
		arg_289_1.duration_ = 12.3

		local var_289_0 = {
			zh = 7.6,
			ja = 12.3
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
				arg_289_0:Play411021070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.625

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(411021069)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 25 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 25)

				if (25 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 25)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021069", "story_v_out_411021.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021069", "story_v_out_411021.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_411021", "411021069", "story_v_out_411021.awb")

						arg_289_1:RecordAudio("411021069", var_292_6)
						arg_289_1:RecordAudio("411021069", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_411021", "411021069", "story_v_out_411021.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_411021", "411021069", "story_v_out_411021.awb")
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
	Play411021070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 411021070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play411021071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_296_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_2 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_2

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_2
						arg_293_1.bgmTxt2_.text = var_296_2
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_296_3 = 0
			local var_296_4 = 0.65

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(411021070).content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 26 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 26)

				if (26 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 26)) > 0 and var_296_4 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_3
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_4, arg_293_1.talkMaxDuration)

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_3) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_3 + var_296_8 and arg_293_1.time_ < var_296_3 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play411021071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411021071
		arg_298_1.duration_ = 9

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411021072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 2 < arg_298_1.time_ and arg_298_1.time_ <= 2 + arg_301_0 then
				local var_301_0 = arg_298_1.bgs_.I11m

				arg_298_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_301_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_1 = var_301_0:GetComponent("SpriteRenderer")

				if var_301_1 and var_301_1.sprite then
					local var_301_2 = 2 * (var_301_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_301_0.transform.localScale = Vector3.New(var_301_2 / var_301_1.sprite.bounds.size.y < var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x and var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x or var_301_2 / var_301_1.sprite.bounds.size.y, var_301_2 / var_301_1.sprite.bounds.size.y < var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x and var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x or var_301_2 / var_301_1.sprite.bounds.size.y, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "I11m" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_3 = 0

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_3 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_4 = 2

			if var_301_3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_3 + var_301_4 then
				local var_301_5 = Color.New(0, 0, 0)

				var_301_5.a = Mathf.Lerp(0, 1, (arg_298_1.time_ - var_301_3) / var_301_4)
				arg_298_1.mask_.color = var_301_5
			end

			if arg_298_1.time_ >= var_301_3 + var_301_4 and arg_298_1.time_ < var_301_3 + var_301_4 + arg_301_0 then
				local var_301_6 = Color.New(0, 0, 0)

				var_301_6.a = 1
				arg_298_1.mask_.color = var_301_6
			end

			local var_301_7 = 2

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_7 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_8 = 2

			if var_301_7 <= arg_298_1.time_ and arg_298_1.time_ < var_301_7 + var_301_8 then
				local var_301_9 = Color.New(0, 0, 0)

				var_301_9.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_7) / var_301_8)
				arg_298_1.mask_.color = var_301_9
			end

			if arg_298_1.time_ >= var_301_7 + var_301_8 and arg_298_1.time_ < var_301_7 + var_301_8 + arg_301_0 then
				local var_301_10 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_10.a = 0
				arg_298_1.mask_.color = var_301_10
			end

			if 4 < arg_298_1.time_ and arg_298_1.time_ <= 4 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_12 = 4
			local var_301_13 = 0.8

			if 4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_12 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_14 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_14:setOnUpdate(LuaHelper.FloatAction(function(arg_302_0)
					arg_298_1.dialogCg_.alpha = arg_302_0
				end))
				var_301_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_15 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(411021071).content)

				arg_298_1.text_.text = var_301_15

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_17 = 32 <= 0 and var_301_13 or var_301_13 * (utf8.len(var_301_15) / 32)

				if (32 <= 0 and var_301_13 or var_301_13 * (utf8.len(var_301_15) / 32)) > 0 and var_301_13 < var_301_17 then
					arg_298_1.talkMaxDuration = var_301_17
					var_301_12 = var_301_12 + 0.3

					if var_301_17 + var_301_12 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_17 + var_301_12
					end
				end

				arg_298_1.text_.text = var_301_15
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_18 = var_301_12 + 0.3
			local var_301_19 = math.max(var_301_13, arg_298_1.talkMaxDuration)

			if var_301_12 + 0.3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_18 + var_301_19 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_18) / var_301_19

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_18 + var_301_19 and arg_298_1.time_ < var_301_18 + var_301_19 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play411021072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 411021072
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play411021073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.5

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(411021072).content)

				arg_304_1.text_.text = var_307_1

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_3 = 20 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 20)

				if (20 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 20)) > 0 and var_307_0 < var_307_3 then
					arg_304_1.talkMaxDuration = var_307_3

					if var_307_3 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_3 + 0
					end
				end

				arg_304_1.text_.text = var_307_1
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_4 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_4

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play411021073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 411021073
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play411021074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if arg_308_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_311_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_308_1.stage_.transform)

				var_311_0.name = "10014ui_story"
				var_311_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["10014ui_story"] = var_311_0

				local var_311_1 = var_311_0:GetComponentInChildren(typeof(CharacterEffect))

				var_311_1.enabled = true

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_0, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end

				arg_308_1:ShowWeapon(var_311_1.transform, false)

				arg_308_1.var_["10014ui_story" .. "Animator"] = var_311_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_308_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_308_1.var_["10014ui_story" .. "LipSync"] = var_311_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_311_3 = arg_308_1.actors_["10014ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10014ui_story = var_311_3.localPosition
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_3.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_308_1.time_ - 0) / var_311_4)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			local var_311_5 = arg_308_1.actors_["10014ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect10014ui_story == nil then
				arg_308_1.var_.characterEffect10014ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.characterEffect10014ui_story and not isNil(var_311_5) then
					arg_308_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect10014ui_story then
				arg_308_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = arg_308_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_311_8 = arg_308_1.var_.characterEffect10014ui_story

				arg_308_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_311_8.interferenceEffect.enabled = true
				var_311_8.interferenceEffect.noise = 0.01
				var_311_8.interferenceEffect.simTimeScale = 1
				var_311_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = arg_308_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_308_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_311_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_12 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_12

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_12
						arg_308_1.bgmTxt2_.text = var_311_12
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_308_1.time_ and arg_308_1.time_ <= 0.6 + arg_311_0 then
				arg_308_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_311_15 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_15 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_15

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_15
						arg_308_1.bgmTxt2_.text = var_311_15
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_311_16 = 0
			local var_311_17 = 0.375

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(411021073)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_21 = 15 <= 0 and var_311_17 or var_311_17 * (utf8.len(var_311_19) / 15)

				if (15 <= 0 and var_311_17 or var_311_17 * (utf8.len(var_311_19) / 15)) > 0 and var_311_17 < var_311_21 then
					arg_308_1.talkMaxDuration = var_311_21

					if var_311_21 + var_311_16 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_21 + var_311_16
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021073", "story_v_out_411021.awb") ~= 0 then
					local var_311_22 = manager.audio:GetVoiceLength("story_v_out_411021", "411021073", "story_v_out_411021.awb") / 1000

					if var_311_22 + var_311_16 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_16
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_411021", "411021073", "story_v_out_411021.awb")

						arg_308_1:RecordAudio("411021073", var_311_23)
						arg_308_1:RecordAudio("411021073", var_311_23)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_411021", "411021073", "story_v_out_411021.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_411021", "411021073", "story_v_out_411021.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_24 = math.max(var_311_17, arg_308_1.talkMaxDuration)

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_24 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_16) / var_311_24

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_16 + var_311_24 and arg_308_1.time_ < var_311_16 + var_311_24 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play411021074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411021074
		arg_314_1.duration_ = 6.37

		local var_314_0 = {
			zh = 6.366,
			ja = 6.033
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play411021075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.85

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(411021074)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 34 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 34)

				if (34 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 34)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021074", "story_v_out_411021.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021074", "story_v_out_411021.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_411021", "411021074", "story_v_out_411021.awb")

						arg_314_1:RecordAudio("411021074", var_317_6)
						arg_314_1:RecordAudio("411021074", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411021", "411021074", "story_v_out_411021.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411021", "411021074", "story_v_out_411021.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play411021075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411021075
		arg_318_1.duration_ = 2.03

		local var_318_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play411021076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1095ui_story = arg_318_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).z)
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles = arg_318_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_318_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1095ui_story"].transform.position).z)
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1095ui_story"].transform.localEulerAngles = arg_318_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_321_1 = arg_318_1.actors_["1095ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1095ui_story == nil then
				arg_318_1.var_.characterEffect1095ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 and not isNil(var_321_1) then
				if arg_318_1.var_.characterEffect1095ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1095ui_story then
				arg_318_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_4 = arg_318_1.actors_["10014ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos10014ui_story = var_321_4.localPosition
			end

			local var_321_5 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_5 then
				var_321_4.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_318_1.time_ - 0) / var_321_5)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_5 and arg_318_1.time_ < 0 + var_321_5 + arg_321_0 then
				var_321_4.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			local var_321_6 = arg_318_1.actors_["10014ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_6) and arg_318_1.var_.characterEffect10014ui_story == nil then
				arg_318_1.var_.characterEffect10014ui_story = var_321_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_7 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 and not isNil(var_321_6) then
				if arg_318_1.var_.characterEffect10014ui_story and not isNil(var_321_6) then
					arg_318_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_7)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 and not isNil(var_321_6) and arg_318_1.var_.characterEffect10014ui_story then
				arg_318_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_321_8 = 0
			local var_321_9 = 0.175

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_10 = arg_318_1:GetWordFromCfg(411021075)
				local var_321_11 = arg_318_1:FormatText(var_321_10.content)

				arg_318_1.text_.text = var_321_11

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 7 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 7)

				if (7 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 7)) > 0 and var_321_9 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_8
					end
				end

				arg_318_1.text_.text = var_321_11
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021075", "story_v_out_411021.awb") ~= 0 then
					local var_321_14 = manager.audio:GetVoiceLength("story_v_out_411021", "411021075", "story_v_out_411021.awb") / 1000

					if var_321_14 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_8
					end

					if var_321_10.prefab_name ~= "" and arg_318_1.actors_[var_321_10.prefab_name] ~= nil then
						local var_321_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_10.prefab_name].transform, "story_v_out_411021", "411021075", "story_v_out_411021.awb")

						arg_318_1:RecordAudio("411021075", var_321_15)
						arg_318_1:RecordAudio("411021075", var_321_15)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_411021", "411021075", "story_v_out_411021.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_411021", "411021075", "story_v_out_411021.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_9, arg_318_1.talkMaxDuration)

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_8) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_8 + var_321_16 and arg_318_1.time_ < var_321_8 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
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
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play411021076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 411021076
		arg_322_1.duration_ = 8.27

		local var_322_0 = {
			zh = 4.2,
			ja = 8.266
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play411021077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1095ui_story"]) and arg_322_1.var_.characterEffect1095ui_story == nil then
				arg_322_1.var_.characterEffect1095ui_story = arg_322_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1095ui_story"]) then
				if arg_322_1.var_.characterEffect1095ui_story and not isNil(arg_322_1.actors_["1095ui_story"]) then
					arg_322_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1095ui_story"]) and arg_322_1.var_.characterEffect1095ui_story then
				arg_322_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_325_1 = arg_322_1.actors_["10014ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect10014ui_story == nil then
				arg_322_1.var_.characterEffect10014ui_story = var_325_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_2 and not isNil(var_325_1) then
				if arg_322_1.var_.characterEffect10014ui_story and not isNil(var_325_1) then
					arg_322_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_2 and arg_322_1.time_ < 0 + var_325_2 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect10014ui_story then
				arg_322_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_325_4 = 0
			local var_325_5 = 0.525

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_6 = arg_322_1:GetWordFromCfg(411021076)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 21 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 21)

				if (21 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 21)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021076", "story_v_out_411021.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021076", "story_v_out_411021.awb") / 1000

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end

					if var_325_6.prefab_name ~= "" and arg_322_1.actors_[var_325_6.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_6.prefab_name].transform, "story_v_out_411021", "411021076", "story_v_out_411021.awb")

						arg_322_1:RecordAudio("411021076", var_325_11)
						arg_322_1:RecordAudio("411021076", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_411021", "411021076", "story_v_out_411021.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_411021", "411021076", "story_v_out_411021.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_12 and arg_322_1.time_ < var_325_4 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play411021077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 411021077
		arg_326_1.duration_ = 7.07

		local var_326_0 = {
			zh = 5.2,
			ja = 7.066
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play411021078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1095ui_story = arg_326_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).z)
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles = arg_326_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_326_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1095ui_story"].transform.position).z)
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1095ui_story"].transform.localEulerAngles = arg_326_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["1095ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1095ui_story == nil then
				arg_326_1.var_.characterEffect1095ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect1095ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1095ui_story then
				arg_326_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_329_4 = arg_326_1.actors_["10014ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect10014ui_story == nil then
				arg_326_1.var_.characterEffect10014ui_story = var_329_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_5 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_5 and not isNil(var_329_4) then
				if arg_326_1.var_.characterEffect10014ui_story and not isNil(var_329_4) then
					arg_326_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_326_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_5)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_5 and arg_326_1.time_ < 0 + var_329_5 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect10014ui_story then
				arg_326_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_326_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_329_6 = 0
			local var_329_7 = 0.675

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_8 = arg_326_1:GetWordFromCfg(411021077)
				local var_329_9 = arg_326_1:FormatText(var_329_8.content)

				arg_326_1.text_.text = var_329_9

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 27 <= 0 and var_329_7 or var_329_7 * (utf8.len(var_329_9) / 27)

				if (27 <= 0 and var_329_7 or var_329_7 * (utf8.len(var_329_9) / 27)) > 0 and var_329_7 < var_329_11 then
					arg_326_1.talkMaxDuration = var_329_11

					if var_329_11 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_9
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021077", "story_v_out_411021.awb") ~= 0 then
					local var_329_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021077", "story_v_out_411021.awb") / 1000

					if var_329_12 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_12 + var_329_6
					end

					if var_329_8.prefab_name ~= "" and arg_326_1.actors_[var_329_8.prefab_name] ~= nil then
						local var_329_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_8.prefab_name].transform, "story_v_out_411021", "411021077", "story_v_out_411021.awb")

						arg_326_1:RecordAudio("411021077", var_329_13)
						arg_326_1:RecordAudio("411021077", var_329_13)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_411021", "411021077", "story_v_out_411021.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_411021", "411021077", "story_v_out_411021.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_14 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_14 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_14

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_14 and arg_326_1.time_ < var_329_6 + var_329_14 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play411021078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411021078
		arg_330_1.duration_ = 7.3

		local var_330_0 = {
			zh = 6.066,
			ja = 7.3
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play411021079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10014ui_story = arg_330_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).z)
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles = arg_330_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_330_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10014ui_story"].transform.position).z)
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10014ui_story"].transform.localEulerAngles = arg_330_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["10014ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10014ui_story == nil then
				arg_330_1.var_.characterEffect10014ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect10014ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10014ui_story then
				arg_330_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_4 = arg_330_1.actors_["1095ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_4) and arg_330_1.var_.characterEffect1095ui_story == nil then
				arg_330_1.var_.characterEffect1095ui_story = var_333_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_5 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_5 and not isNil(var_333_4) then
				if arg_330_1.var_.characterEffect1095ui_story and not isNil(var_333_4) then
					arg_330_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_5)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_5 and arg_330_1.time_ < 0 + var_333_5 + arg_333_0 and not isNil(var_333_4) and arg_330_1.var_.characterEffect1095ui_story then
				arg_330_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_333_6 = 0
			local var_333_7 = 0.775

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(411021078)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_11 = 31 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_9) / 31)

				if (31 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_9) / 31)) > 0 and var_333_7 < var_333_11 then
					arg_330_1.talkMaxDuration = var_333_11

					if var_333_11 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021078", "story_v_out_411021.awb") ~= 0 then
					local var_333_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021078", "story_v_out_411021.awb") / 1000

					if var_333_12 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_6
					end

					if var_333_8.prefab_name ~= "" and arg_330_1.actors_[var_333_8.prefab_name] ~= nil then
						local var_333_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_8.prefab_name].transform, "story_v_out_411021", "411021078", "story_v_out_411021.awb")

						arg_330_1:RecordAudio("411021078", var_333_13)
						arg_330_1:RecordAudio("411021078", var_333_13)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_411021", "411021078", "story_v_out_411021.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_411021", "411021078", "story_v_out_411021.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_14 and arg_330_1.time_ < var_333_6 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play411021079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411021079
		arg_334_1.duration_ = 4.53

		local var_334_0 = {
			zh = 3.666,
			ja = 4.533
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play411021080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.5

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:GetWordFromCfg(411021079)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 20 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 20)

				if (20 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 20)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021079", "story_v_out_411021.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021079", "story_v_out_411021.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_411021", "411021079", "story_v_out_411021.awb")

						arg_334_1:RecordAudio("411021079", var_337_6)
						arg_334_1:RecordAudio("411021079", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411021", "411021079", "story_v_out_411021.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411021", "411021079", "story_v_out_411021.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play411021080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411021080
		arg_338_1.duration_ = 3.63

		local var_338_0 = {
			zh = 2.166,
			ja = 3.633
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play411021081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1095ui_story = arg_338_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).z)
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles = arg_338_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_338_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1095ui_story"].transform.position).z)
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1095ui_story"].transform.localEulerAngles = arg_338_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["1095ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect1095ui_story == nil then
				arg_338_1.var_.characterEffect1095ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect1095ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect1095ui_story then
				arg_338_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_341_4 = arg_338_1.actors_["10014ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_4) and arg_338_1.var_.characterEffect10014ui_story == nil then
				arg_338_1.var_.characterEffect10014ui_story = var_341_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_5 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_5 and not isNil(var_341_4) then
				if arg_338_1.var_.characterEffect10014ui_story and not isNil(var_341_4) then
					arg_338_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_338_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_5)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_5 and arg_338_1.time_ < 0 + var_341_5 + arg_341_0 and not isNil(var_341_4) and arg_338_1.var_.characterEffect10014ui_story then
				arg_338_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_338_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_341_6 = 0
			local var_341_7 = 0.275

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_8 = arg_338_1:GetWordFromCfg(411021080)
				local var_341_9 = arg_338_1:FormatText(var_341_8.content)

				arg_338_1.text_.text = var_341_9

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 11 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 11)

				if (11 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 11)) > 0 and var_341_7 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_9
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021080", "story_v_out_411021.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_out_411021", "411021080", "story_v_out_411021.awb") / 1000

					if var_341_12 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_6
					end

					if var_341_8.prefab_name ~= "" and arg_338_1.actors_[var_341_8.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_8.prefab_name].transform, "story_v_out_411021", "411021080", "story_v_out_411021.awb")

						arg_338_1:RecordAudio("411021080", var_341_13)
						arg_338_1:RecordAudio("411021080", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411021", "411021080", "story_v_out_411021.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411021", "411021080", "story_v_out_411021.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play411021081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411021081
		arg_342_1.duration_ = 2.4

		local var_342_0 = {
			zh = 2.4,
			ja = 2.333
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play411021082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) and arg_342_1.var_.characterEffect1095ui_story == nil then
				arg_342_1.var_.characterEffect1095ui_story = arg_342_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) then
				if arg_342_1.var_.characterEffect1095ui_story and not isNil(arg_342_1.actors_["1095ui_story"]) then
					arg_342_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) and arg_342_1.var_.characterEffect1095ui_story then
				arg_342_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_345_1 = arg_342_1.actors_["10014ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect10014ui_story == nil then
				arg_342_1.var_.characterEffect10014ui_story = var_345_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 and not isNil(var_345_1) then
				if arg_342_1.var_.characterEffect10014ui_story and not isNil(var_345_1) then
					arg_342_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect10014ui_story then
				arg_342_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_345_4 = 0
			local var_345_5 = 0.25

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_6 = arg_342_1:GetWordFromCfg(411021081)
				local var_345_7 = arg_342_1:FormatText(var_345_6.content)

				arg_342_1.text_.text = var_345_7

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 10 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 10)

				if (10 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 10)) > 0 and var_345_5 < var_345_9 then
					arg_342_1.talkMaxDuration = var_345_9

					if var_345_9 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_7
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021081", "story_v_out_411021.awb") ~= 0 then
					local var_345_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021081", "story_v_out_411021.awb") / 1000

					if var_345_10 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_10 + var_345_4
					end

					if var_345_6.prefab_name ~= "" and arg_342_1.actors_[var_345_6.prefab_name] ~= nil then
						local var_345_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_6.prefab_name].transform, "story_v_out_411021", "411021081", "story_v_out_411021.awb")

						arg_342_1:RecordAudio("411021081", var_345_11)
						arg_342_1:RecordAudio("411021081", var_345_11)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411021", "411021081", "story_v_out_411021.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411021", "411021081", "story_v_out_411021.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_12 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_12 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_12

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_12 and arg_342_1.time_ < var_345_4 + var_345_12 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play411021082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 411021082
		arg_346_1.duration_ = 2.83

		local var_346_0 = {
			zh = 1.2,
			ja = 2.833
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play411021083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10014ui_story"]) and arg_346_1.var_.characterEffect10014ui_story == nil then
				arg_346_1.var_.characterEffect10014ui_story = arg_346_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10014ui_story"]) then
				if arg_346_1.var_.characterEffect10014ui_story and not isNil(arg_346_1.actors_["10014ui_story"]) then
					arg_346_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_346_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10014ui_story"]) and arg_346_1.var_.characterEffect10014ui_story then
				arg_346_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_346_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_349_1 = arg_346_1.actors_["1095ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1095ui_story == nil then
				arg_346_1.var_.characterEffect1095ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect1095ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1095ui_story then
				arg_346_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_349_4 = 0
			local var_349_5 = 0.125

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(411021082)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 5 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 5)

				if (5 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 5)) > 0 and var_349_5 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021082", "story_v_out_411021.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021082", "story_v_out_411021.awb") / 1000

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end

					if var_349_6.prefab_name ~= "" and arg_346_1.actors_[var_349_6.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_6.prefab_name].transform, "story_v_out_411021", "411021082", "story_v_out_411021.awb")

						arg_346_1:RecordAudio("411021082", var_349_11)
						arg_346_1:RecordAudio("411021082", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_411021", "411021082", "story_v_out_411021.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_411021", "411021082", "story_v_out_411021.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_12 and arg_346_1.time_ < var_349_4 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play411021083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 411021083
		arg_350_1.duration_ = 7.03

		local var_350_0 = {
			zh = 6.866,
			ja = 7.033
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play411021084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10014ui_story"]) and arg_350_1.var_.characterEffect10014ui_story == nil then
				arg_350_1.var_.characterEffect10014ui_story = arg_350_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10014ui_story"]) then
				if arg_350_1.var_.characterEffect10014ui_story and not isNil(arg_350_1.actors_["10014ui_story"]) then
					arg_350_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10014ui_story"]) and arg_350_1.var_.characterEffect10014ui_story then
				arg_350_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_353_2 = arg_350_1.actors_["1095ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.characterEffect1095ui_story == nil then
				arg_350_1.var_.characterEffect1095ui_story = var_353_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_3 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.characterEffect1095ui_story and not isNil(var_353_2) then
					arg_350_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_3)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.characterEffect1095ui_story then
				arg_350_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_353_4 = 0
			local var_353_5 = 0.925

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(411021083)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 37 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 37)

				if (37 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 37)) > 0 and var_353_5 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021083", "story_v_out_411021.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_out_411021", "411021083", "story_v_out_411021.awb") / 1000

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end

					if var_353_6.prefab_name ~= "" and arg_350_1.actors_[var_353_6.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_6.prefab_name].transform, "story_v_out_411021", "411021083", "story_v_out_411021.awb")

						arg_350_1:RecordAudio("411021083", var_353_11)
						arg_350_1:RecordAudio("411021083", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_411021", "411021083", "story_v_out_411021.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_411021", "411021083", "story_v_out_411021.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_12 and arg_350_1.time_ < var_353_4 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play411021084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 411021084
		arg_354_1.duration_ = 4.8

		local var_354_0 = {
			zh = 4.8,
			ja = 4.066
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.475

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:GetWordFromCfg(411021084)
				local var_357_2 = arg_354_1:FormatText(var_357_1.content)

				arg_354_1.text_.text = var_357_2

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 19 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 19)

				if (19 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 19)) > 0 and var_357_0 < var_357_4 then
					arg_354_1.talkMaxDuration = var_357_4

					if var_357_4 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_4 + 0
					end
				end

				arg_354_1.text_.text = var_357_2
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411021", "411021084", "story_v_out_411021.awb") ~= 0 then
					local var_357_5 = manager.audio:GetVoiceLength("story_v_out_411021", "411021084", "story_v_out_411021.awb") / 1000

					if var_357_5 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + 0
					end

					if var_357_1.prefab_name ~= "" and arg_354_1.actors_[var_357_1.prefab_name] ~= nil then
						local var_357_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_1.prefab_name].transform, "story_v_out_411021", "411021084", "story_v_out_411021.awb")

						arg_354_1:RecordAudio("411021084", var_357_6)
						arg_354_1:RecordAudio("411021084", var_357_6)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_411021", "411021084", "story_v_out_411021.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_411021", "411021084", "story_v_out_411021.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/ST74a",
		"TextureConfig/Background/ML0502",
		"TextureConfig/Background/ML0501"
	},
	voices = {
		"story_v_out_411021.awb"
	}
}
