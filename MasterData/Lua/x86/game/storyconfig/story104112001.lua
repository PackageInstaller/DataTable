return {
	Play411201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_4_0.name = "I07"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07

				arg_1_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07" then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2")

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
			local var_4_15 = 0.325

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411201001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)

				if (13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)) > 0 and var_4_15 < var_4_19 then
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
	Play411201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411201002
		arg_9_1.duration_ = 2.67

		local var_9_0 = {
			zh = 2.133,
			ja = 2.666
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
				arg_9_0:Play411201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(411201002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 14 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 14)

				if (14 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 14)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201002", "story_v_out_411201.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201002", "story_v_out_411201.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_411201", "411201002", "story_v_out_411201.awb")

						arg_9_1:RecordAudio("411201002", var_12_6)
						arg_9_1:RecordAudio("411201002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411201", "411201002", "story_v_out_411201.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411201", "411201002", "story_v_out_411201.awb")
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
	Play411201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411201003
		arg_13_1.duration_ = 5.37

		local var_13_0 = {
			zh = 5.366,
			ja = 2.133
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
				arg_13_0:Play411201004(arg_13_1)
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
			local var_16_9 = 0.775

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

				local var_16_10 = arg_13_1:GetWordFromCfg(411201003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 31 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 31)

				if (31 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 31)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201003", "story_v_out_411201.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201003", "story_v_out_411201.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_411201", "411201003", "story_v_out_411201.awb")

						arg_13_1:RecordAudio("411201003", var_16_15)
						arg_13_1:RecordAudio("411201003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411201", "411201003", "story_v_out_411201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411201", "411201003", "story_v_out_411201.awb")
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
	Play411201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411201004
		arg_17_1.duration_ = 3.87

		local var_17_0 = {
			zh = 3.766,
			ja = 3.866
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
				arg_17_0:Play411201005(arg_17_1)
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

			local var_20_2 = 0
			local var_20_3 = 0.425

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

				local var_20_4 = arg_17_1:GetWordFromCfg(411201004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)

				if (17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201004", "story_v_out_411201.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_411201", "411201004", "story_v_out_411201.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_411201", "411201004", "story_v_out_411201.awb")

						arg_17_1:RecordAudio("411201004", var_20_9)
						arg_17_1:RecordAudio("411201004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411201", "411201004", "story_v_out_411201.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411201", "411201004", "story_v_out_411201.awb")
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
	Play411201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411201005
		arg_21_1.duration_ = 1.83

		local var_21_0 = {
			zh = 1.833,
			ja = 1.333
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
				arg_21_0:Play411201006(arg_21_1)
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
			local var_24_2 = 0.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(411201005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 6 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 6)

				if (6 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 6)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201005", "story_v_out_411201.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_411201", "411201005", "story_v_out_411201.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_411201", "411201005", "story_v_out_411201.awb")

						arg_21_1:RecordAudio("411201005", var_24_8)
						arg_21_1:RecordAudio("411201005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411201", "411201005", "story_v_out_411201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411201", "411201005", "story_v_out_411201.awb")
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
	Play411201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411201006
		arg_25_1.duration_ = 3.2

		local var_25_0 = {
			zh = 3.2,
			ja = 2.566
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
				arg_25_0:Play411201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(411201006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201006", "story_v_out_411201.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201006", "story_v_out_411201.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_411201", "411201006", "story_v_out_411201.awb")

						arg_25_1:RecordAudio("411201006", var_28_6)
						arg_25_1:RecordAudio("411201006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411201", "411201006", "story_v_out_411201.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411201", "411201006", "story_v_out_411201.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411201007
		arg_29_1.duration_ = 2.77

		local var_29_0 = {
			zh = 2.5,
			ja = 2.766
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
				arg_29_0:Play411201008(arg_29_1)
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
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_32_2 = 0
			local var_32_3 = 0.3

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

				local var_32_4 = arg_29_1:GetWordFromCfg(411201007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 12 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 12)

				if (12 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 12)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201007", "story_v_out_411201.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_411201", "411201007", "story_v_out_411201.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_411201", "411201007", "story_v_out_411201.awb")

						arg_29_1:RecordAudio("411201007", var_32_9)
						arg_29_1:RecordAudio("411201007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411201", "411201007", "story_v_out_411201.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411201", "411201007", "story_v_out_411201.awb")
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
	Play411201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411201008
		arg_33_1.duration_ = 6.53

		local var_33_0 = {
			zh = 3.766,
			ja = 6.533
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
				arg_33_0:Play411201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
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

				local var_36_1 = arg_33_1:GetWordFromCfg(411201008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 22 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 22)

				if (22 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 22)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201008", "story_v_out_411201.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201008", "story_v_out_411201.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_411201", "411201008", "story_v_out_411201.awb")

						arg_33_1:RecordAudio("411201008", var_36_6)
						arg_33_1:RecordAudio("411201008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411201", "411201008", "story_v_out_411201.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411201", "411201008", "story_v_out_411201.awb")
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
	Play411201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411201009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = arg_37_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).z)
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles = arg_37_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).z)
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles = arg_37_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1095ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_40_3 = 0
			local var_40_4 = 1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411201009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 40 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 40)

				if (40 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 40)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411201010
		arg_41_1.duration_ = 6.13

		local var_41_0 = {
			zh = 6.133,
			ja = 2.5
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
				arg_41_0:Play411201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = arg_41_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1095ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(411201010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 30 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 30)

				if (30 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 30)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201010", "story_v_out_411201.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201010", "story_v_out_411201.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_411201", "411201010", "story_v_out_411201.awb")

						arg_41_1:RecordAudio("411201010", var_44_11)
						arg_41_1:RecordAudio("411201010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411201", "411201010", "story_v_out_411201.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411201", "411201010", "story_v_out_411201.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play411201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411201011
		arg_45_1.duration_ = 4.17

		local var_45_0 = {
			zh = 4.166,
			ja = 1.866
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
				arg_45_0:Play411201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
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

				local var_48_1 = arg_45_1:GetWordFromCfg(411201011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)

				if (21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201011", "story_v_out_411201.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201011", "story_v_out_411201.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_411201", "411201011", "story_v_out_411201.awb")

						arg_45_1:RecordAudio("411201011", var_48_6)
						arg_45_1:RecordAudio("411201011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411201", "411201011", "story_v_out_411201.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411201", "411201011", "story_v_out_411201.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play411201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411201012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = arg_49_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(arg_49_1.actors_["1095ui_story"]) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 1.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(411201012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 60 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 60)

				if (60 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 60)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411201013
		arg_53_1.duration_ = 4.87

		local var_53_0 = {
			zh = 4.766,
			ja = 4.866
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
				arg_53_0:Play411201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = arg_53_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(arg_53_1.actors_["1095ui_story"]) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_56_2 = 0
			local var_56_3 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
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

				local var_56_4 = arg_53_1:GetWordFromCfg(411201013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 19 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 19)

				if (19 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 19)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201013", "story_v_out_411201.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_411201", "411201013", "story_v_out_411201.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_411201", "411201013", "story_v_out_411201.awb")

						arg_53_1:RecordAudio("411201013", var_56_9)
						arg_53_1:RecordAudio("411201013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411201", "411201013", "story_v_out_411201.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411201", "411201013", "story_v_out_411201.awb")
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
	Play411201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411201014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1095ui_story = arg_57_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).z)
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles = arg_57_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).z)
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles = arg_57_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1095ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1095ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_60_3 = 0
			local var_60_4 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(411201014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 32 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 32)

				if (32 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 32)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play411201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411201015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.775

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(411201015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 31 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 31)

				if (31 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 31)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play411201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411201016
		arg_65_1.duration_ = 3.37

		local var_65_0 = {
			zh = 3.366,
			ja = 3
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
				arg_65_0:Play411201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "1024ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1024ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["1024ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["1024ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["1024ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1024ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, -1, -6.05)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["1024ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1024ui_story == nil then
				arg_65_1.var_.characterEffect1024ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1024ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1024ui_story then
				arg_65_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				if arg_65_1.var_.characterEffect1024ui_story == nil then
					arg_65_1.var_.characterEffect1024ui_story = arg_65_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_68_8 = arg_65_1.var_.characterEffect1024ui_story

				arg_65_1.var_.characterEffect1024ui_story.imageEffect:turnOff()

				var_68_8.interferenceEffect.enabled = true
				var_68_8.interferenceEffect.noise = 0.01
				var_68_8.interferenceEffect.simTimeScale = 1
				var_68_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				if arg_65_1.var_.characterEffect1024ui_story == nil then
					arg_65_1.var_.characterEffect1024ui_story = arg_65_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_65_1.var_.characterEffect1024ui_story.imageEffect:turnOn(false)
			end

			local var_68_10 = 0
			local var_68_11 = 0.45

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(411201016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 18 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 18)

				if (18 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 18)) > 0 and var_68_11 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201016", "story_v_out_411201.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_411201", "411201016", "story_v_out_411201.awb") / 1000

					if var_68_16 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_10
					end

					if var_68_12.prefab_name ~= "" and arg_65_1.actors_[var_68_12.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_12.prefab_name].transform, "story_v_out_411201", "411201016", "story_v_out_411201.awb")

						arg_65_1:RecordAudio("411201016", var_68_17)
						arg_65_1:RecordAudio("411201016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411201", "411201016", "story_v_out_411201.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411201", "411201016", "story_v_out_411201.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_18 and arg_65_1.time_ < var_68_10 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411201017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411201017
		arg_69_1.duration_ = 5.33

		local var_69_0 = {
			zh = 4.4,
			ja = 5.333
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
				arg_69_0:Play411201018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1024ui_story = arg_69_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).z)
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles = arg_69_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1024ui_story"].transform.position).z)
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1024ui_story"].transform.localEulerAngles = arg_69_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1024ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1024ui_story == nil then
				arg_69_1.var_.characterEffect1024ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1024ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_2)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1024ui_story then
				arg_69_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_72_3 = "10014ui_story"

			if arg_69_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_72_4 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_69_1.stage_.transform)

				var_72_4.name = var_72_3
				var_72_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_[var_72_3] = var_72_4

				local var_72_5 = var_72_4:GetComponentInChildren(typeof(CharacterEffect))

				var_72_5.enabled = true

				local var_72_6 = GameObjectTools.GetOrAddComponent(var_72_4, typeof(DynamicBoneHelper))

				if var_72_6 then
					var_72_6:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_5.transform, false)

				arg_69_1.var_[var_72_3 .. "Animator"] = var_72_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_[var_72_3 .. "Animator"].applyRootMotion = true
				arg_69_1.var_[var_72_3 .. "LipSync"] = var_72_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_7 = arg_69_1.actors_["10014ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10014ui_story = var_72_7.localPosition
			end

			local var_72_8 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_8 then
				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_69_1.time_ - 0) / var_72_8)
				var_72_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_7.position).x, (manager.ui.mainCamera.transform.position - var_72_7.position).y, (manager.ui.mainCamera.transform.position - var_72_7.position).z)
				var_72_7.localEulerAngles.z = 0
				var_72_7.localEulerAngles.x = 0
				var_72_7.localEulerAngles = var_72_7.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_8 and arg_69_1.time_ < 0 + var_72_8 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(0, -1.06, -6.2)
				var_72_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_7.position).x, (manager.ui.mainCamera.transform.position - var_72_7.position).y, (manager.ui.mainCamera.transform.position - var_72_7.position).z)
				var_72_7.localEulerAngles.z = 0
				var_72_7.localEulerAngles.x = 0
				var_72_7.localEulerAngles = var_72_7.localEulerAngles
			end

			local var_72_9 = arg_69_1.actors_["10014ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10014ui_story == nil then
				arg_69_1.var_.characterEffect10014ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_10 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_10 and not isNil(var_72_9) then
				if arg_69_1.var_.characterEffect10014ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_10 and arg_69_1.time_ < 0 + var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10014ui_story then
				arg_69_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				if arg_69_1.var_.characterEffect10014ui_story == nil then
					arg_69_1.var_.characterEffect10014ui_story = arg_69_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_72_12 = arg_69_1.var_.characterEffect10014ui_story

				arg_69_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)

				var_72_12.interferenceEffect.enabled = true
				var_72_12.interferenceEffect.noise = 0.01
				var_72_12.interferenceEffect.simTimeScale = 1
				var_72_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				if arg_69_1.var_.characterEffect10014ui_story == nil then
					arg_69_1.var_.characterEffect10014ui_story = arg_69_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_69_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_72_14 = 0
			local var_72_15 = 0.525

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(411201017)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_19 = 21 <= 0 and var_72_15 or var_72_15 * (utf8.len(var_72_17) / 21)

				if (21 <= 0 and var_72_15 or var_72_15 * (utf8.len(var_72_17) / 21)) > 0 and var_72_15 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_14
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201017", "story_v_out_411201.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_411201", "411201017", "story_v_out_411201.awb") / 1000

					if var_72_20 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_14
					end

					if var_72_16.prefab_name ~= "" and arg_69_1.actors_[var_72_16.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_16.prefab_name].transform, "story_v_out_411201", "411201017", "story_v_out_411201.awb")

						arg_69_1:RecordAudio("411201017", var_72_21)
						arg_69_1:RecordAudio("411201017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_411201", "411201017", "story_v_out_411201.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_411201", "411201017", "story_v_out_411201.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_15, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_22 and arg_69_1.time_ < var_72_14 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play411201018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411201018
		arg_73_1.duration_ = 5.3

		local var_73_0 = {
			zh = 3.833,
			ja = 5.3
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
				arg_73_0:Play411201019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1024ui_story = arg_73_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).z)
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles = arg_73_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_73_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1024ui_story"].transform.position).z)
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1024ui_story"].transform.localEulerAngles = arg_73_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1024ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1024ui_story == nil then
				arg_73_1.var_.characterEffect1024ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1024ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1024ui_story then
				arg_73_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = arg_73_1.actors_["10014ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10014ui_story = var_76_4.localPosition
			end

			local var_76_5 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 then
				var_76_4.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_73_1.time_ - 0) / var_76_5)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				var_76_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			local var_76_6 = arg_73_1.actors_["10014ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10014ui_story == nil then
				arg_73_1.var_.characterEffect10014ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_7 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 and not isNil(var_76_6) then
				if arg_73_1.var_.characterEffect10014ui_story and not isNil(var_76_6) then
					arg_73_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_7)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10014ui_story then
				arg_73_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_76_8 = 0
			local var_76_9 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(411201018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 19 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 19)

				if (19 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 19)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201018", "story_v_out_411201.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201018", "story_v_out_411201.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_411201", "411201018", "story_v_out_411201.awb")

						arg_73_1:RecordAudio("411201018", var_76_15)
						arg_73_1:RecordAudio("411201018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_411201", "411201018", "story_v_out_411201.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_411201", "411201018", "story_v_out_411201.awb")
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
				actorName = "1024ui_story",
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

		arg_73_1:InitPlayNodeList()
	end,
	Play411201019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 411201019
		arg_77_1.duration_ = 4.07

		local var_77_0 = {
			zh = 4.066,
			ja = 2.9
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
				arg_77_0:Play411201020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1024ui_story"]) and arg_77_1.var_.characterEffect1024ui_story == nil then
				arg_77_1.var_.characterEffect1024ui_story = arg_77_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1024ui_story"]) then
				if arg_77_1.var_.characterEffect1024ui_story and not isNil(arg_77_1.actors_["1024ui_story"]) then
					arg_77_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1024ui_story"]) and arg_77_1.var_.characterEffect1024ui_story then
				arg_77_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_80_1 = arg_77_1.actors_["10014ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10014ui_story == nil then
				arg_77_1.var_.characterEffect10014ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10014ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10014ui_story then
				arg_77_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_80_4 = 0
			local var_80_5 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(411201019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 16 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 16)

				if (16 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 16)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201019", "story_v_out_411201.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201019", "story_v_out_411201.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_411201", "411201019", "story_v_out_411201.awb")

						arg_77_1:RecordAudio("411201019", var_80_11)
						arg_77_1:RecordAudio("411201019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_411201", "411201019", "story_v_out_411201.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_411201", "411201019", "story_v_out_411201.awb")
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

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play411201020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 411201020
		arg_81_1.duration_ = 5.33

		local var_81_0 = {
			zh = 3,
			ja = 5.333
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
				arg_81_0:Play411201021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1024ui_story"]) and arg_81_1.var_.characterEffect1024ui_story == nil then
				arg_81_1.var_.characterEffect1024ui_story = arg_81_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1024ui_story"]) then
				if arg_81_1.var_.characterEffect1024ui_story and not isNil(arg_81_1.actors_["1024ui_story"]) then
					arg_81_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1024ui_story"]) and arg_81_1.var_.characterEffect1024ui_story then
				arg_81_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["10014ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10014ui_story == nil then
				arg_81_1.var_.characterEffect10014ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect10014ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10014ui_story then
				arg_81_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(411201020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 15 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 15)

				if (15 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 15)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201020", "story_v_out_411201.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201020", "story_v_out_411201.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_411201", "411201020", "story_v_out_411201.awb")

						arg_81_1:RecordAudio("411201020", var_84_11)
						arg_81_1:RecordAudio("411201020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_411201", "411201020", "story_v_out_411201.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_411201", "411201020", "story_v_out_411201.awb")
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
	Play411201021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 411201021
		arg_85_1.duration_ = 6.77

		local var_85_0 = {
			zh = 5.466,
			ja = 6.766
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
				arg_85_0:Play411201022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1024ui_story"]) and arg_85_1.var_.characterEffect1024ui_story == nil then
				arg_85_1.var_.characterEffect1024ui_story = arg_85_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1024ui_story"]) then
				if arg_85_1.var_.characterEffect1024ui_story and not isNil(arg_85_1.actors_["1024ui_story"]) then
					arg_85_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1024ui_story"]) and arg_85_1.var_.characterEffect1024ui_story then
				arg_85_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["10014ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10014ui_story == nil then
				arg_85_1.var_.characterEffect10014ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10014ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10014ui_story then
				arg_85_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(411201021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 19 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 19)

				if (19 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 19)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201021", "story_v_out_411201.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201021", "story_v_out_411201.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_411201", "411201021", "story_v_out_411201.awb")

						arg_85_1:RecordAudio("411201021", var_88_11)
						arg_85_1:RecordAudio("411201021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_411201", "411201021", "story_v_out_411201.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_411201", "411201021", "story_v_out_411201.awb")
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
	Play411201022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 411201022
		arg_89_1.duration_ = 2.07

		local var_89_0 = {
			zh = 1.6,
			ja = 2.066
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
				arg_89_0:Play411201023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1024ui_story"]) and arg_89_1.var_.characterEffect1024ui_story == nil then
				arg_89_1.var_.characterEffect1024ui_story = arg_89_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1024ui_story"]) then
				if arg_89_1.var_.characterEffect1024ui_story and not isNil(arg_89_1.actors_["1024ui_story"]) then
					arg_89_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1024ui_story"]) and arg_89_1.var_.characterEffect1024ui_story then
				arg_89_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["10014ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10014ui_story == nil then
				arg_89_1.var_.characterEffect10014ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect10014ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10014ui_story then
				arg_89_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(411201022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)

				if (9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201022", "story_v_out_411201.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201022", "story_v_out_411201.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_411201", "411201022", "story_v_out_411201.awb")

						arg_89_1:RecordAudio("411201022", var_92_11)
						arg_89_1:RecordAudio("411201022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_411201", "411201022", "story_v_out_411201.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_411201", "411201022", "story_v_out_411201.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play411201023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411201023
		arg_93_1.duration_ = 5.53

		local var_93_0 = {
			zh = 4.533,
			ja = 5.533
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
				arg_93_0:Play411201024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1024ui_story"]) and arg_93_1.var_.characterEffect1024ui_story == nil then
				arg_93_1.var_.characterEffect1024ui_story = arg_93_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1024ui_story"]) then
				if arg_93_1.var_.characterEffect1024ui_story and not isNil(arg_93_1.actors_["1024ui_story"]) then
					arg_93_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1024ui_story"]) and arg_93_1.var_.characterEffect1024ui_story then
				arg_93_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_96_1 = arg_93_1.actors_["10014ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10014ui_story == nil then
				arg_93_1.var_.characterEffect10014ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10014ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10014ui_story then
				arg_93_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			local var_96_4 = 0
			local var_96_5 = 0.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(411201023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 19 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 19)

				if (19 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 19)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201023", "story_v_out_411201.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201023", "story_v_out_411201.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_411201", "411201023", "story_v_out_411201.awb")

						arg_93_1:RecordAudio("411201023", var_96_11)
						arg_93_1:RecordAudio("411201023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_411201", "411201023", "story_v_out_411201.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_411201", "411201023", "story_v_out_411201.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play411201024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411201024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411201025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1024ui_story = arg_97_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).z)
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles = arg_97_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1024ui_story"].transform.position).z)
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1024ui_story"].transform.localEulerAngles = arg_97_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1024ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1024ui_story == nil then
				arg_97_1.var_.characterEffect1024ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1024ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_2)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1024ui_story then
				arg_97_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_100_3 = arg_97_1.actors_["10014ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10014ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, 100, 0)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["10014ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect10014ui_story == nil then
				arg_97_1.var_.characterEffect10014ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect10014ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_6)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect10014ui_story then
				arg_97_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_100_7 = arg_97_1.actors_["1024ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				if arg_97_1.var_.characterEffect1024ui_story == nil then
					arg_97_1.var_.characterEffect1024ui_story = var_100_7:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_97_1.var_.characterEffect1024ui_story.imageEffect:turnOff()
			end

			if arg_97_1.time_ >= 0 + 2 and arg_97_1.time_ < 0 + 2 + arg_100_0 then
				if arg_97_1.var_.characterEffect1024ui_story == nil then
					arg_97_1.var_.characterEffect1024ui_story = var_100_7:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_97_1.var_.characterEffect1024ui_story.imageEffect:turnOn(false)
			end

			local var_100_8 = 0
			local var_100_9 = 0.9

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(411201024).content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 36 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 36)

				if (36 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 36)) > 0 and var_100_9 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_13 and arg_97_1.time_ < var_100_8 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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

		arg_97_1:InitPlayNodeList()
	end,
	Play411201025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411201025
		arg_101_1.duration_ = 1.67

		local var_101_0 = {
			zh = 1.033,
			ja = 1.666
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
				arg_101_0:Play411201026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = arg_101_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).z)
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles = arg_101_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_101_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).z)
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles = arg_101_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1095ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
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

				local var_104_6 = arg_101_1:GetWordFromCfg(411201025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 4 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 4)

				if (4 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 4)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201025", "story_v_out_411201.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201025", "story_v_out_411201.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_411201", "411201025", "story_v_out_411201.awb")

						arg_101_1:RecordAudio("411201025", var_104_11)
						arg_101_1:RecordAudio("411201025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_411201", "411201025", "story_v_out_411201.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_411201", "411201025", "story_v_out_411201.awb")
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
				actorName = "1095ui_story",
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
	Play411201026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411201026
		arg_105_1.duration_ = 5.13

		local var_105_0 = {
			zh = 2.966,
			ja = 5.133
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
				arg_105_0:Play411201027(arg_105_1)
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

			local var_108_1 = 0
			local var_108_2 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(411201026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 16 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 16)

				if (16 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 16)) > 0 and var_108_2 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201026", "story_v_out_411201.awb") ~= 0 then
					local var_108_7 = manager.audio:GetVoiceLength("story_v_out_411201", "411201026", "story_v_out_411201.awb") / 1000

					if var_108_7 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_1
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_411201", "411201026", "story_v_out_411201.awb")

						arg_105_1:RecordAudio("411201026", var_108_8)
						arg_105_1:RecordAudio("411201026", var_108_8)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_411201", "411201026", "story_v_out_411201.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_411201", "411201026", "story_v_out_411201.awb")
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

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play411201027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411201027
		arg_109_1.duration_ = 5.57

		local var_109_0 = {
			zh = 2.6,
			ja = 5.566
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
				arg_109_0:Play411201028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = arg_109_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(arg_109_1.actors_["1095ui_story"]) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_112_2 = 0
			local var_112_3 = 0.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
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

				local var_112_4 = arg_109_1:GetWordFromCfg(411201027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 17 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 17)

				if (17 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 17)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201027", "story_v_out_411201.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_411201", "411201027", "story_v_out_411201.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_411201", "411201027", "story_v_out_411201.awb")

						arg_109_1:RecordAudio("411201027", var_112_9)
						arg_109_1:RecordAudio("411201027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_411201", "411201027", "story_v_out_411201.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_411201", "411201027", "story_v_out_411201.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play411201028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411201028
		arg_113_1.duration_ = 5.67

		local var_113_0 = {
			zh = 4.166,
			ja = 5.666
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
				arg_113_0:Play411201029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.625

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(411201028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 25 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 25)

				if (25 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 25)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201028", "story_v_out_411201.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201028", "story_v_out_411201.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_411201", "411201028", "story_v_out_411201.awb")

						arg_113_1:RecordAudio("411201028", var_116_6)
						arg_113_1:RecordAudio("411201028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_411201", "411201028", "story_v_out_411201.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_411201", "411201028", "story_v_out_411201.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play411201029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411201029
		arg_117_1.duration_ = 4.67

		local var_117_0 = {
			zh = 4.666,
			ja = 3.3
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
				arg_117_0:Play411201030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.675

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
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

				local var_120_1 = arg_117_1:GetWordFromCfg(411201029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 27 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 27)

				if (27 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 27)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201029", "story_v_out_411201.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201029", "story_v_out_411201.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_411201", "411201029", "story_v_out_411201.awb")

						arg_117_1:RecordAudio("411201029", var_120_6)
						arg_117_1:RecordAudio("411201029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_411201", "411201029", "story_v_out_411201.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_411201", "411201029", "story_v_out_411201.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411201030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411201030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411201031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = arg_121_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1095ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_124_3 = 0
			local var_124_4 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(411201030).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 40 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 40)

				if (40 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 40)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play411201031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411201031
		arg_125_1.duration_ = 2.27

		local var_125_0 = {
			zh = 1.9,
			ja = 2.266
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
				arg_125_0:Play411201032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(411201031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 10 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 10)

				if (10 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 10)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201031", "story_v_out_411201.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201031", "story_v_out_411201.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_411201", "411201031", "story_v_out_411201.awb")

						arg_125_1:RecordAudio("411201031", var_128_6)
						arg_125_1:RecordAudio("411201031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_411201", "411201031", "story_v_out_411201.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_411201", "411201031", "story_v_out_411201.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play411201032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 411201032
		arg_129_1.duration_ = 6.3

		local var_129_0 = {
			zh = 6.3,
			ja = 5.2
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
				arg_129_0:Play411201033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1095ui_story = arg_129_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).z)
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles = arg_129_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_129_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).z)
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles = arg_129_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1095ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1095ui_story == nil then
				arg_129_1.var_.characterEffect1095ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1095ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1095ui_story then
				arg_129_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.775

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(411201032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 31 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 31)

				if (31 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 31)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201032", "story_v_out_411201.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201032", "story_v_out_411201.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_411201", "411201032", "story_v_out_411201.awb")

						arg_129_1:RecordAudio("411201032", var_132_11)
						arg_129_1:RecordAudio("411201032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_411201", "411201032", "story_v_out_411201.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_411201", "411201032", "story_v_out_411201.awb")
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

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play411201033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 411201033
		arg_133_1.duration_ = 7.23

		local var_133_0 = {
			zh = 7.233,
			ja = 6.9
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
				arg_133_0:Play411201034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.775

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
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

				local var_136_1 = arg_133_1:GetWordFromCfg(411201033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 31 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 31)

				if (31 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 31)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201033", "story_v_out_411201.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201033", "story_v_out_411201.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_411201", "411201033", "story_v_out_411201.awb")

						arg_133_1:RecordAudio("411201033", var_136_6)
						arg_133_1:RecordAudio("411201033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_411201", "411201033", "story_v_out_411201.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_411201", "411201033", "story_v_out_411201.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play411201034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 411201034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play411201035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1095ui_story = arg_137_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).z)
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles = arg_137_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1095ui_story"].transform.position).z)
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1095ui_story"].transform.localEulerAngles = arg_137_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1095ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1095ui_story == nil then
				arg_137_1.var_.characterEffect1095ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1095ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1095ui_story then
				arg_137_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_140_3 = 0
			local var_140_4 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(411201034).content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 33 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 33)

				if (33 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 33)) > 0 and var_140_4 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_3
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_4, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_3) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_8 and arg_137_1.time_ < var_140_3 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play411201035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 411201035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play411201036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.85

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

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(411201035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)

				if (34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)) > 0 and var_144_0 < var_144_3 then
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
	Play411201036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 411201036
		arg_145_1.duration_ = 9

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play411201037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.ST75 == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")
				var_148_0.name = "ST75"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.ST75 = var_148_0
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.ST75

				arg_145_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "ST75" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_4 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_5 = 2

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_5 then
				local var_148_6 = Color.New(0, 0, 0)

				var_148_6.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_4) / var_148_5)
				arg_145_1.mask_.color = var_148_6
			end

			if arg_145_1.time_ >= var_148_4 + var_148_5 and arg_145_1.time_ < var_148_4 + var_148_5 + arg_148_0 then
				local var_148_7 = Color.New(0, 0, 0)

				var_148_7.a = 1
				arg_145_1.mask_.color = var_148_7
			end

			local var_148_8 = 2

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 then
				local var_148_10 = Color.New(0, 0, 0)

				var_148_10.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_8) / var_148_9)
				arg_145_1.mask_.color = var_148_10
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 then
				local var_148_11 = Color.New(0, 0, 0)

				arg_145_1.mask_.enabled = false
				var_148_11.a = 0
				arg_145_1.mask_.color = var_148_11
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_12 = 4
			local var_148_13 = 1.25

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_14 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_14:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(411201036).content)

				arg_145_1.text_.text = var_148_15

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 50 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 50)

				if (50 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 50)) > 0 and var_148_13 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17
					var_148_12 = var_148_12 + 0.3

					if var_148_17 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_15
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = var_148_12 + 0.3
			local var_148_19 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_19 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_18) / var_148_19

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_18 + var_148_19 and arg_145_1.time_ < var_148_18 + var_148_19 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play411201037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411201037
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411201038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1024ui_story = arg_151_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).z)
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles = arg_151_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_151_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1024ui_story"].transform.position).z)
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1024ui_story"].transform.localEulerAngles = arg_151_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1024ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1024ui_story == nil then
				arg_151_1.var_.characterEffect1024ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1024ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1024ui_story then
				arg_151_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				if arg_151_1.var_.characterEffect1024ui_story == nil then
					arg_151_1.var_.characterEffect1024ui_story = arg_151_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_151_1.var_.characterEffect1024ui_story.imageEffect:turnOff()
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				if arg_151_1.var_.characterEffect1024ui_story == nil then
					arg_151_1.var_.characterEffect1024ui_story = arg_151_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_154_5 = arg_151_1.var_.characterEffect1024ui_story

				arg_151_1.var_.characterEffect1024ui_story.imageEffect:turnOff()

				var_154_5.interferenceEffect.enabled = false
				var_154_5.interferenceEffect.noise = 0.01
				var_154_5.interferenceEffect.simTimeScale = 1
				var_154_5.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_154_6 = 0
			local var_154_7 = 0.175

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(411201037)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 7 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 7)

				if (7 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 7)) > 0 and var_154_7 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201037", "story_v_out_411201.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_411201", "411201037", "story_v_out_411201.awb") / 1000

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_411201", "411201037", "story_v_out_411201.awb")

						arg_151_1:RecordAudio("411201037", var_154_13)
						arg_151_1:RecordAudio("411201037", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411201", "411201037", "story_v_out_411201.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411201", "411201037", "story_v_out_411201.awb")
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
				actorName = "1024ui_story",
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
	Play411201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411201038
		arg_155_1.duration_ = 3.27

		local var_155_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_155_0:Play411201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1024ui_story = arg_155_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).z)
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles = arg_155_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_155_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1024ui_story"].transform.position).z)
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1024ui_story"].transform.localEulerAngles = arg_155_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1024ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1024ui_story == nil then
				arg_155_1.var_.characterEffect1024ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1024ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_2)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1024ui_story then
				arg_155_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_158_3 = "4010ui_story"

			if arg_155_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_158_4 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_155_1.stage_.transform)

				var_158_4.name = var_158_3
				var_158_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_[var_158_3] = var_158_4

				local var_158_5 = var_158_4:GetComponentInChildren(typeof(CharacterEffect))

				var_158_5.enabled = true

				local var_158_6 = GameObjectTools.GetOrAddComponent(var_158_4, typeof(DynamicBoneHelper))

				if var_158_6 then
					var_158_6:EnableDynamicBone(false)
				end

				arg_155_1:ShowWeapon(var_158_5.transform, false)

				arg_155_1.var_[var_158_3 .. "Animator"] = var_158_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_155_1.var_[var_158_3 .. "Animator"].applyRootMotion = true
				arg_155_1.var_[var_158_3 .. "LipSync"] = var_158_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_158_7 = arg_155_1.actors_["4010ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos4010ui_story = var_158_7.localPosition
			end

			local var_158_8 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_8 then
				var_158_7.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_155_1.time_ - 0) / var_158_8)
				var_158_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_7.position).x, (manager.ui.mainCamera.transform.position - var_158_7.position).y, (manager.ui.mainCamera.transform.position - var_158_7.position).z)
				var_158_7.localEulerAngles.z = 0
				var_158_7.localEulerAngles.x = 0
				var_158_7.localEulerAngles = var_158_7.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_8 and arg_155_1.time_ < 0 + var_158_8 + arg_158_0 then
				var_158_7.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_158_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_7.position).x, (manager.ui.mainCamera.transform.position - var_158_7.position).y, (manager.ui.mainCamera.transform.position - var_158_7.position).z)
				var_158_7.localEulerAngles.z = 0
				var_158_7.localEulerAngles.x = 0
				var_158_7.localEulerAngles = var_158_7.localEulerAngles
			end

			local var_158_9 = arg_155_1.actors_["4010ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect4010ui_story == nil then
				arg_155_1.var_.characterEffect4010ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_10 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_10 and not isNil(var_158_9) then
				if arg_155_1.var_.characterEffect4010ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_10 and arg_155_1.time_ < 0 + var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect4010ui_story then
				arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_12 = 0
			local var_158_13 = 0.125

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_14 = arg_155_1:GetWordFromCfg(411201038)
				local var_158_15 = arg_155_1:FormatText(var_158_14.content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 5 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 5)

				if (5 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 5)) > 0 and var_158_13 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201038", "story_v_out_411201.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_411201", "411201038", "story_v_out_411201.awb") / 1000

					if var_158_18 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_12
					end

					if var_158_14.prefab_name ~= "" and arg_155_1.actors_[var_158_14.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_14.prefab_name].transform, "story_v_out_411201", "411201038", "story_v_out_411201.awb")

						arg_155_1:RecordAudio("411201038", var_158_19)
						arg_155_1:RecordAudio("411201038", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411201", "411201038", "story_v_out_411201.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411201", "411201038", "story_v_out_411201.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_20 and arg_155_1.time_ < var_158_12 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411201039
		arg_159_1.duration_ = 2.3

		local var_159_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_159_0:Play411201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1024ui_story"]) and arg_159_1.var_.characterEffect1024ui_story == nil then
				arg_159_1.var_.characterEffect1024ui_story = arg_159_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1024ui_story"]) then
				if arg_159_1.var_.characterEffect1024ui_story and not isNil(arg_159_1.actors_["1024ui_story"]) then
					arg_159_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1024ui_story"]) and arg_159_1.var_.characterEffect1024ui_story then
				arg_159_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_2 = arg_159_1.actors_["4010ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect4010ui_story == nil then
				arg_159_1.var_.characterEffect4010ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.characterEffect4010ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_159_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_3)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect4010ui_story then
				arg_159_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_159_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_162_4 = 0
			local var_162_5 = 0.1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(411201039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 4 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 4)

				if (4 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 4)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201039", "story_v_out_411201.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201039", "story_v_out_411201.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_411201", "411201039", "story_v_out_411201.awb")

						arg_159_1:RecordAudio("411201039", var_162_11)
						arg_159_1:RecordAudio("411201039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411201", "411201039", "story_v_out_411201.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411201", "411201039", "story_v_out_411201.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411201040
		arg_163_1.duration_ = 4.7

		local var_163_0 = {
			zh = 4.266,
			ja = 4.7
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
				arg_163_0:Play411201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1024ui_story"]) and arg_163_1.var_.characterEffect1024ui_story == nil then
				arg_163_1.var_.characterEffect1024ui_story = arg_163_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1024ui_story"]) then
				if arg_163_1.var_.characterEffect1024ui_story and not isNil(arg_163_1.actors_["1024ui_story"]) then
					arg_163_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1024ui_story"]) and arg_163_1.var_.characterEffect1024ui_story then
				arg_163_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_166_1 = arg_163_1.actors_["4010ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4010ui_story == nil then
				arg_163_1.var_.characterEffect4010ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect4010ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4010ui_story then
				arg_163_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_166_4 = 0
			local var_166_5 = 0.325

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(411201040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 13 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 13)

				if (13 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 13)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201040", "story_v_out_411201.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201040", "story_v_out_411201.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_411201", "411201040", "story_v_out_411201.awb")

						arg_163_1:RecordAudio("411201040", var_166_11)
						arg_163_1:RecordAudio("411201040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411201", "411201040", "story_v_out_411201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411201", "411201040", "story_v_out_411201.awb")
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

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411201041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411201041
		arg_167_1.duration_ = 3.47

		local var_167_0 = {
			zh = 3.466,
			ja = 3.133
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
				arg_167_0:Play411201042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["4010ui_story"]) and arg_167_1.var_.characterEffect4010ui_story == nil then
				arg_167_1.var_.characterEffect4010ui_story = arg_167_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["4010ui_story"]) then
				if arg_167_1.var_.characterEffect4010ui_story and not isNil(arg_167_1.actors_["4010ui_story"]) then
					arg_167_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_167_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["4010ui_story"]) and arg_167_1.var_.characterEffect4010ui_story then
				arg_167_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_167_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_170_1 = arg_167_1.actors_["1024ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1024ui_story == nil then
				arg_167_1.var_.characterEffect1024ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1024ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1024ui_story then
				arg_167_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(411201041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 19 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 19)

				if (19 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 19)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201041", "story_v_out_411201.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201041", "story_v_out_411201.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_411201", "411201041", "story_v_out_411201.awb")

						arg_167_1:RecordAudio("411201041", var_170_11)
						arg_167_1:RecordAudio("411201041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411201", "411201041", "story_v_out_411201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411201", "411201041", "story_v_out_411201.awb")
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
	Play411201042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411201042
		arg_171_1.duration_ = 7.53

		local var_171_0 = {
			zh = 5.033,
			ja = 7.533
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
				arg_171_0:Play411201043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(411201042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)

				if (24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201042", "story_v_out_411201.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201042", "story_v_out_411201.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_411201", "411201042", "story_v_out_411201.awb")

						arg_171_1:RecordAudio("411201042", var_174_6)
						arg_171_1:RecordAudio("411201042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411201", "411201042", "story_v_out_411201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411201", "411201042", "story_v_out_411201.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play411201043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411201043
		arg_175_1.duration_ = 10.17

		local var_175_0 = {
			zh = 6.366,
			ja = 10.166
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
				arg_175_0:Play411201044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.825

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(411201043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 33 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 33)

				if (33 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 33)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201043", "story_v_out_411201.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201043", "story_v_out_411201.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_411201", "411201043", "story_v_out_411201.awb")

						arg_175_1:RecordAudio("411201043", var_178_6)
						arg_175_1:RecordAudio("411201043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411201", "411201043", "story_v_out_411201.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411201", "411201043", "story_v_out_411201.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play411201044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411201044
		arg_179_1.duration_ = 2.67

		local var_179_0 = {
			zh = 2.433,
			ja = 2.666
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
				arg_179_0:Play411201045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(411201044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 13 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 13)

				if (13 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 13)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201044", "story_v_out_411201.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201044", "story_v_out_411201.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_411201", "411201044", "story_v_out_411201.awb")

						arg_179_1:RecordAudio("411201044", var_182_6)
						arg_179_1:RecordAudio("411201044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411201", "411201044", "story_v_out_411201.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411201", "411201044", "story_v_out_411201.awb")
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
	Play411201045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411201045
		arg_183_1.duration_ = 3.2

		local var_183_0 = {
			zh = 3.2,
			ja = 2.3
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
				arg_183_0:Play411201046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1024ui_story"]) and arg_183_1.var_.characterEffect1024ui_story == nil then
				arg_183_1.var_.characterEffect1024ui_story = arg_183_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1024ui_story"]) then
				if arg_183_1.var_.characterEffect1024ui_story and not isNil(arg_183_1.actors_["1024ui_story"]) then
					arg_183_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1024ui_story"]) and arg_183_1.var_.characterEffect1024ui_story then
				arg_183_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_186_1 = arg_183_1.actors_["4010ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect4010ui_story == nil then
				arg_183_1.var_.characterEffect4010ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect4010ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect4010ui_story then
				arg_183_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(411201045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 11 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 11)

				if (11 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 11)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201045", "story_v_out_411201.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201045", "story_v_out_411201.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_411201", "411201045", "story_v_out_411201.awb")

						arg_183_1:RecordAudio("411201045", var_186_11)
						arg_183_1:RecordAudio("411201045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411201", "411201045", "story_v_out_411201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411201", "411201045", "story_v_out_411201.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play411201046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411201046
		arg_187_1.duration_ = 6.83

		local var_187_0 = {
			zh = 6.833,
			ja = 2.6
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
				arg_187_0:Play411201047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.625

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(411201046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 25 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 25)

				if (25 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 25)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201046", "story_v_out_411201.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201046", "story_v_out_411201.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_411201", "411201046", "story_v_out_411201.awb")

						arg_187_1:RecordAudio("411201046", var_190_6)
						arg_187_1:RecordAudio("411201046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411201", "411201046", "story_v_out_411201.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411201", "411201046", "story_v_out_411201.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411201047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411201047
		arg_191_1.duration_ = 5.17

		local var_191_0 = {
			zh = 5.166,
			ja = 3.433
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
				arg_191_0:Play411201048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.35

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(411201047)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 14 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 14)

				if (14 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 14)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201047", "story_v_out_411201.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201047", "story_v_out_411201.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_411201", "411201047", "story_v_out_411201.awb")

						arg_191_1:RecordAudio("411201047", var_194_6)
						arg_191_1:RecordAudio("411201047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411201", "411201047", "story_v_out_411201.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411201", "411201047", "story_v_out_411201.awb")
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
	Play411201048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411201048
		arg_195_1.duration_ = 2.43

		local var_195_0 = {
			zh = 2.433,
			ja = 2
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
				arg_195_0:Play411201049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.2

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(411201048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 8 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 8)

				if (8 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 8)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201048", "story_v_out_411201.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201048", "story_v_out_411201.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_411201", "411201048", "story_v_out_411201.awb")

						arg_195_1:RecordAudio("411201048", var_198_6)
						arg_195_1:RecordAudio("411201048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411201", "411201048", "story_v_out_411201.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411201", "411201048", "story_v_out_411201.awb")
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
	Play411201049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411201049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411201050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["4010ui_story"]) and arg_199_1.var_.characterEffect4010ui_story == nil then
				arg_199_1.var_.characterEffect4010ui_story = arg_199_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["4010ui_story"]) then
				if arg_199_1.var_.characterEffect4010ui_story and not isNil(arg_199_1.actors_["4010ui_story"]) then
					arg_199_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_199_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["4010ui_story"]) and arg_199_1.var_.characterEffect4010ui_story then
				arg_199_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_199_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.825

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(411201049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 33 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 33)

				if (33 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 33)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play411201050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411201050
		arg_203_1.duration_ = 8.73

		local var_203_0 = {
			zh = 8.733,
			ja = 3.533
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411201051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["4010ui_story"]) and arg_203_1.var_.characterEffect4010ui_story == nil then
				arg_203_1.var_.characterEffect4010ui_story = arg_203_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["4010ui_story"]) then
				if arg_203_1.var_.characterEffect4010ui_story and not isNil(arg_203_1.actors_["4010ui_story"]) then
					arg_203_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["4010ui_story"]) and arg_203_1.var_.characterEffect4010ui_story then
				arg_203_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_2 = 0
			local var_206_3 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(411201050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 32 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 32)

				if (32 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 32)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201050", "story_v_out_411201.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_411201", "411201050", "story_v_out_411201.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_411201", "411201050", "story_v_out_411201.awb")

						arg_203_1:RecordAudio("411201050", var_206_9)
						arg_203_1:RecordAudio("411201050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_411201", "411201050", "story_v_out_411201.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_411201", "411201050", "story_v_out_411201.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play411201051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411201051
		arg_207_1.duration_ = 8.3

		local var_207_0 = {
			zh = 8.3,
			ja = 6.6
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play411201052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_210_0 = 0
			local var_210_1 = 0.725

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(411201051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 29 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 29)

				if (29 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 29)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201051", "story_v_out_411201.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_out_411201", "411201051", "story_v_out_411201.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_out_411201", "411201051", "story_v_out_411201.awb")

						arg_207_1:RecordAudio("411201051", var_210_7)
						arg_207_1:RecordAudio("411201051", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_411201", "411201051", "story_v_out_411201.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_411201", "411201051", "story_v_out_411201.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play411201052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411201052
		arg_211_1.duration_ = 2.7

		local var_211_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411201053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1024ui_story"]) and arg_211_1.var_.characterEffect1024ui_story == nil then
				arg_211_1.var_.characterEffect1024ui_story = arg_211_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1024ui_story"]) then
				if arg_211_1.var_.characterEffect1024ui_story and not isNil(arg_211_1.actors_["1024ui_story"]) then
					arg_211_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1024ui_story"]) and arg_211_1.var_.characterEffect1024ui_story then
				arg_211_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_2 = arg_211_1.actors_["4010ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect4010ui_story == nil then
				arg_211_1.var_.characterEffect4010ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect4010ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_211_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect4010ui_story then
				arg_211_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_211_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_214_4 = 0
			local var_214_5 = 0.225

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(411201052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 9 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 9)

				if (9 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 9)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201052", "story_v_out_411201.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201052", "story_v_out_411201.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_411201", "411201052", "story_v_out_411201.awb")

						arg_211_1:RecordAudio("411201052", var_214_11)
						arg_211_1:RecordAudio("411201052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411201", "411201052", "story_v_out_411201.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411201", "411201052", "story_v_out_411201.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play411201053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411201053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411201054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1024ui_story = arg_215_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).z)
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles = arg_215_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1024ui_story"].transform.position).z)
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1024ui_story"].transform.localEulerAngles = arg_215_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1024ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1024ui_story == nil then
				arg_215_1.var_.characterEffect1024ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1024ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_2)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1024ui_story then
				arg_215_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_218_3 = arg_215_1.actors_["4010ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos4010ui_story = var_218_3.localPosition
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_3.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_4)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_3.localPosition = Vector3.New(0, 100, 0)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_218_5 = 0
			local var_218_6 = 1.4

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(411201053).content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 56 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 56)

				if (56 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 56)) > 0 and var_218_6 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_10 and arg_215_1.time_ < var_218_5 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play411201054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411201054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411201055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(411201054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 40 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 40)

				if (40 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 40)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play411201055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411201055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411201056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.7

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(411201055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)

				if (28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play411201056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411201056
		arg_227_1.duration_ = 12.7

		local var_227_0 = {
			zh = 11.5,
			ja = 12.7
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
				arg_227_0:Play411201057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos4010ui_story = arg_227_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).z)
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles = arg_227_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_227_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4010ui_story"].transform.position).z)
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["4010ui_story"].transform.localEulerAngles = arg_227_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["4010ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect4010ui_story == nil then
				arg_227_1.var_.characterEffect4010ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect4010ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect4010ui_story then
				arg_227_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_230_4 = 0
			local var_230_5 = 1.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(411201056)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 45 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 45)

				if (45 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 45)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201056", "story_v_out_411201.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201056", "story_v_out_411201.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_411201", "411201056", "story_v_out_411201.awb")

						arg_227_1:RecordAudio("411201056", var_230_11)
						arg_227_1:RecordAudio("411201056", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411201", "411201056", "story_v_out_411201.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411201", "411201056", "story_v_out_411201.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play411201057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411201057
		arg_231_1.duration_ = 7.2

		local var_231_0 = {
			zh = 7.033,
			ja = 7.2
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
				arg_231_0:Play411201058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos4010ui_story = arg_231_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).z)
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles = arg_231_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0.7, -1.59, -5.2)
				arg_231_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["4010ui_story"].transform.position).z)
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["4010ui_story"].transform.localEulerAngles = arg_231_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["4010ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect4010ui_story == nil then
				arg_231_1.var_.characterEffect4010ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect4010ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_231_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_2)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect4010ui_story then
				arg_231_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_231_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_234_3 = arg_231_1.actors_["1024ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1024ui_story = var_234_3.localPosition
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_3.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_231_1.time_ - 0) / var_234_4)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = Vector3.New(-0.7, -1, -6.05)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			local var_234_5 = arg_231_1.actors_["1024ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1024ui_story == nil then
				arg_231_1.var_.characterEffect1024ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect1024ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1024ui_story then
				arg_231_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_234_8 = arg_231_1.actors_["4010ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect4010ui_story == nil then
				arg_231_1.var_.characterEffect4010ui_story = var_234_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_9 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_9 and not isNil(var_234_8) then
				if arg_231_1.var_.characterEffect4010ui_story and not isNil(var_234_8) then
					arg_231_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_231_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_9)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_9 and arg_231_1.time_ < 0 + var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect4010ui_story then
				arg_231_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_231_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_234_10 = 0
			local var_234_11 = 0.875

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_12 = arg_231_1:GetWordFromCfg(411201057)
				local var_234_13 = arg_231_1:FormatText(var_234_12.content)

				arg_231_1.text_.text = var_234_13

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 35 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 35)

				if (35 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 35)) > 0 and var_234_11 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_13
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201057", "story_v_out_411201.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_out_411201", "411201057", "story_v_out_411201.awb") / 1000

					if var_234_16 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_10
					end

					if var_234_12.prefab_name ~= "" and arg_231_1.actors_[var_234_12.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_12.prefab_name].transform, "story_v_out_411201", "411201057", "story_v_out_411201.awb")

						arg_231_1:RecordAudio("411201057", var_234_17)
						arg_231_1:RecordAudio("411201057", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411201", "411201057", "story_v_out_411201.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411201", "411201057", "story_v_out_411201.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_10) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_10 + var_234_18 and arg_231_1.time_ < var_234_10 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411201058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411201058
		arg_235_1.duration_ = 4.1

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 4.1
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
				arg_235_0:Play411201059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1024ui_story"]) and arg_235_1.var_.characterEffect1024ui_story == nil then
				arg_235_1.var_.characterEffect1024ui_story = arg_235_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1024ui_story"]) then
				if arg_235_1.var_.characterEffect1024ui_story and not isNil(arg_235_1.actors_["1024ui_story"]) then
					arg_235_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1024ui_story"]) and arg_235_1.var_.characterEffect1024ui_story then
				arg_235_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_238_1 = arg_235_1.actors_["4010ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect4010ui_story == nil then
				arg_235_1.var_.characterEffect4010ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect4010ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect4010ui_story then
				arg_235_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_238_4 = 0
			local var_238_5 = 0.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(411201058)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 6 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 6)

				if (6 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 6)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201058", "story_v_out_411201.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201058", "story_v_out_411201.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_411201", "411201058", "story_v_out_411201.awb")

						arg_235_1:RecordAudio("411201058", var_238_11)
						arg_235_1:RecordAudio("411201058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411201", "411201058", "story_v_out_411201.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411201", "411201058", "story_v_out_411201.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play411201059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411201059
		arg_239_1.duration_ = 6.97

		local var_239_0 = {
			zh = 6.966,
			ja = 6.233
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
				arg_239_0:Play411201060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.55

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(411201059)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 22 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 22)

				if (22 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 22)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201059", "story_v_out_411201.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201059", "story_v_out_411201.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_411201", "411201059", "story_v_out_411201.awb")

						arg_239_1:RecordAudio("411201059", var_242_6)
						arg_239_1:RecordAudio("411201059", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411201", "411201059", "story_v_out_411201.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411201", "411201059", "story_v_out_411201.awb")
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
	Play411201060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411201060
		arg_243_1.duration_ = 6.23

		local var_243_0 = {
			zh = 6.233,
			ja = 5.633
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
				arg_243_0:Play411201061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_246_0 = 0
			local var_246_1 = 0.7

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(411201060)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 28 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 28)

				if (28 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 28)) > 0 and var_246_1 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201060", "story_v_out_411201.awb") ~= 0 then
					local var_246_6 = manager.audio:GetVoiceLength("story_v_out_411201", "411201060", "story_v_out_411201.awb") / 1000

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end

					if var_246_2.prefab_name ~= "" and arg_243_1.actors_[var_246_2.prefab_name] ~= nil then
						local var_246_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_2.prefab_name].transform, "story_v_out_411201", "411201060", "story_v_out_411201.awb")

						arg_243_1:RecordAudio("411201060", var_246_7)
						arg_243_1:RecordAudio("411201060", var_246_7)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411201", "411201060", "story_v_out_411201.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411201", "411201060", "story_v_out_411201.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play411201061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411201061
		arg_247_1.duration_ = 7.5

		local var_247_0 = {
			zh = 7.466,
			ja = 7.5
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
				arg_247_0:Play411201062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.85

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(411201061)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 34 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 34)

				if (34 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 34)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201061", "story_v_out_411201.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201061", "story_v_out_411201.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_411201", "411201061", "story_v_out_411201.awb")

						arg_247_1:RecordAudio("411201061", var_250_6)
						arg_247_1:RecordAudio("411201061", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411201", "411201061", "story_v_out_411201.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411201", "411201061", "story_v_out_411201.awb")
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
	Play411201062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411201062
		arg_251_1.duration_ = 12.37

		local var_251_0 = {
			zh = 12.366,
			ja = 7.966
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
				arg_251_0:Play411201063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.275

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(411201062)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 51 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 51)

				if (51 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 51)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201062", "story_v_out_411201.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201062", "story_v_out_411201.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_411201", "411201062", "story_v_out_411201.awb")

						arg_251_1:RecordAudio("411201062", var_254_6)
						arg_251_1:RecordAudio("411201062", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411201", "411201062", "story_v_out_411201.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411201", "411201062", "story_v_out_411201.awb")
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
	Play411201063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411201063
		arg_255_1.duration_ = 6.53

		local var_255_0 = {
			zh = 6.233,
			ja = 6.533
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
				arg_255_0:Play411201064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.625

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(411201063)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 25 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 25)

				if (25 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 25)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201063", "story_v_out_411201.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201063", "story_v_out_411201.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_411201", "411201063", "story_v_out_411201.awb")

						arg_255_1:RecordAudio("411201063", var_258_6)
						arg_255_1:RecordAudio("411201063", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411201", "411201063", "story_v_out_411201.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411201", "411201063", "story_v_out_411201.awb")
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
	Play411201064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411201064
		arg_259_1.duration_ = 9.2

		local var_259_0 = {
			zh = 9.2,
			ja = 8.566
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
				arg_259_0:Play411201065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.925

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(411201064)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 37 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 37)

				if (37 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 37)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201064", "story_v_out_411201.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201064", "story_v_out_411201.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_411201", "411201064", "story_v_out_411201.awb")

						arg_259_1:RecordAudio("411201064", var_262_6)
						arg_259_1:RecordAudio("411201064", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411201", "411201064", "story_v_out_411201.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411201", "411201064", "story_v_out_411201.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play411201065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411201065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411201066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos4010ui_story = arg_263_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).z)
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles = arg_263_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["4010ui_story"].transform.position).z)
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["4010ui_story"].transform.localEulerAngles = arg_263_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["4010ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect4010ui_story == nil then
				arg_263_1.var_.characterEffect4010ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect4010ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_263_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_2)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect4010ui_story then
				arg_263_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_263_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_266_3 = arg_263_1.actors_["1024ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1024ui_story = var_266_3.localPosition
			end

			local var_266_4 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				var_266_3.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_4)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_3.localPosition = Vector3.New(0, 100, 0)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			local var_266_5 = arg_263_1.actors_["1024ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1024ui_story == nil then
				arg_263_1.var_.characterEffect1024ui_story = var_266_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_6 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_6 and not isNil(var_266_5) then
				if arg_263_1.var_.characterEffect1024ui_story and not isNil(var_266_5) then
					arg_263_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_6)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_6 and arg_263_1.time_ < 0 + var_266_6 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1024ui_story then
				arg_263_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_266_7 = 0
			local var_266_8 = 1

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_9 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(411201065).content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 40 <= 0 and var_266_8 or var_266_8 * (utf8.len(var_266_9) / 40)

				if (40 <= 0 and var_266_8 or var_266_8 * (utf8.len(var_266_9) / 40)) > 0 and var_266_8 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_7 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_7
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_8, arg_263_1.talkMaxDuration)

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_7) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_7 + var_266_12 and arg_263_1.time_ < var_266_7 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play411201066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411201066
		arg_267_1.duration_ = 5.87

		local var_267_0 = {
			zh = 5.866,
			ja = 4.133
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
				arg_267_0:Play411201067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1024ui_story = arg_267_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).z)
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles = arg_267_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_267_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1024ui_story"].transform.position).z)
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1024ui_story"].transform.localEulerAngles = arg_267_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1024ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1024ui_story == nil then
				arg_267_1.var_.characterEffect1024ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1024ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1024ui_story then
				arg_267_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_270_4 = 0
			local var_270_5 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(411201066)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 32 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 32)

				if (32 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 32)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201066", "story_v_out_411201.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201066", "story_v_out_411201.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_out_411201", "411201066", "story_v_out_411201.awb")

						arg_267_1:RecordAudio("411201066", var_270_11)
						arg_267_1:RecordAudio("411201066", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411201", "411201066", "story_v_out_411201.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411201", "411201066", "story_v_out_411201.awb")
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
				actorName = "1024ui_story",
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
	Play411201067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411201067
		arg_271_1.duration_ = 8.9

		local var_271_0 = {
			zh = 7.766,
			ja = 8.9
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
				arg_271_0:Play411201068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.025

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(411201067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 41 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 41)

				if (41 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 41)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201067", "story_v_out_411201.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201067", "story_v_out_411201.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_411201", "411201067", "story_v_out_411201.awb")

						arg_271_1:RecordAudio("411201067", var_274_6)
						arg_271_1:RecordAudio("411201067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_411201", "411201067", "story_v_out_411201.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_411201", "411201067", "story_v_out_411201.awb")
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
	Play411201068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411201068
		arg_275_1.duration_ = 5.03

		local var_275_0 = {
			zh = 5.033,
			ja = 3.1
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
				arg_275_0:Play411201069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos4010ui_story = arg_275_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).z)
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles = arg_275_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0.7, -1.59, -5.2)
				arg_275_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).z)
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles = arg_275_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["4010ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect4010ui_story == nil then
				arg_275_1.var_.characterEffect4010ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect4010ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect4010ui_story then
				arg_275_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_278_4 = arg_275_1.actors_["1024ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1024ui_story = var_278_4.localPosition
			end

			local var_278_5 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 then
				var_278_4.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_275_1.time_ - 0) / var_278_5)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 then
				var_278_4.localPosition = Vector3.New(-0.7, -1, -6.05)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			local var_278_6 = arg_275_1.actors_["1024ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1024ui_story == nil then
				arg_275_1.var_.characterEffect1024ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_7 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 and not isNil(var_278_6) then
				if arg_275_1.var_.characterEffect1024ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_7)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1024ui_story then
				arg_275_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_8 = 0
			local var_278_9 = 0.475

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(411201068)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 19 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 19)

				if (19 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 19)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201068", "story_v_out_411201.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201068", "story_v_out_411201.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_411201", "411201068", "story_v_out_411201.awb")

						arg_275_1:RecordAudio("411201068", var_278_15)
						arg_275_1:RecordAudio("411201068", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411201", "411201068", "story_v_out_411201.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411201", "411201068", "story_v_out_411201.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play411201069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411201069
		arg_279_1.duration_ = 5.33

		local var_279_0 = {
			zh = 5.333,
			ja = 2.5
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411201070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["4010ui_story"]) and arg_279_1.var_.characterEffect4010ui_story == nil then
				arg_279_1.var_.characterEffect4010ui_story = arg_279_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["4010ui_story"]) then
				if arg_279_1.var_.characterEffect4010ui_story and not isNil(arg_279_1.actors_["4010ui_story"]) then
					arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["4010ui_story"]) and arg_279_1.var_.characterEffect4010ui_story then
				arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_282_1 = arg_279_1.actors_["1024ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1024ui_story == nil then
				arg_279_1.var_.characterEffect1024ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1024ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1024ui_story then
				arg_279_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_282_4 = 0
			local var_282_5 = 0.65

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(411201069)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 26 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 26)

				if (26 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 26)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201069", "story_v_out_411201.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201069", "story_v_out_411201.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_411201", "411201069", "story_v_out_411201.awb")

						arg_279_1:RecordAudio("411201069", var_282_11)
						arg_279_1:RecordAudio("411201069", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_411201", "411201069", "story_v_out_411201.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_411201", "411201069", "story_v_out_411201.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play411201070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 411201070
		arg_283_1.duration_ = 6.03

		local var_283_0 = {
			zh = 6.033,
			ja = 4.8
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play411201071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["4010ui_story"]) and arg_283_1.var_.characterEffect4010ui_story == nil then
				arg_283_1.var_.characterEffect4010ui_story = arg_283_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["4010ui_story"]) then
				if arg_283_1.var_.characterEffect4010ui_story and not isNil(arg_283_1.actors_["4010ui_story"]) then
					arg_283_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["4010ui_story"]) and arg_283_1.var_.characterEffect4010ui_story then
				arg_283_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_286_2 = arg_283_1.actors_["1024ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1024ui_story == nil then
				arg_283_1.var_.characterEffect1024ui_story = var_286_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.characterEffect1024ui_story and not isNil(var_286_2) then
					arg_283_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_3)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1024ui_story then
				arg_283_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.6

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(411201070)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 24 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 24)

				if (24 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 24)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201070", "story_v_out_411201.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201070", "story_v_out_411201.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_411201", "411201070", "story_v_out_411201.awb")

						arg_283_1:RecordAudio("411201070", var_286_11)
						arg_283_1:RecordAudio("411201070", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_411201", "411201070", "story_v_out_411201.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_411201", "411201070", "story_v_out_411201.awb")
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

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play411201071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 411201071
		arg_287_1.duration_ = 3.07

		local var_287_0 = {
			zh = 2.6,
			ja = 3.066
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play411201072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.2

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(411201071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 8 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 8)

				if (8 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 8)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201071", "story_v_out_411201.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201071", "story_v_out_411201.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_411201", "411201071", "story_v_out_411201.awb")

						arg_287_1:RecordAudio("411201071", var_290_6)
						arg_287_1:RecordAudio("411201071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_411201", "411201071", "story_v_out_411201.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_411201", "411201071", "story_v_out_411201.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play411201072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 411201072
		arg_291_1.duration_ = 2.57

		local var_291_0 = {
			zh = 2.166,
			ja = 2.566
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play411201073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["4010ui_story"]) and arg_291_1.var_.characterEffect4010ui_story == nil then
				arg_291_1.var_.characterEffect4010ui_story = arg_291_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["4010ui_story"]) then
				if arg_291_1.var_.characterEffect4010ui_story and not isNil(arg_291_1.actors_["4010ui_story"]) then
					arg_291_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_291_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["4010ui_story"]) and arg_291_1.var_.characterEffect4010ui_story then
				arg_291_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_291_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_294_1 = arg_291_1.actors_["1024ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1024ui_story == nil then
				arg_291_1.var_.characterEffect1024ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1024ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1024ui_story then
				arg_291_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_1")
			end

			local var_294_4 = 0
			local var_294_5 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(411201072)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 12 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 12)

				if (12 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 12)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201072", "story_v_out_411201.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201072", "story_v_out_411201.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_out_411201", "411201072", "story_v_out_411201.awb")

						arg_291_1:RecordAudio("411201072", var_294_11)
						arg_291_1:RecordAudio("411201072", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_411201", "411201072", "story_v_out_411201.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_411201", "411201072", "story_v_out_411201.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play411201073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 411201073
		arg_295_1.duration_ = 6.37

		local var_295_0 = {
			zh = 6.366,
			ja = 4.3
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
				arg_295_0:Play411201074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["4010ui_story"]) and arg_295_1.var_.characterEffect4010ui_story == nil then
				arg_295_1.var_.characterEffect4010ui_story = arg_295_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["4010ui_story"]) then
				if arg_295_1.var_.characterEffect4010ui_story and not isNil(arg_295_1.actors_["4010ui_story"]) then
					arg_295_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["4010ui_story"]) and arg_295_1.var_.characterEffect4010ui_story then
				arg_295_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_298_2 = arg_295_1.actors_["1024ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect1024ui_story == nil then
				arg_295_1.var_.characterEffect1024ui_story = var_298_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_3 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.characterEffect1024ui_story and not isNil(var_298_2) then
					arg_295_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_3)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect1024ui_story then
				arg_295_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_298_4 = 0
			local var_298_5 = 0.375

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(411201073)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 15 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 15)

				if (15 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 15)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201073", "story_v_out_411201.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201073", "story_v_out_411201.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_411201", "411201073", "story_v_out_411201.awb")

						arg_295_1:RecordAudio("411201073", var_298_11)
						arg_295_1:RecordAudio("411201073", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_411201", "411201073", "story_v_out_411201.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_411201", "411201073", "story_v_out_411201.awb")
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

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play411201074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 411201074
		arg_299_1.duration_ = 7.4

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play411201075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.bgs_.B10b == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10b")
				var_302_0.name = "B10b"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.B10b = var_302_0
			end

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.B10b

				arg_299_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "B10b" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_4 = 0

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_5 = 0.866666666666668

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_5 then
				local var_302_6 = Color.New(1, 0.9669811, 0.9669811)

				var_302_6.a = Mathf.Lerp(0, 1, (arg_299_1.time_ - var_302_4) / var_302_5)
				arg_299_1.mask_.color = var_302_6
			end

			if arg_299_1.time_ >= var_302_4 + var_302_5 and arg_299_1.time_ < var_302_4 + var_302_5 + arg_302_0 then
				local var_302_7 = Color.New(1, 0.9669811, 0.9669811)

				var_302_7.a = 1
				arg_299_1.mask_.color = var_302_7
			end

			local var_302_8 = 0.866666666666668

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_9 = 1.53333333333333

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 then
				local var_302_10 = Color.New(1, 1, 1)

				var_302_10.a = Mathf.Lerp(1, 0, (arg_299_1.time_ - var_302_8) / var_302_9)
				arg_299_1.mask_.color = var_302_10
			end

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 then
				local var_302_11 = Color.New(1, 1, 1)

				arg_299_1.mask_.enabled = false
				var_302_11.a = 0
				arg_299_1.mask_.color = var_302_11
			end

			local var_302_12 = arg_299_1.actors_["4010ui_story"].transform

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 then
				arg_299_1.var_.moveOldPos4010ui_story = var_302_12.localPosition
			end

			local var_302_13 = 0.001

			if 0.866666666666668 <= arg_299_1.time_ and arg_299_1.time_ < 0.866666666666668 + var_302_13 then
				var_302_12.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0.866666666666668) / var_302_13)
				var_302_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_12.position).x, (manager.ui.mainCamera.transform.position - var_302_12.position).y, (manager.ui.mainCamera.transform.position - var_302_12.position).z)
				var_302_12.localEulerAngles.z = 0
				var_302_12.localEulerAngles.x = 0
				var_302_12.localEulerAngles = var_302_12.localEulerAngles
			end

			if arg_299_1.time_ >= 0.866666666666668 + var_302_13 and arg_299_1.time_ < 0.866666666666668 + var_302_13 + arg_302_0 then
				var_302_12.localPosition = Vector3.New(0, 100, 0)
				var_302_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_12.position).x, (manager.ui.mainCamera.transform.position - var_302_12.position).y, (manager.ui.mainCamera.transform.position - var_302_12.position).z)
				var_302_12.localEulerAngles.z = 0
				var_302_12.localEulerAngles.x = 0
				var_302_12.localEulerAngles = var_302_12.localEulerAngles
			end

			local var_302_14 = arg_299_1.actors_["4010ui_story"]

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 and not isNil(var_302_14) and arg_299_1.var_.characterEffect4010ui_story == nil then
				arg_299_1.var_.characterEffect4010ui_story = var_302_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_15 = 0.200000002980232

			if 0.866666666666668 <= arg_299_1.time_ and arg_299_1.time_ < 0.866666666666668 + var_302_15 and not isNil(var_302_14) then
				if arg_299_1.var_.characterEffect4010ui_story and not isNil(var_302_14) then
					arg_299_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_299_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0.866666666666668) / var_302_15)
				end
			end

			if arg_299_1.time_ >= 0.866666666666668 + var_302_15 and arg_299_1.time_ < 0.866666666666668 + var_302_15 + arg_302_0 and not isNil(var_302_14) and arg_299_1.var_.characterEffect4010ui_story then
				arg_299_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_299_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_302_16 = arg_299_1.actors_["1024ui_story"].transform

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 then
				arg_299_1.var_.moveOldPos1024ui_story = var_302_16.localPosition
			end

			local var_302_17 = 0.001

			if 0.866666666666668 <= arg_299_1.time_ and arg_299_1.time_ < 0.866666666666668 + var_302_17 then
				var_302_16.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0.866666666666668) / var_302_17)
				var_302_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_16.position).x, (manager.ui.mainCamera.transform.position - var_302_16.position).y, (manager.ui.mainCamera.transform.position - var_302_16.position).z)
				var_302_16.localEulerAngles.z = 0
				var_302_16.localEulerAngles.x = 0
				var_302_16.localEulerAngles = var_302_16.localEulerAngles
			end

			if arg_299_1.time_ >= 0.866666666666668 + var_302_17 and arg_299_1.time_ < 0.866666666666668 + var_302_17 + arg_302_0 then
				var_302_16.localPosition = Vector3.New(0, 100, 0)
				var_302_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_16.position).x, (manager.ui.mainCamera.transform.position - var_302_16.position).y, (manager.ui.mainCamera.transform.position - var_302_16.position).z)
				var_302_16.localEulerAngles.z = 0
				var_302_16.localEulerAngles.x = 0
				var_302_16.localEulerAngles = var_302_16.localEulerAngles
			end

			local var_302_18 = arg_299_1.actors_["1024ui_story"]

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 and not isNil(var_302_18) and arg_299_1.var_.characterEffect1024ui_story == nil then
				arg_299_1.var_.characterEffect1024ui_story = var_302_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_19 = 0.200000002980232

			if 0.866666666666668 <= arg_299_1.time_ and arg_299_1.time_ < 0.866666666666668 + var_302_19 and not isNil(var_302_18) then
				if arg_299_1.var_.characterEffect1024ui_story and not isNil(var_302_18) then
					arg_299_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0.866666666666668) / var_302_19)
				end
			end

			if arg_299_1.time_ >= 0.866666666666668 + var_302_19 and arg_299_1.time_ < 0.866666666666668 + var_302_19 + arg_302_0 and not isNil(var_302_18) and arg_299_1.var_.characterEffect1024ui_story then
				arg_299_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0.866666666666668 < arg_299_1.time_ and arg_299_1.time_ <= 0.866666666666668 + arg_302_0 then
				arg_299_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_smoke", "")
			end

			local var_302_21 = manager.ui.mainCamera.transform

			if 1.16666666666667 < arg_299_1.time_ and arg_299_1.time_ <= 1.16666666666667 + arg_302_0 then
				arg_299_1.var_.shakeOldPos = var_302_21.localPosition
			end

			local var_302_22 = 1.23333333333333

			if 1.16666666666667 <= arg_299_1.time_ and arg_299_1.time_ < 1.16666666666667 + var_302_22 then
				local var_302_23, var_302_24 = math.modf((arg_299_1.time_ - 1.16666666666667) / 0.066)

				var_302_21.localPosition = Vector3.New(var_302_24 * 0.13, var_302_24 * 0.13, var_302_24 * 0.13) + arg_299_1.var_.shakeOldPos
			end

			if arg_299_1.time_ >= 1.16666666666667 + var_302_22 and arg_299_1.time_ < 1.16666666666667 + var_302_22 + arg_302_0 then
				var_302_21.localPosition = arg_299_1.var_.shakeOldPos
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_25 = 2.4
			local var_302_26 = 1.15

			if 2.4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_25 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_27 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_27:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_28 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(411201074).content)

				arg_299_1.text_.text = var_302_28

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_30 = 46 <= 0 and var_302_26 or var_302_26 * (utf8.len(var_302_28) / 46)

				if (46 <= 0 and var_302_26 or var_302_26 * (utf8.len(var_302_28) / 46)) > 0 and var_302_26 < var_302_30 then
					arg_299_1.talkMaxDuration = var_302_30
					var_302_25 = var_302_25 + 0.3

					if var_302_30 + var_302_25 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_30 + var_302_25
					end
				end

				arg_299_1.text_.text = var_302_28
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_31 = var_302_25 + 0.3
			local var_302_32 = math.max(var_302_26, arg_299_1.talkMaxDuration)

			if var_302_25 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_31 + var_302_32 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_31) / var_302_32

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_31 + var_302_32 and arg_299_1.time_ < var_302_31 + var_302_32 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.866666666666668,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.866666666666668,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play411201075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 411201075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play411201076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.175

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(411201075).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 47 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 47)

				if (47 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 47)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play411201076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 411201076
		arg_309_1.duration_ = 2.83

		local var_309_0 = {
			zh = 1.6,
			ja = 2.833
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
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play411201077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if arg_309_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_312_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_309_1.stage_.transform)

				var_312_0.name = "2079ui_story"
				var_312_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.actors_["2079ui_story"] = var_312_0

				local var_312_1 = var_312_0:GetComponentInChildren(typeof(CharacterEffect))

				var_312_1.enabled = true

				local var_312_2 = GameObjectTools.GetOrAddComponent(var_312_0, typeof(DynamicBoneHelper))

				if var_312_2 then
					var_312_2:EnableDynamicBone(false)
				end

				arg_309_1:ShowWeapon(var_312_1.transform, false)

				arg_309_1.var_["2079ui_story" .. "Animator"] = var_312_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_309_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_309_1.var_["2079ui_story" .. "LipSync"] = var_312_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_312_3 = arg_309_1.actors_["2079ui_story"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos2079ui_story = var_312_3.localPosition
			end

			local var_312_4 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				var_312_3.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_309_1.time_ - 0) / var_312_4)
				var_312_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_3.position).x, (manager.ui.mainCamera.transform.position - var_312_3.position).y, (manager.ui.mainCamera.transform.position - var_312_3.position).z)
				var_312_3.localEulerAngles.z = 0
				var_312_3.localEulerAngles.x = 0
				var_312_3.localEulerAngles = var_312_3.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				var_312_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_312_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_3.position).x, (manager.ui.mainCamera.transform.position - var_312_3.position).y, (manager.ui.mainCamera.transform.position - var_312_3.position).z)
				var_312_3.localEulerAngles.z = 0
				var_312_3.localEulerAngles.x = 0
				var_312_3.localEulerAngles = var_312_3.localEulerAngles
			end

			local var_312_5 = arg_309_1.actors_["2079ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.characterEffect2079ui_story == nil then
				arg_309_1.var_.characterEffect2079ui_story = var_312_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_6 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_6 and not isNil(var_312_5) then
				if arg_309_1.var_.characterEffect2079ui_story and not isNil(var_312_5) then
					arg_309_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_6 and arg_309_1.time_ < 0 + var_312_6 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.characterEffect2079ui_story then
				arg_309_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_312_8 = 0
			local var_312_9 = 0.225

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(411201076)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_13 = 9 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 9)

				if (9 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 9)) > 0 and var_312_9 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_8
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201076", "story_v_out_411201.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201076", "story_v_out_411201.awb") / 1000

					if var_312_14 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_8
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_411201", "411201076", "story_v_out_411201.awb")

						arg_309_1:RecordAudio("411201076", var_312_15)
						arg_309_1:RecordAudio("411201076", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_411201", "411201076", "story_v_out_411201.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_411201", "411201076", "story_v_out_411201.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_9, arg_309_1.talkMaxDuration)

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_8) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_8 + var_312_16 and arg_309_1.time_ < var_312_8 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play411201077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 411201077
		arg_313_1.duration_ = 2

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play411201078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos2079ui_story = arg_313_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).z)
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles = arg_313_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["2079ui_story"].transform.position).z)
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["2079ui_story"].transform.localEulerAngles = arg_313_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["2079ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect2079ui_story == nil then
				arg_313_1.var_.characterEffect2079ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect2079ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_313_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_2)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect2079ui_story then
				arg_313_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_313_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_316_3 = arg_313_1.actors_["1024ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1024ui_story = var_316_3.localPosition

				arg_313_1:ShowWeapon(arg_313_1.var_["1024ui_story" .. "Animator"].transform, true)
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_3.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_313_1.time_ - 0) / var_316_4)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_3.localPosition = Vector3.New(0, -1, -6.05)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			local var_316_5 = arg_313_1.actors_["1024ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1024ui_story == nil then
				arg_313_1.var_.characterEffect1024ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1024ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1024ui_story then
				arg_313_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action7_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_316_8 = 0
			local var_316_9 = 0.1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(411201077)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 4 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 4)

				if (4 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 4)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201077", "story_v_out_411201.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201077", "story_v_out_411201.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_411201", "411201077", "story_v_out_411201.awb")

						arg_313_1:RecordAudio("411201077", var_316_15)
						arg_313_1:RecordAudio("411201077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_411201", "411201077", "story_v_out_411201.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_411201", "411201077", "story_v_out_411201.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play411201078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 411201078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play411201079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1024ui_story = arg_317_1.actors_["1024ui_story"].transform.localPosition

				arg_317_1:ShowWeapon(arg_317_1.var_["1024ui_story" .. "Animator"].transform, false)
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).z)
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles = arg_317_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1024ui_story"].transform.position).z)
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1024ui_story"].transform.localEulerAngles = arg_317_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1024ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1024ui_story == nil then
				arg_317_1.var_.characterEffect1024ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1024ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1024ui_story then
				arg_317_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_320_3 = 0
			local var_320_4 = 1.575

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(411201078).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 63 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 63)

				if (63 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 63)) > 0 and var_320_4 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_8 and arg_317_1.time_ < var_320_3 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play411201079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 411201079
		arg_321_1.duration_ = 9

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play411201080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 2 < arg_321_1.time_ and arg_321_1.time_ <= 2 + arg_324_0 then
				local var_324_0 = arg_321_1.bgs_.B10b

				arg_321_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_324_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_1 = var_324_0:GetComponent("SpriteRenderer")

				if var_324_1 and var_324_1.sprite then
					local var_324_2 = 2 * (var_324_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_324_0.transform.localScale = Vector3.New(var_324_2 / var_324_1.sprite.bounds.size.y < var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x and var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x or var_324_2 / var_324_1.sprite.bounds.size.y, var_324_2 / var_324_1.sprite.bounds.size.y < var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x and var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x or var_324_2 / var_324_1.sprite.bounds.size.y, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "B10b" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_3 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_4 = 2

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_4 then
				local var_324_5 = Color.New(0, 0, 0)

				var_324_5.a = Mathf.Lerp(0, 1, (arg_321_1.time_ - var_324_3) / var_324_4)
				arg_321_1.mask_.color = var_324_5
			end

			if arg_321_1.time_ >= var_324_3 + var_324_4 and arg_321_1.time_ < var_324_3 + var_324_4 + arg_324_0 then
				local var_324_6 = Color.New(0, 0, 0)

				var_324_6.a = 1
				arg_321_1.mask_.color = var_324_6
			end

			local var_324_7 = 2

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_8 = 2

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_8 then
				local var_324_9 = Color.New(0, 0, 0)

				var_324_9.a = Mathf.Lerp(1, 0, (arg_321_1.time_ - var_324_7) / var_324_8)
				arg_321_1.mask_.color = var_324_9
			end

			if arg_321_1.time_ >= var_324_7 + var_324_8 and arg_321_1.time_ < var_324_7 + var_324_8 + arg_324_0 then
				local var_324_10 = Color.New(0, 0, 0)

				arg_321_1.mask_.enabled = false
				var_324_10.a = 0
				arg_321_1.mask_.color = var_324_10
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_11 = 4
			local var_324_12 = 0.875

			if 4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_13 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_13:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_14 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(411201079).content)

				arg_321_1.text_.text = var_324_14

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_16 = 35 <= 0 and var_324_12 or var_324_12 * (utf8.len(var_324_14) / 35)

				if (35 <= 0 and var_324_12 or var_324_12 * (utf8.len(var_324_14) / 35)) > 0 and var_324_12 < var_324_16 then
					arg_321_1.talkMaxDuration = var_324_16
					var_324_11 = var_324_11 + 0.3

					if var_324_16 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_16 + var_324_11
					end
				end

				arg_321_1.text_.text = var_324_14
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_17 = var_324_11 + 0.3
			local var_324_18 = math.max(var_324_12, arg_321_1.talkMaxDuration)

			if var_324_11 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_17 + var_324_18 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_17) / var_324_18

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_17 + var_324_18 and arg_321_1.time_ < var_324_17 + var_324_18 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play411201080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 411201080
		arg_327_1.duration_ = 5.5

		local var_327_0 = {
			zh = 5.5,
			ja = 5.033
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play411201081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos4010ui_story = arg_327_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).z)
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles = arg_327_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_327_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4010ui_story"].transform.position).z)
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["4010ui_story"].transform.localEulerAngles = arg_327_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["4010ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect4010ui_story == nil then
				arg_327_1.var_.characterEffect4010ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect4010ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect4010ui_story then
				arg_327_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_330_4 = 0
			local var_330_5 = 0.425

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(411201080)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 17 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 17)

				if (17 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 17)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201080", "story_v_out_411201.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201080", "story_v_out_411201.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_411201", "411201080", "story_v_out_411201.awb")

						arg_327_1:RecordAudio("411201080", var_330_11)
						arg_327_1:RecordAudio("411201080", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_411201", "411201080", "story_v_out_411201.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_411201", "411201080", "story_v_out_411201.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play411201081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 411201081
		arg_331_1.duration_ = 2

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play411201082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos4010ui_story = arg_331_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).z)
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles = arg_331_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["4010ui_story"].transform.position).z)
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["4010ui_story"].transform.localEulerAngles = arg_331_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["4010ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect4010ui_story == nil then
				arg_331_1.var_.characterEffect4010ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect4010ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_331_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_2)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect4010ui_story then
				arg_331_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_331_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_334_3 = arg_331_1.actors_["1024ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1024ui_story = var_334_3.localPosition
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_3.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_331_1.time_ - 0) / var_334_4)
				var_334_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_3.position).x, (manager.ui.mainCamera.transform.position - var_334_3.position).y, (manager.ui.mainCamera.transform.position - var_334_3.position).z)
				var_334_3.localEulerAngles.z = 0
				var_334_3.localEulerAngles.x = 0
				var_334_3.localEulerAngles = var_334_3.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_3.localPosition = Vector3.New(0, -1, -6.05)
				var_334_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_3.position).x, (manager.ui.mainCamera.transform.position - var_334_3.position).y, (manager.ui.mainCamera.transform.position - var_334_3.position).z)
				var_334_3.localEulerAngles.z = 0
				var_334_3.localEulerAngles.x = 0
				var_334_3.localEulerAngles = var_334_3.localEulerAngles
			end

			local var_334_5 = arg_331_1.actors_["1024ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.characterEffect1024ui_story == nil then
				arg_331_1.var_.characterEffect1024ui_story = var_334_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_6 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.characterEffect1024ui_story and not isNil(var_334_5) then
					arg_331_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.characterEffect1024ui_story then
				arg_331_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_334_8 = 0
			local var_334_9 = 0.175

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(411201081)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 7 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 7)

				if (7 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 7)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201081", "story_v_out_411201.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_411201", "411201081", "story_v_out_411201.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_411201", "411201081", "story_v_out_411201.awb")

						arg_331_1:RecordAudio("411201081", var_334_15)
						arg_331_1:RecordAudio("411201081", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_411201", "411201081", "story_v_out_411201.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_411201", "411201081", "story_v_out_411201.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_16 and arg_331_1.time_ < var_334_8 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play411201082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 411201082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play411201083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1024ui_story"]) and arg_335_1.var_.characterEffect1024ui_story == nil then
				arg_335_1.var_.characterEffect1024ui_story = arg_335_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1024ui_story"]) then
				if arg_335_1.var_.characterEffect1024ui_story and not isNil(arg_335_1.actors_["1024ui_story"]) then
					arg_335_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1024ui_story"]) and arg_335_1.var_.characterEffect1024ui_story then
				arg_335_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_338_1 = arg_335_1.actors_["1024ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1024ui_story = var_338_1.localPosition
			end

			local var_338_2 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 then
				var_338_1.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_2)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 then
				var_338_1.localPosition = Vector3.New(0, 100, 0)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			local var_338_3 = 0
			local var_338_4 = 1.1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_3 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_5 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(411201082).content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 44 <= 0 and var_338_4 or var_338_4 * (utf8.len(var_338_5) / 44)

				if (44 <= 0 and var_338_4 or var_338_4 * (utf8.len(var_338_5) / 44)) > 0 and var_338_4 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_3 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_3
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_4, arg_335_1.talkMaxDuration)

			if var_338_3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_3 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_3) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_3 + var_338_8 and arg_335_1.time_ < var_338_3 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411201083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411201083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play411201084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.8

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(411201083).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 32)

				if (32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 32)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play411201084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411201084
		arg_343_1.duration_ = 1.3

		local var_343_0 = {
			zh = 1.2,
			ja = 1.3
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411201085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1024ui_story = arg_343_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).z)
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles = arg_343_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1024ui_story"].transform.position).z)
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1024ui_story"].transform.localEulerAngles = arg_343_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["1024ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1024ui_story == nil then
				arg_343_1.var_.characterEffect1024ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect1024ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_2)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1024ui_story then
				arg_343_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_346_3 = 0
			local var_346_4 = 0.1

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_3 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_5 = arg_343_1:GetWordFromCfg(411201084)
				local var_346_6 = arg_343_1:FormatText(var_346_5.content)

				arg_343_1.text_.text = var_346_6

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_8 = 4 <= 0 and var_346_4 or var_346_4 * (utf8.len(var_346_6) / 4)

				if (4 <= 0 and var_346_4 or var_346_4 * (utf8.len(var_346_6) / 4)) > 0 and var_346_4 < var_346_8 then
					arg_343_1.talkMaxDuration = var_346_8

					if var_346_8 + var_346_3 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_3
					end
				end

				arg_343_1.text_.text = var_346_6
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201084", "story_v_out_411201.awb") ~= 0 then
					local var_346_9 = manager.audio:GetVoiceLength("story_v_out_411201", "411201084", "story_v_out_411201.awb") / 1000

					if var_346_9 + var_346_3 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_3
					end

					if var_346_5.prefab_name ~= "" and arg_343_1.actors_[var_346_5.prefab_name] ~= nil then
						local var_346_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_5.prefab_name].transform, "story_v_out_411201", "411201084", "story_v_out_411201.awb")

						arg_343_1:RecordAudio("411201084", var_346_10)
						arg_343_1:RecordAudio("411201084", var_346_10)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_411201", "411201084", "story_v_out_411201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_411201", "411201084", "story_v_out_411201.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_11 = math.max(var_346_4, arg_343_1.talkMaxDuration)

			if var_346_3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_3 + var_346_11 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_3) / var_346_11

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_3 + var_346_11 and arg_343_1.time_ < var_346_3 + var_346_11 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play411201085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411201085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play411201086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if arg_347_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_350_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_347_1.stage_.transform)

				var_350_0.name = "3008ui_story"
				var_350_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.actors_["3008ui_story"] = var_350_0

				local var_350_1 = var_350_0:GetComponentInChildren(typeof(CharacterEffect))

				var_350_1.enabled = true

				local var_350_2 = GameObjectTools.GetOrAddComponent(var_350_0, typeof(DynamicBoneHelper))

				if var_350_2 then
					var_350_2:EnableDynamicBone(false)
				end

				arg_347_1:ShowWeapon(var_350_1.transform, false)

				arg_347_1.var_["3008ui_story" .. "Animator"] = var_350_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_347_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_347_1.var_["3008ui_story" .. "LipSync"] = var_350_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_350_3 = arg_347_1.actors_["3008ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos3008ui_story = var_350_3.localPosition
			end

			local var_350_4 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				var_350_3.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_347_1.time_ - 0) / var_350_4)
				var_350_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_3.position).x, (manager.ui.mainCamera.transform.position - var_350_3.position).y, (manager.ui.mainCamera.transform.position - var_350_3.position).z)
				var_350_3.localEulerAngles.z = 0
				var_350_3.localEulerAngles.x = 0
				var_350_3.localEulerAngles = var_350_3.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				var_350_3.localPosition = Vector3.New(0, 100, 0)
				var_350_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_3.position).x, (manager.ui.mainCamera.transform.position - var_350_3.position).y, (manager.ui.mainCamera.transform.position - var_350_3.position).z)
				var_350_3.localEulerAngles.z = 0
				var_350_3.localEulerAngles.x = 0
				var_350_3.localEulerAngles = var_350_3.localEulerAngles
			end

			local var_350_5 = arg_347_1.actors_["3008ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.characterEffect3008ui_story == nil then
				arg_347_1.var_.characterEffect3008ui_story = var_350_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_6 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_6 and not isNil(var_350_5) then
				if arg_347_1.var_.characterEffect3008ui_story and not isNil(var_350_5) then
					arg_347_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_347_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_6)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_6 and arg_347_1.time_ < 0 + var_350_6 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.characterEffect3008ui_story then
				arg_347_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_347_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_350_7 = 0
			local var_350_8 = 0.975

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_9 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(411201085).content)

				arg_347_1.text_.text = var_350_9

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 39 <= 0 and var_350_8 or var_350_8 * (utf8.len(var_350_9) / 39)

				if (39 <= 0 and var_350_8 or var_350_8 * (utf8.len(var_350_9) / 39)) > 0 and var_350_8 < var_350_11 then
					arg_347_1.talkMaxDuration = var_350_11

					if var_350_11 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_9
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_12 and arg_347_1.time_ < var_350_7 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play411201086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411201086
		arg_351_1.duration_ = 3.1

		local var_351_0 = {
			zh = 3.1,
			ja = 2.366
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411201087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.35

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:GetWordFromCfg(411201086)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 14 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 14)

				if (14 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 14)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201086", "story_v_out_411201.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201086", "story_v_out_411201.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_411201", "411201086", "story_v_out_411201.awb")

						arg_351_1:RecordAudio("411201086", var_354_6)
						arg_351_1:RecordAudio("411201086", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_411201", "411201086", "story_v_out_411201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_411201", "411201086", "story_v_out_411201.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play411201087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411201087
		arg_355_1.duration_ = 3.53

		local var_355_0 = {
			zh = 1.999999999999,
			ja = 3.533
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411201088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos4010ui_story = arg_355_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).z)
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles = arg_355_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_355_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["4010ui_story"].transform.position).z)
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["4010ui_story"].transform.localEulerAngles = arg_355_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["4010ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect4010ui_story == nil then
				arg_355_1.var_.characterEffect4010ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect4010ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect4010ui_story then
				arg_355_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_4 = 0
			local var_358_5 = 0.175

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(411201087)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 7 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 7)

				if (7 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 7)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201087", "story_v_out_411201.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201087", "story_v_out_411201.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_411201", "411201087", "story_v_out_411201.awb")

						arg_355_1:RecordAudio("411201087", var_358_11)
						arg_355_1:RecordAudio("411201087", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_411201", "411201087", "story_v_out_411201.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_411201", "411201087", "story_v_out_411201.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play411201088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411201088
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play411201089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["4010ui_story"]) and arg_359_1.var_.characterEffect4010ui_story == nil then
				arg_359_1.var_.characterEffect4010ui_story = arg_359_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["4010ui_story"]) then
				if arg_359_1.var_.characterEffect4010ui_story and not isNil(arg_359_1.actors_["4010ui_story"]) then
					arg_359_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_359_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["4010ui_story"]) and arg_359_1.var_.characterEffect4010ui_story then
				arg_359_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_359_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_362_1 = arg_359_1.actors_["3008ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect3008ui_story == nil then
				arg_359_1.var_.characterEffect3008ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect3008ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect3008ui_story then
				arg_359_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_362_4 = 0
			local var_362_5 = 0.225

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(411201088)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 9 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 9)

				if (9 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 9)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201088", "story_v_out_411201.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201088", "story_v_out_411201.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_411201", "411201088", "story_v_out_411201.awb")

						arg_359_1:RecordAudio("411201088", var_362_11)
						arg_359_1:RecordAudio("411201088", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_411201", "411201088", "story_v_out_411201.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_411201", "411201088", "story_v_out_411201.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play411201089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411201089
		arg_363_1.duration_ = 2.2

		local var_363_0 = {
			zh = 2,
			ja = 2.2
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play411201090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["3008ui_story"]) and arg_363_1.var_.characterEffect3008ui_story == nil then
				arg_363_1.var_.characterEffect3008ui_story = arg_363_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["3008ui_story"]) then
				if arg_363_1.var_.characterEffect3008ui_story and not isNil(arg_363_1.actors_["3008ui_story"]) then
					arg_363_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_363_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["3008ui_story"]) and arg_363_1.var_.characterEffect3008ui_story then
				arg_363_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_363_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_366_1 = arg_363_1.actors_["4010ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect4010ui_story == nil then
				arg_363_1.var_.characterEffect4010ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect4010ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect4010ui_story then
				arg_363_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_366_4 = 0
			local var_366_5 = 0.25

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(411201089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 10 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 10)

				if (10 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 10)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201089", "story_v_out_411201.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201089", "story_v_out_411201.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_411201", "411201089", "story_v_out_411201.awb")

						arg_363_1:RecordAudio("411201089", var_366_11)
						arg_363_1:RecordAudio("411201089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_411201", "411201089", "story_v_out_411201.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_411201", "411201089", "story_v_out_411201.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play411201090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411201090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play411201091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos3008ui_story = arg_367_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).z)
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles = arg_367_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["3008ui_story"].transform.position).z)
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["3008ui_story"].transform.localEulerAngles = arg_367_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["3008ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect3008ui_story == nil then
				arg_367_1.var_.characterEffect3008ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect3008ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_367_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_2)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect3008ui_story then
				arg_367_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_367_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_370_3 = arg_367_1.actors_["4010ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos4010ui_story = var_370_3.localPosition
			end

			local var_370_4 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_3.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_4)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_3.localPosition = Vector3.New(0, 100, 0)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			local var_370_5 = arg_367_1.actors_["4010ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect4010ui_story == nil then
				arg_367_1.var_.characterEffect4010ui_story = var_370_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_6 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_6 and not isNil(var_370_5) then
				if arg_367_1.var_.characterEffect4010ui_story and not isNil(var_370_5) then
					arg_367_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_367_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_6)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_6 and arg_367_1.time_ < 0 + var_370_6 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect4010ui_story then
				arg_367_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_367_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_370_7 = 0
			local var_370_8 = 1.125

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_7 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_9 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(411201090).content)

				arg_367_1.text_.text = var_370_9

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 45 <= 0 and var_370_8 or var_370_8 * (utf8.len(var_370_9) / 45)

				if (45 <= 0 and var_370_8 or var_370_8 * (utf8.len(var_370_9) / 45)) > 0 and var_370_8 < var_370_11 then
					arg_367_1.talkMaxDuration = var_370_11

					if var_370_11 + var_370_7 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_7
					end
				end

				arg_367_1.text_.text = var_370_9
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_8, arg_367_1.talkMaxDuration)

			if var_370_7 <= arg_367_1.time_ and arg_367_1.time_ < var_370_7 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_7) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_7 + var_370_12 and arg_367_1.time_ < var_370_7 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play411201091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411201091
		arg_371_1.duration_ = 4.17

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play411201092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.075

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[266].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:GetWordFromCfg(411201091)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 3 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 3)

				if (3 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 3)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201091", "story_v_out_411201.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_411201", "411201091", "story_v_out_411201.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_411201", "411201091", "story_v_out_411201.awb")

						arg_371_1:RecordAudio("411201091", var_374_6)
						arg_371_1:RecordAudio("411201091", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_411201", "411201091", "story_v_out_411201.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_411201", "411201091", "story_v_out_411201.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play411201092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 411201092
		arg_375_1.duration_ = 1.7

		local var_375_0 = {
			zh = 1.366,
			ja = 1.7
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play411201093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1024ui_story = arg_375_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).z)
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles = arg_375_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_375_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1024ui_story"].transform.position).z)
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1024ui_story"].transform.localEulerAngles = arg_375_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1024ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1024ui_story == nil then
				arg_375_1.var_.characterEffect1024ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1024ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1024ui_story then
				arg_375_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.175

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(411201092)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 7 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 7)

				if (7 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 7)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201092", "story_v_out_411201.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201092", "story_v_out_411201.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_411201", "411201092", "story_v_out_411201.awb")

						arg_375_1:RecordAudio("411201092", var_378_11)
						arg_375_1:RecordAudio("411201092", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_411201", "411201092", "story_v_out_411201.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_411201", "411201092", "story_v_out_411201.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play411201093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 411201093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play411201094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1024ui_story = arg_379_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).z)
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles = arg_379_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_379_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1024ui_story"].transform.position).z)
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1024ui_story"].transform.localEulerAngles = arg_379_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1024ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1024ui_story == nil then
				arg_379_1.var_.characterEffect1024ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1024ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_2)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1024ui_story then
				arg_379_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_382_3 = 0
			local var_382_4 = 0.875

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_5 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(411201093).content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 35 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_5) / 35)

				if (35 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_5) / 35)) > 0 and var_382_4 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_3
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_4, arg_379_1.talkMaxDuration)

			if var_382_3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_3 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_3) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_3 + var_382_8 and arg_379_1.time_ < var_382_3 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play411201094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411201094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411201095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.075

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(411201094).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 43)

				if (43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 43)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play411201095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411201095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play411201096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.55

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(411201095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 22 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 22)

				if (22 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 22)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play411201096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411201096
		arg_391_1.duration_ = 2.9

		local var_391_0 = {
			zh = 2.9,
			ja = 2.066
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
			arg_391_1.auto_ = false
		end

		function arg_391_1.playNext_(arg_393_0)
			arg_391_1.onStoryFinished_()
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1024ui_story = arg_391_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).z)
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles = arg_391_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_391_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1024ui_story"].transform.position).z)
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1024ui_story"].transform.localEulerAngles = arg_391_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1024ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1024ui_story == nil then
				arg_391_1.var_.characterEffect1024ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1024ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1024ui_story then
				arg_391_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_4 = 0
			local var_394_5 = 0.325

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_6 = arg_391_1:GetWordFromCfg(411201096)
				local var_394_7 = arg_391_1:FormatText(var_394_6.content)

				arg_391_1.text_.text = var_394_7

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_9 = 13 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 13)

				if (13 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 13)) > 0 and var_394_5 < var_394_9 then
					arg_391_1.talkMaxDuration = var_394_9

					if var_394_9 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_4
					end
				end

				arg_391_1.text_.text = var_394_7
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411201", "411201096", "story_v_out_411201.awb") ~= 0 then
					local var_394_10 = manager.audio:GetVoiceLength("story_v_out_411201", "411201096", "story_v_out_411201.awb") / 1000

					if var_394_10 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_4
					end

					if var_394_6.prefab_name ~= "" and arg_391_1.actors_[var_394_6.prefab_name] ~= nil then
						local var_394_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_6.prefab_name].transform, "story_v_out_411201", "411201096", "story_v_out_411201.awb")

						arg_391_1:RecordAudio("411201096", var_394_11)
						arg_391_1:RecordAudio("411201096", var_394_11)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_411201", "411201096", "story_v_out_411201.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_411201", "411201096", "story_v_out_411201.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_12 = math.max(var_394_5, arg_391_1.talkMaxDuration)

			if var_394_4 <= arg_391_1.time_ and arg_391_1.time_ < var_394_4 + var_394_12 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_4) / var_394_12

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_4 + var_394_12 and arg_391_1.time_ < var_394_4 + var_394_12 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/B10b"
	},
	voices = {
		"story_v_out_411201.awb"
	}
}
