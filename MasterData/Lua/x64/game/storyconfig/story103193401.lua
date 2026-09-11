return {
	Play319341001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319341001
		arg_1_1.duration_ = 5.5

		local var_1_0 = {
			zh = 5.133,
			ja = 5.5
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
				arg_1_0:Play319341002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11o == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_4_0.name = "I11o"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11o = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11o

				arg_1_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11o" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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
			local var_4_15 = 0.25

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(319341001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 10)

				if (10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 10)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341001", "story_v_out_319341.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_319341", "319341001", "story_v_out_319341.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_319341", "319341001", "story_v_out_319341.awb")

						arg_1_1:RecordAudio("319341001", var_4_22)
						arg_1_1:RecordAudio("319341001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319341", "319341001", "story_v_out_319341.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319341", "319341001", "story_v_out_319341.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319341002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319341002
		arg_9_1.duration_ = 4.17

		local var_9_0 = {
			zh = 2.4,
			ja = 4.166
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
				arg_9_0:Play319341003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1084ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1084ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1084ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1084ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_4 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 and not isNil(var_12_3) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_3) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_4)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_12_5 = 0
			local var_12_6 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_7 = arg_9_1:GetWordFromCfg(319341002)
				local var_12_8 = arg_9_1:FormatText(var_12_7.content)

				arg_9_1.text_.text = var_12_8

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 10 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_8) / 10)

				if (10 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_8) / 10)) > 0 and var_12_6 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_8
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341002", "story_v_out_319341.awb") ~= 0 then
					local var_12_11 = manager.audio:GetVoiceLength("story_v_out_319341", "319341002", "story_v_out_319341.awb") / 1000

					if var_12_11 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_5
					end

					if var_12_7.prefab_name ~= "" and arg_9_1.actors_[var_12_7.prefab_name] ~= nil then
						local var_12_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_7.prefab_name].transform, "story_v_out_319341", "319341002", "story_v_out_319341.awb")

						arg_9_1:RecordAudio("319341002", var_12_12)
						arg_9_1:RecordAudio("319341002", var_12_12)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319341", "319341002", "story_v_out_319341.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319341", "319341002", "story_v_out_319341.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_13 and arg_9_1.time_ < var_12_5 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319341003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319341003
		arg_13_1.duration_ = 14.2

		local var_13_0 = {
			zh = 8.4,
			ja = 14.2
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
				arg_13_0:Play319341004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.bgs_.I11r == nil then
				local var_16_0 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_16_0.name = "I11r"
				var_16_0.transform.parent = arg_13_1.stage_.transform
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_.I11r = var_16_0
			end

			if 1.43333333333333 < arg_13_1.time_ and arg_13_1.time_ <= 1.43333333333333 + arg_16_0 then
				local var_16_1 = arg_13_1.bgs_.I11r

				arg_13_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_16_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_2 = var_16_1:GetComponent("SpriteRenderer")

				if var_16_2 and var_16_2.sprite then
					local var_16_3 = 2 * (var_16_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_16_1.transform.localScale = Vector3.New(var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "I11r" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_4 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_5 = 1.43333333333333

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_5 then
				local var_16_6 = Color.New(0, 0, 0)

				var_16_6.a = Mathf.Lerp(0, 1, (arg_13_1.time_ - var_16_4) / var_16_5)
				arg_13_1.mask_.color = var_16_6
			end

			if arg_13_1.time_ >= var_16_4 + var_16_5 and arg_13_1.time_ < var_16_4 + var_16_5 + arg_16_0 then
				local var_16_7 = Color.New(0, 0, 0)

				var_16_7.a = 1
				arg_13_1.mask_.color = var_16_7
			end

			local var_16_8 = 1.43333333333333

			if 1.43333333333333 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_9 = 1.43333333333333

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 then
				local var_16_10 = Color.New(0, 0, 0)

				var_16_10.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_8) / var_16_9)
				arg_13_1.mask_.color = var_16_10
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 then
				local var_16_11 = Color.New(0, 0, 0)

				arg_13_1.mask_.enabled = false
				var_16_11.a = 0
				arg_13_1.mask_.color = var_16_11
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_12 = 2.6
			local var_16_13 = 0.775

			if 2.6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_14 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_14:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_15 = arg_13_1:GetWordFromCfg(319341003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_18 = 31 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_16) / 31)

				if (31 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_16) / 31)) > 0 and var_16_13 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18
					var_16_12 = var_16_12 + 0.3

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341003", "story_v_out_319341.awb") ~= 0 then
					local var_16_19 = manager.audio:GetVoiceLength("story_v_out_319341", "319341003", "story_v_out_319341.awb") / 1000

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_319341", "319341003", "story_v_out_319341.awb")

						arg_13_1:RecordAudio("319341003", var_16_20)
						arg_13_1:RecordAudio("319341003", var_16_20)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319341", "319341003", "story_v_out_319341.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319341", "319341003", "story_v_out_319341.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = var_16_12 + 0.3
			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319341004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 319341004
		arg_19_1.duration_ = 10.53

		local var_19_0 = {
			zh = 8.46666666666667,
			ja = 10.5326666666667
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
				arg_19_0:Play319341005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_0 = 1.43333333333333

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				local var_22_1 = Color.New(0, 0, 0)

				var_22_1.a = Mathf.Lerp(0, 1, (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.mask_.color = var_22_1
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				local var_22_2 = Color.New(0, 0, 0)

				var_22_2.a = 1
				arg_19_1.mask_.color = var_22_2
			end

			local var_22_3 = 1.43333333333333

			if 1.43333333333333 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_4 = 1.43333333333333

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_4 then
				local var_22_5 = Color.New(0, 0, 0)

				var_22_5.a = Mathf.Lerp(1, 0, (arg_19_1.time_ - var_22_3) / var_22_4)
				arg_19_1.mask_.color = var_22_5
			end

			if arg_19_1.time_ >= var_22_3 + var_22_4 and arg_19_1.time_ < var_22_3 + var_22_4 + arg_22_0 then
				local var_22_6 = Color.New(0, 0, 0)

				arg_19_1.mask_.enabled = false
				var_22_6.a = 0
				arg_19_1.mask_.color = var_22_6
			end

			local var_22_7 = "I11i"

			if arg_19_1.bgs_.I11i == nil then
				local var_22_8 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_22_7)
				var_22_8.name = var_22_7
				var_22_8.transform.parent = arg_19_1.stage_.transform
				var_22_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_[var_22_7] = var_22_8
			end

			if 1.43333333333333 < arg_19_1.time_ and arg_19_1.time_ <= 1.43333333333333 + arg_22_0 then
				local var_22_9 = arg_19_1.bgs_.I11i

				arg_19_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_22_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_10 = var_22_9:GetComponent("SpriteRenderer")

				if var_22_10 and var_22_10.sprite then
					local var_22_11 = 2 * (var_22_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_22_9.transform.localScale = Vector3.New(var_22_11 / var_22_10.sprite.bounds.size.y < var_22_11 * manager.ui.mainCameraCom_.aspect / var_22_10.sprite.bounds.size.x and var_22_11 * manager.ui.mainCameraCom_.aspect / var_22_10.sprite.bounds.size.x or var_22_11 / var_22_10.sprite.bounds.size.y, var_22_11 / var_22_10.sprite.bounds.size.y < var_22_11 * manager.ui.mainCameraCom_.aspect / var_22_10.sprite.bounds.size.x and var_22_11 * manager.ui.mainCameraCom_.aspect / var_22_10.sprite.bounds.size.x or var_22_11 / var_22_10.sprite.bounds.size.y, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "I11i" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_12 = 2.86666666666667
			local var_22_13 = 0.525

			if 2.86666666666667 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_14 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_14:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[701].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_15 = arg_19_1:GetWordFromCfg(319341004)
				local var_22_16 = arg_19_1:FormatText(var_22_15.content)

				arg_19_1.text_.text = var_22_16

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_18 = 21 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_16) / 21)

				if (21 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_16) / 21)) > 0 and var_22_13 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18
					var_22_12 = var_22_12 + 0.3

					if var_22_18 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_16
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341004", "story_v_out_319341.awb") ~= 0 then
					local var_22_19 = manager.audio:GetVoiceLength("story_v_out_319341", "319341004", "story_v_out_319341.awb") / 1000

					if var_22_19 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_12
					end

					if var_22_15.prefab_name ~= "" and arg_19_1.actors_[var_22_15.prefab_name] ~= nil then
						local var_22_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_15.prefab_name].transform, "story_v_out_319341", "319341004", "story_v_out_319341.awb")

						arg_19_1:RecordAudio("319341004", var_22_20)
						arg_19_1:RecordAudio("319341004", var_22_20)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_319341", "319341004", "story_v_out_319341.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_319341", "319341004", "story_v_out_319341.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = var_22_12 + 0.3
			local var_22_22 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_22 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_21) / var_22_22

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_21 + var_22_22 and arg_19_1.time_ < var_22_21 + var_22_22 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play319341005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319341005
		arg_25_1.duration_ = 7.57

		local var_25_0 = {
			zh = 5.533,
			ja = 7.566
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
				arg_25_0:Play319341006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = arg_25_1.actors_["1084ui_story"].transform.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_25_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1084ui_story"].transform.position).z)
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1084ui_story"].transform.localEulerAngles = arg_25_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1084ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.625

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(319341005)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 25 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 25)

				if (25 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 25)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341005", "story_v_out_319341.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341005", "story_v_out_319341.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319341", "319341005", "story_v_out_319341.awb")

						arg_25_1:RecordAudio("319341005", var_28_11)
						arg_25_1:RecordAudio("319341005", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319341", "319341005", "story_v_out_319341.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319341", "319341005", "story_v_out_319341.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
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
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play319341006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319341006
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319341007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = arg_29_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(arg_29_1.actors_["1084ui_story"]) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 1.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319341006).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 46 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 46)

				if (46 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 46)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319341007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319341007
		arg_33_1.duration_ = 8.83

		local var_33_0 = {
			zh = 5.133,
			ja = 8.833
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
				arg_33_0:Play319341008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[701].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(319341007)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 20 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 20)

				if (20 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 20)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341007", "story_v_out_319341.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341007", "story_v_out_319341.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_319341", "319341007", "story_v_out_319341.awb")

						arg_33_1:RecordAudio("319341007", var_36_6)
						arg_33_1:RecordAudio("319341007", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319341", "319341007", "story_v_out_319341.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319341", "319341007", "story_v_out_319341.awb")
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
	Play319341008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319341008
		arg_37_1.duration_ = 10.8

		local var_37_0 = {
			zh = 6.466,
			ja = 10.8
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
				arg_37_0:Play319341009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.75

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[701].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(319341008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 30 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 30)

				if (30 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 30)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341008", "story_v_out_319341.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341008", "story_v_out_319341.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_319341", "319341008", "story_v_out_319341.awb")

						arg_37_1:RecordAudio("319341008", var_40_6)
						arg_37_1:RecordAudio("319341008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319341", "319341008", "story_v_out_319341.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319341", "319341008", "story_v_out_319341.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319341009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319341009
		arg_41_1.duration_ = 7.87

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319341010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 1.39933333148559 < arg_41_1.time_ and arg_41_1.time_ <= 1.39933333148559 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = arg_41_1.actors_["1084ui_story"].transform.localPosition

				arg_41_1:ShowWeapon(arg_41_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_44_0 = 0.001

			if 1.39933333148559 <= arg_41_1.time_ and arg_41_1.time_ < 1.39933333148559 + var_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 1.39933333148559) / var_44_0)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 1.39933333148559 + var_44_0 and arg_41_1.time_ < 1.39933333148559 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_44_1 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_2 = 1.43333333333333

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = Color.New(0, 0, 0)

				var_44_3.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_1) / var_44_2)
				arg_41_1.mask_.color = var_44_3
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				local var_44_4 = Color.New(0, 0, 0)

				var_44_4.a = 1
				arg_41_1.mask_.color = var_44_4
			end

			local var_44_5 = 1.43333333333333

			if 1.43333333333333 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 1.43333333333333

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_8.a = 0
				arg_41_1.mask_.color = var_44_8
			end

			if 1.43333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 1.43333333333333 + arg_44_0 then
				local var_44_9 = arg_41_1.bgs_.I11o

				arg_41_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_10 = var_44_9:GetComponent("SpriteRenderer")

				if var_44_10 and var_44_10.sprite then
					local var_44_11 = 2 * (var_44_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_9.transform.localScale = Vector3.New(var_44_11 / var_44_10.sprite.bounds.size.y < var_44_11 * manager.ui.mainCameraCom_.aspect / var_44_10.sprite.bounds.size.x and var_44_11 * manager.ui.mainCameraCom_.aspect / var_44_10.sprite.bounds.size.x or var_44_11 / var_44_10.sprite.bounds.size.y, var_44_11 / var_44_10.sprite.bounds.size.y < var_44_11 * manager.ui.mainCameraCom_.aspect / var_44_10.sprite.bounds.size.x and var_44_11 * manager.ui.mainCameraCom_.aspect / var_44_10.sprite.bounds.size.x or var_44_11 / var_44_10.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "I11o" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_12 = 2.86666666666667
			local var_44_13 = 0.975

			if 2.86666666666667 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_14 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_14:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(319341009).content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 39 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 39)

				if (39 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 39)) > 0 and var_44_13 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17
					var_44_12 = var_44_12 + 0.3

					if var_44_17 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = var_44_12 + 0.3
			local var_44_19 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_18 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_18) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_18 + var_44_19 and arg_41_1.time_ < var_44_18 + var_44_19 + arg_44_0 then
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
				startTime = 1.39933333148559,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319341010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319341010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319341011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.95

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

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319341010).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 38 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 38)

				if (38 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 38)) > 0 and var_50_0 < var_50_3 then
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
	Play319341011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319341011
		arg_51_1.duration_ = 10.47

		local var_51_0 = {
			zh = 4.533,
			ja = 10.466
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
				arg_51_0:Play319341012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1084ui_story = arg_51_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).z)
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles = arg_51_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_51_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1084ui_story"].transform.position).z)
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1084ui_story"].transform.localEulerAngles = arg_51_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1084ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1084ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_54_4 = 0
			local var_54_5 = 0.5

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(319341011)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 20 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 20)

				if (20 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 20)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341011", "story_v_out_319341.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341011", "story_v_out_319341.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_319341", "319341011", "story_v_out_319341.awb")

						arg_51_1:RecordAudio("319341011", var_54_11)
						arg_51_1:RecordAudio("319341011", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319341", "319341011", "story_v_out_319341.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319341", "319341011", "story_v_out_319341.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play319341012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319341012
		arg_55_1.duration_ = 6.1

		local var_55_0 = {
			zh = 2.166,
			ja = 6.1
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
				arg_55_0:Play319341013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.325

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(319341012)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 13 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 13)

				if (13 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 13)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341012", "story_v_out_319341.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341012", "story_v_out_319341.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_319341", "319341012", "story_v_out_319341.awb")

						arg_55_1:RecordAudio("319341012", var_58_6)
						arg_55_1:RecordAudio("319341012", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319341", "319341012", "story_v_out_319341.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319341", "319341012", "story_v_out_319341.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play319341013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319341013
		arg_59_1.duration_ = 6.65

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319341014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) and arg_59_1.var_.characterEffect1084ui_story == nil then
				arg_59_1.var_.characterEffect1084ui_story = arg_59_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) then
				if arg_59_1.var_.characterEffect1084ui_story and not isNil(arg_59_1.actors_["1084ui_story"]) then
					arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) and arg_59_1.var_.characterEffect1084ui_story then
				arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 1.63333333333333 < arg_59_1.time_ and arg_59_1.time_ <= 1.63333333333333 + arg_62_0 then
				local var_62_1 = arg_59_1.bgs_.I11o

				arg_59_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_2 = var_62_1:GetComponent("SpriteRenderer")

				if var_62_2 and var_62_2.sprite then
					local var_62_3 = 2 * (var_62_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_1.transform.localScale = Vector3.New(var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "I11o" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_4 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_5 = 1.63333333333333

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_5 then
				local var_62_6 = Color.New(0, 0, 0)

				var_62_6.a = Mathf.Lerp(0, 1, (arg_59_1.time_ - var_62_4) / var_62_5)
				arg_59_1.mask_.color = var_62_6
			end

			if arg_59_1.time_ >= var_62_4 + var_62_5 and arg_59_1.time_ < var_62_4 + var_62_5 + arg_62_0 then
				local var_62_7 = Color.New(0, 0, 0)

				var_62_7.a = 1
				arg_59_1.mask_.color = var_62_7
			end

			local var_62_8 = 1.63333333333333

			if 1.63333333333333 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_9 = 2

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 then
				local var_62_10 = Color.New(0, 0, 0)

				var_62_10.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_8) / var_62_9)
				arg_59_1.mask_.color = var_62_10
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 then
				local var_62_11 = Color.New(0, 0, 0)

				arg_59_1.mask_.enabled = false
				var_62_11.a = 0
				arg_59_1.mask_.color = var_62_11
			end

			local var_62_12 = arg_59_1.actors_["1084ui_story"].transform

			if 1.63333333333333 < arg_59_1.time_ and arg_59_1.time_ <= 1.63333333333333 + arg_62_0 then
				arg_59_1.var_.moveOldPos1084ui_story = var_62_12.localPosition
			end

			local var_62_13 = 0.001

			if 1.63333333333333 <= arg_59_1.time_ and arg_59_1.time_ < 1.63333333333333 + var_62_13 then
				var_62_12.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 1.63333333333333) / var_62_13)
				var_62_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_12.position).x, (manager.ui.mainCamera.transform.position - var_62_12.position).y, (manager.ui.mainCamera.transform.position - var_62_12.position).z)
				var_62_12.localEulerAngles.z = 0
				var_62_12.localEulerAngles.x = 0
				var_62_12.localEulerAngles = var_62_12.localEulerAngles
			end

			if arg_59_1.time_ >= 1.63333333333333 + var_62_13 and arg_59_1.time_ < 1.63333333333333 + var_62_13 + arg_62_0 then
				var_62_12.localPosition = Vector3.New(0, 100, 0)
				var_62_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_12.position).x, (manager.ui.mainCamera.transform.position - var_62_12.position).y, (manager.ui.mainCamera.transform.position - var_62_12.position).z)
				var_62_12.localEulerAngles.z = 0
				var_62_12.localEulerAngles.x = 0
				var_62_12.localEulerAngles = var_62_12.localEulerAngles
			end

			local var_62_14 = 1.65
			local var_62_15 = 1.125

			if 1.65 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_16 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(319341013).content)

				arg_59_1.text_.text = var_62_16

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_18 = 45 <= 0 and var_62_15 or var_62_15 * (utf8.len(var_62_16) / 45)

				if (45 <= 0 and var_62_15 or var_62_15 * (utf8.len(var_62_16) / 45)) > 0 and var_62_15 < var_62_18 then
					arg_59_1.talkMaxDuration = var_62_18

					if var_62_18 + var_62_14 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_14
					end
				end

				arg_59_1.text_.text = var_62_16
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_19 = math.max(var_62_15, arg_59_1.talkMaxDuration)

			if var_62_14 <= arg_59_1.time_ and arg_59_1.time_ < var_62_14 + var_62_19 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_14) / var_62_19

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_14 + var_62_19 and arg_59_1.time_ < var_62_14 + var_62_19 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play319341014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319341014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319341015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.625

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(319341014).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 65 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 65)

				if (65 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 65)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319341015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319341015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319341016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.975

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(319341015).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 39 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 39)

				if (39 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 39)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319341016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319341016
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319341017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_9000

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_0 = 0.666666666666667

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				local var_74_1 = Color.New(0, 0, 0)

				var_74_1.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.mask_.color = var_74_1
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				local var_74_2 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_2.a = 0
				arg_71_1.mask_.color = var_74_2
			end

			if 0.366666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.366666666666667 + arg_74_0 then
				local var_74_3 = arg_71_1.var_.effect915

				if not arg_71_1.var_.effect915 then
					var_74_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_74_3.name = "915"
					arg_71_1.var_.effect915 = var_74_3
				else
					var_74_3.transform:SetParent(var_74_9000)
				end

				var_74_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_74_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.533333333333333 < arg_71_1.time_ and arg_71_1.time_ <= 0.533333333333333 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "", "", "")

				local var_74_7 = manager.audio:GetAudioName("", "")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_7 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_7

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_7
						arg_71_1.bgmTxt2_.text = var_74_7
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.366666666666667 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_74_9 = 0
			local var_74_10 = 0.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_11 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(319341016).content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 12 <= 0 and var_74_10 or var_74_10 * (utf8.len(var_74_11) / 12)

				if (12 <= 0 and var_74_10 or var_74_10 * (utf8.len(var_74_11) / 12)) > 0 and var_74_10 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_9 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_9
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_10, arg_71_1.talkMaxDuration)

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_14 and arg_71_1.time_ < var_74_9 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319341017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319341017
		arg_76_1.duration_ = 9.73

		local var_76_0 = {
			zh = 6.166,
			ja = 9.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319341018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = arg_76_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1084ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.675

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(319341017)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 27 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 27)

				if (27 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 27)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341017", "story_v_out_319341.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341017", "story_v_out_319341.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_319341", "319341017", "story_v_out_319341.awb")

						arg_76_1:RecordAudio("319341017", var_79_11)
						arg_76_1:RecordAudio("319341017", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319341", "319341017", "story_v_out_319341.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319341", "319341017", "story_v_out_319341.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play319341018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319341018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319341019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.65

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(319341018).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)

				if (26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319341019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319341019
		arg_84_1.duration_ = 5.7

		local var_84_0 = {
			zh = 2.466,
			ja = 5.7
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319341020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.275

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[702].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(319341019)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 11 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 11)

				if (11 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 11)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341019", "story_v_out_319341.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341019", "story_v_out_319341.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_319341", "319341019", "story_v_out_319341.awb")

						arg_84_1:RecordAudio("319341019", var_87_6)
						arg_84_1:RecordAudio("319341019", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319341", "319341019", "story_v_out_319341.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319341", "319341019", "story_v_out_319341.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319341020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319341020
		arg_88_1.duration_ = 11.3

		local var_88_0 = {
			zh = 5.7,
			ja = 11.3
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319341021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = arg_88_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(arg_88_1.actors_["1084ui_story"]) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_91_2 = 0
			local var_91_3 = 0.625

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(319341020)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 25 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 25)

				if (25 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 25)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341020", "story_v_out_319341.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341020", "story_v_out_319341.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_319341", "319341020", "story_v_out_319341.awb")

						arg_88_1:RecordAudio("319341020", var_91_9)
						arg_88_1:RecordAudio("319341020", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319341", "319341020", "story_v_out_319341.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319341", "319341020", "story_v_out_319341.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319341021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319341021
		arg_92_1.duration_ = 10.87

		local var_92_0 = {
			zh = 5.4,
			ja = 10.866
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play319341022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = arg_92_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(arg_92_1.actors_["1084ui_story"]) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.55

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[702].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(319341021)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 22 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 22)

				if (22 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 22)) > 0 and var_95_2 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341021", "story_v_out_319341.awb") ~= 0 then
					local var_95_7 = manager.audio:GetVoiceLength("story_v_out_319341", "319341021", "story_v_out_319341.awb") / 1000

					if var_95_7 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_1
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_319341", "319341021", "story_v_out_319341.awb")

						arg_92_1:RecordAudio("319341021", var_95_8)
						arg_92_1:RecordAudio("319341021", var_95_8)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319341", "319341021", "story_v_out_319341.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319341", "319341021", "story_v_out_319341.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_9 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_9 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_9

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_9 and arg_92_1.time_ < var_95_1 + var_95_9 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319341022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319341022
		arg_96_1.duration_ = 9.2

		local var_96_0 = {
			zh = 4.333,
			ja = 9.2
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319341023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = arg_96_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(arg_96_1.actors_["1084ui_story"]) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_99_2 = 0
			local var_99_3 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(319341022)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 19 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 19)

				if (19 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 19)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341022", "story_v_out_319341.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341022", "story_v_out_319341.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_319341", "319341022", "story_v_out_319341.awb")

						arg_96_1:RecordAudio("319341022", var_99_9)
						arg_96_1:RecordAudio("319341022", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319341", "319341022", "story_v_out_319341.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319341", "319341022", "story_v_out_319341.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play319341023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319341023
		arg_100_1.duration_ = 5.47

		local var_100_0 = {
			zh = 5.166,
			ja = 5.466
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319341024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.675

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(319341023)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 27 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 27)

				if (27 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 27)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341023", "story_v_out_319341.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341023", "story_v_out_319341.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_319341", "319341023", "story_v_out_319341.awb")

						arg_100_1:RecordAudio("319341023", var_103_6)
						arg_100_1:RecordAudio("319341023", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319341", "319341023", "story_v_out_319341.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319341", "319341023", "story_v_out_319341.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319341024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319341024
		arg_104_1.duration_ = 10.4

		local var_104_0 = {
			zh = 10.4,
			ja = 7.4
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play319341025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = arg_104_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) then
				if arg_104_1.var_.characterEffect1084ui_story and not isNil(arg_104_1.actors_["1084ui_story"]) then
					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) and arg_104_1.var_.characterEffect1084ui_story then
				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 0.925

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[702].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(319341024)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 37 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 37)

				if (37 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 37)) > 0 and var_107_2 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341024", "story_v_out_319341.awb") ~= 0 then
					local var_107_7 = manager.audio:GetVoiceLength("story_v_out_319341", "319341024", "story_v_out_319341.awb") / 1000

					if var_107_7 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_1
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_319341", "319341024", "story_v_out_319341.awb")

						arg_104_1:RecordAudio("319341024", var_107_8)
						arg_104_1:RecordAudio("319341024", var_107_8)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319341", "319341024", "story_v_out_319341.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319341", "319341024", "story_v_out_319341.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_9 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_9 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_9

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_9 and arg_104_1.time_ < var_107_1 + var_107_9 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play319341025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319341025
		arg_108_1.duration_ = 3.9

		local var_108_0 = {
			zh = 2.366,
			ja = 3.9
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319341026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = arg_108_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1084ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_111_4 = 0
			local var_111_5 = 0.225

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(319341025)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 9 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 9)

				if (9 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 9)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341025", "story_v_out_319341.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341025", "story_v_out_319341.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_319341", "319341025", "story_v_out_319341.awb")

						arg_108_1:RecordAudio("319341025", var_111_11)
						arg_108_1:RecordAudio("319341025", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319341", "319341025", "story_v_out_319341.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319341", "319341025", "story_v_out_319341.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play319341026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319341026
		arg_112_1.duration_ = 9.2

		local var_112_0 = {
			zh = 9.2,
			ja = 8.766
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319341027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = arg_112_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(arg_112_1.actors_["1084ui_story"]) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 1.15

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[702].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(319341026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 46 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 46)

				if (46 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 46)) > 0 and var_115_2 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341026", "story_v_out_319341.awb") ~= 0 then
					local var_115_7 = manager.audio:GetVoiceLength("story_v_out_319341", "319341026", "story_v_out_319341.awb") / 1000

					if var_115_7 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_1
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_319341", "319341026", "story_v_out_319341.awb")

						arg_112_1:RecordAudio("319341026", var_115_8)
						arg_112_1:RecordAudio("319341026", var_115_8)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319341", "319341026", "story_v_out_319341.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319341", "319341026", "story_v_out_319341.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_9 and arg_112_1.time_ < var_115_1 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319341027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319341027
		arg_116_1.duration_ = 7.23

		local var_116_0 = {
			zh = 4.7,
			ja = 7.233
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319341028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.575

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[702].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(319341027)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 23 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 23)

				if (23 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 23)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341027", "story_v_out_319341.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341027", "story_v_out_319341.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_319341", "319341027", "story_v_out_319341.awb")

						arg_116_1:RecordAudio("319341027", var_119_6)
						arg_116_1:RecordAudio("319341027", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319341", "319341027", "story_v_out_319341.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319341", "319341027", "story_v_out_319341.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play319341028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319341028
		arg_120_1.duration_ = 2.43

		local var_120_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319341029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = arg_120_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) then
				if arg_120_1.var_.characterEffect1084ui_story and not isNil(arg_120_1.actors_["1084ui_story"]) then
					arg_120_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) and arg_120_1.var_.characterEffect1084ui_story then
				arg_120_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_123_2 = 0
			local var_123_3 = 0.075

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(319341028)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 3 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 3)

				if (3 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 3)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341028", "story_v_out_319341.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341028", "story_v_out_319341.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_319341", "319341028", "story_v_out_319341.awb")

						arg_120_1:RecordAudio("319341028", var_123_9)
						arg_120_1:RecordAudio("319341028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319341", "319341028", "story_v_out_319341.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319341", "319341028", "story_v_out_319341.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319341029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319341029
		arg_124_1.duration_ = 8.5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319341030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) and arg_124_1.var_.characterEffect1084ui_story == nil then
				arg_124_1.var_.characterEffect1084ui_story = arg_124_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) then
				if arg_124_1.var_.characterEffect1084ui_story and not isNil(arg_124_1.actors_["1084ui_story"]) then
					arg_124_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) and arg_124_1.var_.characterEffect1084ui_story then
				arg_124_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.63333333333333 < arg_124_1.time_ and arg_124_1.time_ <= 1.63333333333333 + arg_127_0 then
				local var_127_2 = arg_124_1.bgs_.I11o

				arg_124_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_127_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_3 = var_127_2:GetComponent("SpriteRenderer")

				if var_127_3 and var_127_3.sprite then
					local var_127_4 = 2 * (var_127_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_127_2.transform.localScale = Vector3.New(var_127_4 / var_127_3.sprite.bounds.size.y < var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x and var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x or var_127_4 / var_127_3.sprite.bounds.size.y, var_127_4 / var_127_3.sprite.bounds.size.y < var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x and var_127_4 * manager.ui.mainCameraCom_.aspect / var_127_3.sprite.bounds.size.x or var_127_4 / var_127_3.sprite.bounds.size.y, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "I11o" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_5 = 0

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_6 = 1.63333333333333

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 then
				local var_127_7 = Color.New(0, 0, 0)

				var_127_7.a = Mathf.Lerp(0, 1, (arg_124_1.time_ - var_127_5) / var_127_6)
				arg_124_1.mask_.color = var_127_7
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 then
				local var_127_8 = Color.New(0, 0, 0)

				var_127_8.a = 1
				arg_124_1.mask_.color = var_127_8
			end

			local var_127_9 = 1.63333333333333

			if 1.63333333333333 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_10 = 2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 then
				local var_127_11 = Color.New(0, 0, 0)

				var_127_11.a = Mathf.Lerp(1, 0, (arg_124_1.time_ - var_127_9) / var_127_10)
				arg_124_1.mask_.color = var_127_11
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 then
				local var_127_12 = Color.New(0, 0, 0)

				arg_124_1.mask_.enabled = false
				var_127_12.a = 0
				arg_124_1.mask_.color = var_127_12
			end

			local var_127_13 = arg_124_1.actors_["1084ui_story"].transform

			if 1.63333333333333 < arg_124_1.time_ and arg_124_1.time_ <= 1.63333333333333 + arg_127_0 then
				arg_124_1.var_.moveOldPos1084ui_story = var_127_13.localPosition
			end

			local var_127_14 = 0.001

			if 1.63333333333333 <= arg_124_1.time_ and arg_124_1.time_ < 1.63333333333333 + var_127_14 then
				var_127_13.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 1.63333333333333) / var_127_14)
				var_127_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_13.position).x, (manager.ui.mainCamera.transform.position - var_127_13.position).y, (manager.ui.mainCamera.transform.position - var_127_13.position).z)
				var_127_13.localEulerAngles.z = 0
				var_127_13.localEulerAngles.x = 0
				var_127_13.localEulerAngles = var_127_13.localEulerAngles
			end

			if arg_124_1.time_ >= 1.63333333333333 + var_127_14 and arg_124_1.time_ < 1.63333333333333 + var_127_14 + arg_127_0 then
				var_127_13.localPosition = Vector3.New(0, 100, 0)
				var_127_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_13.position).x, (manager.ui.mainCamera.transform.position - var_127_13.position).y, (manager.ui.mainCamera.transform.position - var_127_13.position).z)
				var_127_13.localEulerAngles.z = 0
				var_127_13.localEulerAngles.x = 0
				var_127_13.localEulerAngles = var_127_13.localEulerAngles
			end

			local var_127_15 = 3.5
			local var_127_16 = 1.1

			if 3.5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_17 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(319341029).content)

				arg_124_1.text_.text = var_127_17

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_19 = 44 <= 0 and var_127_16 or var_127_16 * (utf8.len(var_127_17) / 44)

				if (44 <= 0 and var_127_16 or var_127_16 * (utf8.len(var_127_17) / 44)) > 0 and var_127_16 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_17
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_20 and arg_124_1.time_ < var_127_15 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play319341030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319341030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319341031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(319341030).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 42 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 42)

				if (42 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 42)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319341031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319341031
		arg_132_1.duration_ = 6.13

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play319341032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_9000

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = false

				arg_132_1:SetGaussion(false)
			end

			local var_135_0 = 0.733333333333333

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				local var_135_1 = Color.New(1, 1, 1)

				var_135_1.a = Mathf.Lerp(1, 0, (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.mask_.color = var_135_1
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				local var_135_2 = Color.New(1, 1, 1)

				arg_132_1.mask_.enabled = false
				var_135_2.a = 0
				arg_132_1.mask_.color = var_135_2
			end

			local var_135_3 = 0.733333333333333

			if 0.733333333333333 < arg_132_1.time_ and arg_132_1.time_ <= var_135_3 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = false

				arg_132_1:SetGaussion(false)
			end

			local var_135_4 = 0.833333333333333

			if var_135_3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_3 + var_135_4 then
				local var_135_5 = Color.New(1, 1, 1)

				var_135_5.a = Mathf.Lerp(1, 0, (arg_132_1.time_ - var_135_3) / var_135_4)
				arg_132_1.mask_.color = var_135_5
			end

			if arg_132_1.time_ >= var_135_3 + var_135_4 and arg_132_1.time_ < var_135_3 + var_135_4 + arg_135_0 then
				local var_135_6 = Color.New(1, 1, 1)

				arg_132_1.mask_.enabled = false
				var_135_6.a = 0
				arg_132_1.mask_.color = var_135_6
			end

			if 1.33333333333333 < arg_132_1.time_ and arg_132_1.time_ <= 1.33333333333333 + arg_135_0 then
				local var_135_7 = arg_132_1.var_.effect608

				if not arg_132_1.var_.effect608 then
					var_135_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_135_7.name = "608"
					arg_132_1.var_.effect608 = var_135_7
				else
					var_135_7.transform:SetParent(var_135_9000)
				end

				var_135_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_135_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_135_9 = 1.13333333333333
			local var_135_10 = 1.8

			if 1.13333333333333 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_11 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(319341031).content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 72 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 72)

				if (72 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 72)) > 0 and var_135_10 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_9 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_9
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_10, arg_132_1.talkMaxDuration)

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_9) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_9 + var_135_14 and arg_132_1.time_ < var_135_9 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play319341032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319341032
		arg_136_1.duration_ = 3.5

		local var_136_0 = {
			zh = 1.999999999999,
			ja = 3.5
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319341033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = arg_136_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).z)
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles = arg_136_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_136_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).z)
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles = arg_136_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1084ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				if arg_136_1.var_.effect608 then
					Object.Destroy(arg_136_1.var_.effect608)

					arg_136_1.var_.effect608 = nil
				end
			end

			local var_139_5 = 0
			local var_139_6 = 0.175

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(319341032)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 7 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 7)

				if (7 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 7)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341032", "story_v_out_319341.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_319341", "319341032", "story_v_out_319341.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_319341", "319341032", "story_v_out_319341.awb")

						arg_136_1:RecordAudio("319341032", var_139_12)
						arg_136_1:RecordAudio("319341032", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319341", "319341032", "story_v_out_319341.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319341", "319341032", "story_v_out_319341.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play319341033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319341033
		arg_140_1.duration_ = 7.33

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319341034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = arg_140_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) then
				if arg_140_1.var_.characterEffect1084ui_story and not isNil(arg_140_1.actors_["1084ui_story"]) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_143_2 = "STblack"

			if arg_140_1.bgs_.STblack == nil then
				local var_143_3 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_143_2)
				var_143_3.name = var_143_2
				var_143_3.transform.parent = arg_140_1.stage_.transform
				var_143_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_[var_143_2] = var_143_3
			end

			if 1.63333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 1.63333333333333 + arg_143_0 then
				local var_143_4 = arg_140_1.bgs_.STblack

				arg_140_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_5 = var_143_4:GetComponent("SpriteRenderer")

				if var_143_5 and var_143_5.sprite then
					local var_143_6 = 2 * (var_143_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_4.transform.localScale = Vector3.New(var_143_6 / var_143_5.sprite.bounds.size.y < var_143_6 * manager.ui.mainCameraCom_.aspect / var_143_5.sprite.bounds.size.x and var_143_6 * manager.ui.mainCameraCom_.aspect / var_143_5.sprite.bounds.size.x or var_143_6 / var_143_5.sprite.bounds.size.y, var_143_6 / var_143_5.sprite.bounds.size.y < var_143_6 * manager.ui.mainCameraCom_.aspect / var_143_5.sprite.bounds.size.x and var_143_6 * manager.ui.mainCameraCom_.aspect / var_143_5.sprite.bounds.size.x or var_143_6 / var_143_5.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "STblack" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_7 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_8 = 1.63333333333333

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 then
				local var_143_9 = Color.New(0, 0, 0)

				var_143_9.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_7) / var_143_8)
				arg_140_1.mask_.color = var_143_9
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 then
				local var_143_10 = Color.New(0, 0, 0)

				var_143_10.a = 1
				arg_140_1.mask_.color = var_143_10
			end

			local var_143_11 = 1.63333333333333

			if 1.63333333333333 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_12 = 2

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_12 then
				local var_143_13 = Color.New(0, 0, 0)

				var_143_13.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_11) / var_143_12)
				arg_140_1.mask_.color = var_143_13
			end

			if arg_140_1.time_ >= var_143_11 + var_143_12 and arg_140_1.time_ < var_143_11 + var_143_12 + arg_143_0 then
				local var_143_14 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_14.a = 0
				arg_140_1.mask_.color = var_143_14
			end

			local var_143_15 = arg_140_1.actors_["1084ui_story"].transform

			if 1.63333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 1.63333333333333 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = var_143_15.localPosition
			end

			local var_143_16 = 0.001

			if 1.63333333333333 <= arg_140_1.time_ and arg_140_1.time_ < 1.63333333333333 + var_143_16 then
				var_143_15.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 1.63333333333333) / var_143_16)
				var_143_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_15.position).x, (manager.ui.mainCamera.transform.position - var_143_15.position).y, (manager.ui.mainCamera.transform.position - var_143_15.position).z)
				var_143_15.localEulerAngles.z = 0
				var_143_15.localEulerAngles.x = 0
				var_143_15.localEulerAngles = var_143_15.localEulerAngles
			end

			if arg_140_1.time_ >= 1.63333333333333 + var_143_16 and arg_140_1.time_ < 1.63333333333333 + var_143_16 + arg_143_0 then
				var_143_15.localPosition = Vector3.New(0, 100, 0)
				var_143_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_15.position).x, (manager.ui.mainCamera.transform.position - var_143_15.position).y, (manager.ui.mainCamera.transform.position - var_143_15.position).z)
				var_143_15.localEulerAngles.z = 0
				var_143_15.localEulerAngles.x = 0
				var_143_15.localEulerAngles = var_143_15.localEulerAngles
			end

			local var_143_17 = 2.33333333333333
			local var_143_18 = 1.3

			if 2.33333333333333 < arg_140_1.time_ and arg_140_1.time_ <= var_143_17 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_19 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(319341033).content)

				arg_140_1.text_.text = var_143_19

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_21 = 52 <= 0 and var_143_18 or var_143_18 * (utf8.len(var_143_19) / 52)

				if (52 <= 0 and var_143_18 or var_143_18 * (utf8.len(var_143_19) / 52)) > 0 and var_143_18 < var_143_21 then
					arg_140_1.talkMaxDuration = var_143_21

					if var_143_21 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_21 + var_143_17
					end
				end

				arg_140_1.text_.text = var_143_19
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_18, arg_140_1.talkMaxDuration)

			if var_143_17 <= arg_140_1.time_ and arg_140_1.time_ < var_143_17 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_17) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_17 + var_143_22 and arg_140_1.time_ < var_143_17 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play319341034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319341034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play319341035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.725

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_2 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_2:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(319341034).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 67 <= 0 and var_147_1 or var_147_1 * (utf8.len(var_147_3) / 67)

				if (67 <= 0 and var_147_1 or var_147_1 * (utf8.len(var_147_3) / 67)) > 0 and var_147_1 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5
					var_147_0 = var_147_0 + 0.3

					if var_147_5 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = var_147_0 + 0.3
			local var_147_7 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 + 0.3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_7 and arg_144_1.time_ < var_147_6 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319341035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319341035
		arg_150_1.duration_ = 6.27

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319341036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0.366666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 0.366666666666667 + arg_153_0 then
				local var_153_0 = arg_150_1.var_.effect147147147147

				if not arg_150_1.var_.effect147147147147 then
					var_153_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_153_0.name = "147147"
					arg_150_1.var_.effect147147147147 = var_153_0
				else
					var_153_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_153_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_153_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_153_2 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = false

				arg_150_1:SetGaussion(false)
			end

			local var_153_3 = 0.366666666666667

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_3 then
				local var_153_4 = Color.New(1, 1, 1)

				var_153_4.a = Mathf.Lerp(1, 0, (arg_150_1.time_ - var_153_2) / var_153_3)
				arg_150_1.mask_.color = var_153_4
			end

			if arg_150_1.time_ >= var_153_2 + var_153_3 and arg_150_1.time_ < var_153_2 + var_153_3 + arg_153_0 then
				local var_153_5 = Color.New(1, 1, 1)

				arg_150_1.mask_.enabled = false
				var_153_5.a = 0
				arg_150_1.mask_.color = var_153_5
			end

			local var_153_6 = 1.26666666666667
			local var_153_7 = 1

			if 1.26666666666667 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_8 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(319341035).content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 40 <= 0 and var_153_7 or var_153_7 * (utf8.len(var_153_8) / 40)

				if (40 <= 0 and var_153_7 or var_153_7 * (utf8.len(var_153_8) / 40)) > 0 and var_153_7 < var_153_10 then
					arg_150_1.talkMaxDuration = var_153_10

					if var_153_10 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_11 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_11 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_11

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_11 and arg_150_1.time_ < var_153_6 + var_153_11 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319341036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319341036
		arg_154_1.duration_ = 1.03

		local var_154_0 = {
			zh = 1,
			ja = 1.033
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319341037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = arg_154_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) then
				if arg_154_1.var_.characterEffect1084ui_story and not isNil(arg_154_1.actors_["1084ui_story"]) then
					arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) and arg_154_1.var_.characterEffect1084ui_story then
				arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_157_2 = 0
			local var_157_3 = 0.05

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_4 = arg_154_1:GetWordFromCfg(319341036)
				local var_157_5 = arg_154_1:FormatText(var_157_4.content)

				arg_154_1.text_.text = var_157_5

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_7 = 2 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_5) / 2)

				if (2 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_5) / 2)) > 0 and var_157_3 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_5
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341036", "story_v_out_319341.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341036", "story_v_out_319341.awb") / 1000

					if var_157_8 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_2
					end

					if var_157_4.prefab_name ~= "" and arg_154_1.actors_[var_157_4.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_4.prefab_name].transform, "story_v_out_319341", "319341036", "story_v_out_319341.awb")

						arg_154_1:RecordAudio("319341036", var_157_9)
						arg_154_1:RecordAudio("319341036", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_319341", "319341036", "story_v_out_319341.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_319341", "319341036", "story_v_out_319341.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_10 and arg_154_1.time_ < var_157_2 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play319341037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 319341037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play319341038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(319341037).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 44 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 44)

				if (44 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 44)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play319341038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 319341038
		arg_162_1.duration_ = 6

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play319341039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:AudioAction("play", "effect", "se_story_128", "se_story_128_fall", "")
			end

			if 1 < arg_162_1.time_ and arg_162_1.time_ <= 1 + arg_165_0 then
				local var_165_1 = arg_162_1.bgs_.I11o

				arg_162_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_165_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_2 = var_165_1:GetComponent("SpriteRenderer")

				if var_165_2 and var_165_2.sprite then
					local var_165_3 = 2 * (var_165_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_165_1.transform.localScale = Vector3.New(var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "I11o" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_4 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_5 = 1

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_5 then
				local var_165_6 = Color.New(0, 0, 0)

				var_165_6.a = Mathf.Lerp(0, 1, (arg_162_1.time_ - var_165_4) / var_165_5)
				arg_162_1.mask_.color = var_165_6
			end

			if arg_162_1.time_ >= var_165_4 + var_165_5 and arg_162_1.time_ < var_165_4 + var_165_5 + arg_165_0 then
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = 1
				arg_162_1.mask_.color = var_165_7
			end

			local var_165_8 = 1

			if 1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_9 = 2

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_9 then
				local var_165_10 = Color.New(0, 0, 0)

				var_165_10.a = Mathf.Lerp(1, 0, (arg_162_1.time_ - var_165_8) / var_165_9)
				arg_162_1.mask_.color = var_165_10
			end

			if arg_162_1.time_ >= var_165_8 + var_165_9 and arg_162_1.time_ < var_165_8 + var_165_9 + arg_165_0 then
				local var_165_11 = Color.New(0, 0, 0)

				arg_162_1.mask_.enabled = false
				var_165_11.a = 0
				arg_162_1.mask_.color = var_165_11
			end

			local var_165_12 = manager.ui.mainCamera.transform

			if 1 < arg_162_1.time_ and arg_162_1.time_ <= 1 + arg_165_0 then
				arg_162_1.var_.shakeOldPos = var_165_12.localPosition
			end

			local var_165_13 = 0.8

			if 1 <= arg_162_1.time_ and arg_162_1.time_ < 1 + var_165_13 then
				local var_165_14, var_165_15 = math.modf((arg_162_1.time_ - 1) / 0.066)

				var_165_12.localPosition = Vector3.New(var_165_15 * 0.13, var_165_15 * 0.13, var_165_15 * 0.13) + arg_162_1.var_.shakeOldPos
			end

			if arg_162_1.time_ >= 1 + var_165_13 and arg_162_1.time_ < 1 + var_165_13 + arg_165_0 then
				var_165_12.localPosition = arg_162_1.var_.shakeOldPos
			end

			local var_165_16 = 1
			local var_165_17 = 1.275

			if 1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(319341038).content)

				arg_162_1.text_.text = var_165_18

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 51 <= 0 and var_165_17 or var_165_17 * (utf8.len(var_165_18) / 51)

				if (51 <= 0 and var_165_17 or var_165_17 * (utf8.len(var_165_18) / 51)) > 0 and var_165_17 < var_165_20 then
					arg_162_1.talkMaxDuration = var_165_20

					if var_165_20 + var_165_16 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_20 + var_165_16
					end
				end

				arg_162_1.text_.text = var_165_18
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_21 = math.max(var_165_17, arg_162_1.talkMaxDuration)

			if var_165_16 <= arg_162_1.time_ and arg_162_1.time_ < var_165_16 + var_165_21 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_16) / var_165_21

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_16 + var_165_21 and arg_162_1.time_ < var_165_16 + var_165_21 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play319341039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 319341039
		arg_166_1.duration_ = 6.57

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play319341040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_9000

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_16", "se_story_16_energy02", "")
			end

			if 0.233333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 0.233333333333333 + arg_169_0 then
				local var_169_1 = arg_166_1.var_.effect995

				if not arg_166_1.var_.effect995 then
					var_169_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_169_1.name = "995"
					arg_166_1.var_.effect995 = var_169_1
				else
					var_169_1.transform:SetParent(var_169_9000)
				end

				var_169_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_169_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.733333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 0.733333333333333 + arg_169_0 then
				if arg_166_1.var_.effect994 then
					Object.Destroy(arg_166_1.var_.effect994)

					arg_166_1.var_.effect994 = nil
				end
			end

			local var_169_4 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_5 = 0.233333333333333

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_5 then
				local var_169_6 = Color.New(0.9811321, 0.9811321, 0.9811321)

				var_169_6.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_4) / var_169_5)
				arg_166_1.mask_.color = var_169_6
			end

			if arg_166_1.time_ >= var_169_4 + var_169_5 and arg_166_1.time_ < var_169_4 + var_169_5 + arg_169_0 then
				local var_169_7 = Color.New(0.9811321, 0.9811321, 0.9811321)

				arg_166_1.mask_.enabled = false
				var_169_7.a = 0
				arg_166_1.mask_.color = var_169_7
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_8 = 1.56666666666667
			local var_169_9 = 1.2

			if 1.56666666666667 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_10 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_10:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_11 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(319341039).content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 48 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 48)

				if (48 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 48)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13
					var_169_8 = var_169_8 + 0.3

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = var_169_8 + 0.3
			local var_169_15 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_14 + var_169_15 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_14) / var_169_15

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_14 + var_169_15 and arg_166_1.time_ < var_169_14 + var_169_15 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play319341040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319341040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play319341041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_gunreadygroup", "")
			end

			local var_175_1 = 0
			local var_175_2 = 0.85

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(319341040).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 34 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 34)

				if (34 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 34)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play319341041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319341041
		arg_176_1.duration_ = 4.73

		local var_176_0 = {
			zh = 4.36633333333333,
			ja = 4.73333333333333
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
				arg_176_0:Play319341042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = arg_176_1.actors_["1084ui_story"].transform.localPosition

				arg_176_1:ShowWeapon(arg_176_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).z)
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles = arg_176_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_176_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1084ui_story"].transform.position).z)
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1084ui_story"].transform.localEulerAngles = arg_176_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1084ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_4 = 0.633333333333333
			local var_179_5 = 0.225

			if 0.633333333333333 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_6 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_6:setOnUpdate(LuaHelper.FloatAction(function(arg_180_0)
					arg_176_1.dialogCg_.alpha = arg_180_0
				end))
				var_179_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(319341041)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 9 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_8) / 9)

				if (9 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_8) / 9)) > 0 and var_179_5 < var_179_10 then
					arg_176_1.talkMaxDuration = var_179_10
					var_179_4 = var_179_4 + 0.3

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341041", "story_v_out_319341.awb") ~= 0 then
					local var_179_11 = manager.audio:GetVoiceLength("story_v_out_319341", "319341041", "story_v_out_319341.awb") / 1000

					if var_179_11 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_4
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_319341", "319341041", "story_v_out_319341.awb")

						arg_176_1:RecordAudio("319341041", var_179_12)
						arg_176_1:RecordAudio("319341041", var_179_12)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319341", "319341041", "story_v_out_319341.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319341", "319341041", "story_v_out_319341.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_13 = var_179_4 + 0.3
			local var_179_14 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 + 0.3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_13 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_13) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_13 + var_179_14 and arg_176_1.time_ < var_179_13 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play319341042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319341042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319341043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = arg_182_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(arg_182_1.actors_["1084ui_story"]) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_185_1 = 0
			local var_185_2 = 0.85

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(319341042).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 34 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 34)

				if (34 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 34)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play319341043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319341043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play319341044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 1.075

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(319341043).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 43 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 43)

				if (43 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 43)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play319341044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319341044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play319341045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 1.35

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(319341044).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 54 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 54)

				if (54 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 54)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play319341045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319341045
		arg_194_1.duration_ = 5.67

		local var_194_0 = {
			zh = 2.633,
			ja = 5.666
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play319341046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = arg_194_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) then
				if arg_194_1.var_.characterEffect1084ui_story and not isNil(arg_194_1.actors_["1084ui_story"]) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_197_2 = 0
			local var_197_3 = 0.375

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(319341045)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 15 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 15)

				if (15 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 15)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341045", "story_v_out_319341.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341045", "story_v_out_319341.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_319341", "319341045", "story_v_out_319341.awb")

						arg_194_1:RecordAudio("319341045", var_197_9)
						arg_194_1:RecordAudio("319341045", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319341", "319341045", "story_v_out_319341.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319341", "319341045", "story_v_out_319341.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play319341046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319341046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319341047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1084ui_story = arg_198_1.actors_["1084ui_story"].transform.localPosition

				arg_198_1:ShowWeapon(arg_198_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).z)
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles = arg_198_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).z)
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles = arg_198_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_201_1 = 0
			local var_201_2 = 0.9

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(319341046).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 36 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 36)

				if (36 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 36)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play319341047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319341047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319341048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_205_0 = 0.6

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				local var_205_1, var_205_2 = math.modf((arg_202_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_205_2 * 0.13, var_205_2 * 0.13, var_205_2 * 0.13) + arg_202_1.var_.shakeOldPos
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				manager.ui.mainCamera.transform.localPosition = arg_202_1.var_.shakeOldPos
			end

			local var_205_3 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= var_205_3 + 0.6 and arg_202_1.time_ < var_205_3 + 0.6 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			local var_205_4 = 0
			local var_205_5 = 1.1

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(319341047).content)

				arg_202_1.text_.text = var_205_6

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_8 = 44 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_6) / 44)

				if (44 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_6) / 44)) > 0 and var_205_5 < var_205_8 then
					arg_202_1.talkMaxDuration = var_205_8

					if var_205_8 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_6
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_9 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_9 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_9

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_9 and arg_202_1.time_ < var_205_4 + var_205_9 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319341048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319341048
		arg_206_1.duration_ = 5.3

		local var_206_0 = {
			zh = 5.3,
			ja = 4.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319341049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1084ui_story"]) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = arg_206_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1084ui_story"]) then
				if arg_206_1.var_.characterEffect1084ui_story and not isNil(arg_206_1.actors_["1084ui_story"]) then
					arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1084ui_story"]) and arg_206_1.var_.characterEffect1084ui_story then
				arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_209_2 = arg_206_1.actors_["1084ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1084ui_story = var_209_2.localPosition

				arg_206_1:ShowWeapon(arg_206_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_209_3 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 then
				var_209_2.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_206_1.time_ - 0) / var_209_3)
				var_209_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_2.position).x, (manager.ui.mainCamera.transform.position - var_209_2.position).y, (manager.ui.mainCamera.transform.position - var_209_2.position).z)
				var_209_2.localEulerAngles.z = 0
				var_209_2.localEulerAngles.x = 0
				var_209_2.localEulerAngles = var_209_2.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 then
				var_209_2.localPosition = Vector3.New(0, -0.97, -6)
				var_209_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_2.position).x, (manager.ui.mainCamera.transform.position - var_209_2.position).y, (manager.ui.mainCamera.transform.position - var_209_2.position).z)
				var_209_2.localEulerAngles.z = 0
				var_209_2.localEulerAngles.x = 0
				var_209_2.localEulerAngles = var_209_2.localEulerAngles
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_209_4 = 0
			local var_209_5 = 0.35

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(319341048)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 14 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 14)

				if (14 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 14)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341048", "story_v_out_319341.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341048", "story_v_out_319341.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_319341", "319341048", "story_v_out_319341.awb")

						arg_206_1:RecordAudio("319341048", var_209_11)
						arg_206_1:RecordAudio("319341048", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319341", "319341048", "story_v_out_319341.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319341", "319341048", "story_v_out_319341.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play319341049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319341049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play319341050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = arg_210_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(arg_210_1.actors_["1084ui_story"]) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_213_1 = arg_210_1.actors_["1084ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = var_213_1.localPosition

				arg_210_1:ShowWeapon(arg_210_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_213_2 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_2)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0, 100, 0)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			local var_213_3 = 0
			local var_213_4 = 0.6

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_5 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(319341049).content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 24 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 24)

				if (24 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 24)) > 0 and var_213_4 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_3 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_3
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_8 = math.max(var_213_4, arg_210_1.talkMaxDuration)

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_8 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_3) / var_213_8

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_3 + var_213_8 and arg_210_1.time_ < var_213_3 + var_213_8 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play319341050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319341050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319341051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 1.625

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(319341050).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 65 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 65)

				if (65 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 65)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319341051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319341051
		arg_218_1.duration_ = 12.87

		local var_218_0 = {
			zh = 6.73366666851441,
			ja = 12.8666666685144
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319341052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 1.96666666666667 < arg_218_1.time_ and arg_218_1.time_ <= 1.96666666666667 + arg_221_0 then
				arg_218_1.var_.moveOldPos1084ui_story = arg_218_1.actors_["1084ui_story"].transform.localPosition

				arg_218_1:ShowWeapon(arg_218_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_221_0 = 0.001

			if 1.96666666666667 <= arg_218_1.time_ and arg_218_1.time_ < 1.96666666666667 + var_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_218_1.time_ - 1.96666666666667) / var_221_0)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 1.96666666666667 + var_221_0 and arg_218_1.time_ < 1.96666666666667 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1084ui_story"]

			if 1.96666666666667 < arg_218_1.time_ and arg_218_1.time_ <= 1.96666666666667 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story == nil then
				arg_218_1.var_.characterEffect1084ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 1.96666666666667 <= arg_218_1.time_ and arg_218_1.time_ < 1.96666666666667 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1084ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 1.96666666666667 + var_221_2 and arg_218_1.time_ < 1.96666666666667 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story then
				arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.96666666666667 < arg_218_1.time_ and arg_218_1.time_ <= 1.96666666666667 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 1.96666666666667 < arg_218_1.time_ and arg_218_1.time_ <= 1.96666666666667 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1 < arg_218_1.time_ and arg_218_1.time_ <= 1 + arg_221_0 then
				local var_221_4 = arg_218_1.bgs_.I11o

				arg_218_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_221_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_221_5 = var_221_4:GetComponent("SpriteRenderer")

				if var_221_5 and var_221_5.sprite then
					local var_221_6 = 2 * (var_221_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_221_4.transform.localScale = Vector3.New(var_221_6 / var_221_5.sprite.bounds.size.y < var_221_6 * manager.ui.mainCameraCom_.aspect / var_221_5.sprite.bounds.size.x and var_221_6 * manager.ui.mainCameraCom_.aspect / var_221_5.sprite.bounds.size.x or var_221_6 / var_221_5.sprite.bounds.size.y, var_221_6 / var_221_5.sprite.bounds.size.y < var_221_6 * manager.ui.mainCameraCom_.aspect / var_221_5.sprite.bounds.size.x and var_221_6 * manager.ui.mainCameraCom_.aspect / var_221_5.sprite.bounds.size.x or var_221_6 / var_221_5.sprite.bounds.size.y, 0)
				end

				for iter_221_0, iter_221_1 in pairs(arg_218_1.bgs_) do
					if iter_221_0 ~= "I11o" then
						iter_221_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_221_7 = 0

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.mask_.enabled = true
				arg_218_1.mask_.raycastTarget = true

				arg_218_1:SetGaussion(false)
			end

			local var_221_8 = 1

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 then
				local var_221_9 = Color.New(0, 0, 0)

				var_221_9.a = Mathf.Lerp(0, 1, (arg_218_1.time_ - var_221_7) / var_221_8)
				arg_218_1.mask_.color = var_221_9
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 then
				local var_221_10 = Color.New(0, 0, 0)

				var_221_10.a = 1
				arg_218_1.mask_.color = var_221_10
			end

			local var_221_11 = 1

			if 1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1.mask_.enabled = true
				arg_218_1.mask_.raycastTarget = true

				arg_218_1:SetGaussion(false)
			end

			local var_221_12 = 0.966666666666667

			if var_221_11 <= arg_218_1.time_ and arg_218_1.time_ < var_221_11 + var_221_12 then
				local var_221_13 = Color.New(0, 0, 0)

				var_221_13.a = Mathf.Lerp(1, 0, (arg_218_1.time_ - var_221_11) / var_221_12)
				arg_218_1.mask_.color = var_221_13
			end

			if arg_218_1.time_ >= var_221_11 + var_221_12 and arg_218_1.time_ < var_221_11 + var_221_12 + arg_221_0 then
				local var_221_14 = Color.New(0, 0, 0)

				arg_218_1.mask_.enabled = false
				var_221_14.a = 0
				arg_218_1.mask_.color = var_221_14
			end

			if arg_218_1.frameCnt_ <= 1 then
				arg_218_1.dialog_:SetActive(false)
			end

			local var_221_15 = 2.00066666851441
			local var_221_16 = 0.575

			if 2.00066666851441 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0

				arg_218_1.dialog_:SetActive(true)

				arg_218_1.dialogCg_.alpha = 0

				local var_221_17 = LeanTween.value(arg_218_1.dialog_, 0, 1, 0.3)

				var_221_17:setOnUpdate(LuaHelper.FloatAction(function(arg_222_0)
					arg_218_1.dialogCg_.alpha = arg_222_0
				end))
				var_221_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_218_1.dialog_)
					var_221_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_218_1.duration_ = arg_218_1.duration_ + 0.3

				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(319341051)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_21 = 23 <= 0 and var_221_16 or var_221_16 * (utf8.len(var_221_19) / 23)

				if (23 <= 0 and var_221_16 or var_221_16 * (utf8.len(var_221_19) / 23)) > 0 and var_221_16 < var_221_21 then
					arg_218_1.talkMaxDuration = var_221_21
					var_221_15 = var_221_15 + 0.3

					if var_221_21 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_21 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341051", "story_v_out_319341.awb") ~= 0 then
					local var_221_22 = manager.audio:GetVoiceLength("story_v_out_319341", "319341051", "story_v_out_319341.awb") / 1000

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end

					if var_221_18.prefab_name ~= "" and arg_218_1.actors_[var_221_18.prefab_name] ~= nil then
						local var_221_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_18.prefab_name].transform, "story_v_out_319341", "319341051", "story_v_out_319341.awb")

						arg_218_1:RecordAudio("319341051", var_221_23)
						arg_218_1:RecordAudio("319341051", var_221_23)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319341", "319341051", "story_v_out_319341.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319341", "319341051", "story_v_out_319341.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_24 = var_221_15 + 0.3
			local var_221_25 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 + 0.3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_24 + var_221_25 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_24) / var_221_25

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_24 + var_221_25 and arg_218_1.time_ < var_221_24 + var_221_25 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play319341052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319341052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play319341053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = arg_224_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) then
				if arg_224_1.var_.characterEffect1084ui_story and not isNil(arg_224_1.actors_["1084ui_story"]) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_227_2 = 0
			local var_227_3 = 1.325

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_4 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(319341052).content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_6 = 53 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_4) / 53)

				if (53 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_4) / 53)) > 0 and var_227_3 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_2
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_3, arg_224_1.talkMaxDuration)

			if var_227_2 <= arg_224_1.time_ and arg_224_1.time_ < var_227_2 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_2) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_2 + var_227_7 and arg_224_1.time_ < var_227_2 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play319341053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 319341053
		arg_228_1.duration_ = 6.2

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play319341054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_9000

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_231_1 = arg_228_1.actors_["1084ui_story"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1084ui_story = var_231_1.localPosition

				arg_228_1:ShowWeapon(arg_228_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_231_2 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 then
				var_231_1.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_228_1.time_ - 0) / var_231_2)
				var_231_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_231_1.position).x, (manager.ui.mainCamera.transform.position - var_231_1.position).y, (manager.ui.mainCamera.transform.position - var_231_1.position).z)
				var_231_1.localEulerAngles.z = 0
				var_231_1.localEulerAngles.x = 0
				var_231_1.localEulerAngles = var_231_1.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 then
				var_231_1.localPosition = Vector3.New(0, 100, 0)
				var_231_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_231_1.position).x, (manager.ui.mainCamera.transform.position - var_231_1.position).y, (manager.ui.mainCamera.transform.position - var_231_1.position).z)
				var_231_1.localEulerAngles.z = 0
				var_231_1.localEulerAngles.x = 0
				var_231_1.localEulerAngles = var_231_1.localEulerAngles
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				local var_231_3 = arg_228_1.var_.effect破坏屏障1

				if not arg_228_1.var_.effect破坏屏障1 then
					var_231_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_231_3.name = "破坏屏障1"
					arg_228_1.var_.effect破坏屏障1 = var_231_3
				else
					var_231_3.transform:SetParent(var_231_9000)
				end

				var_231_3.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_231_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.6 < arg_228_1.time_ and arg_228_1.time_ <= 0.6 + arg_231_0 then
				if arg_228_1.var_.effect破坏屏障1 then
					Object.Destroy(arg_228_1.var_.effect破坏屏障1)

					arg_228_1.var_.effect破坏屏障1 = nil
				end
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_6 = 1.2
			local var_231_7 = 1.675

			if 1.2 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_8 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_8:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_9 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(319341053).content)

				arg_228_1.text_.text = var_231_9

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 67 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 67)

				if (67 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 67)) > 0 and var_231_7 < var_231_11 then
					arg_228_1.talkMaxDuration = var_231_11
					var_231_6 = var_231_6 + 0.3

					if var_231_11 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_9
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = var_231_6 + 0.3
			local var_231_13 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 + 0.3 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_13 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_12) / var_231_13

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_12 + var_231_13 and arg_228_1.time_ < var_231_12 + var_231_13 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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

		arg_228_1:InitPlayNodeList()
	end,
	Play319341054 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319341054
		arg_234_1.duration_ = 7.33

		local var_234_0 = {
			zh = 7.333,
			ja = 6
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319341055(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = arg_234_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) then
				if arg_234_1.var_.characterEffect1084ui_story and not isNil(arg_234_1.actors_["1084ui_story"]) then
					arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) and arg_234_1.var_.characterEffect1084ui_story then
				arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_237_2 = arg_234_1.actors_["1084ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1084ui_story = var_237_2.localPosition

				arg_234_1:ShowWeapon(arg_234_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_237_3 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 then
				var_237_2.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_234_1.time_ - 0) / var_237_3)
				var_237_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_2.position).x, (manager.ui.mainCamera.transform.position - var_237_2.position).y, (manager.ui.mainCamera.transform.position - var_237_2.position).z)
				var_237_2.localEulerAngles.z = 0
				var_237_2.localEulerAngles.x = 0
				var_237_2.localEulerAngles = var_237_2.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 then
				var_237_2.localPosition = Vector3.New(0, -0.97, -6)
				var_237_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_2.position).x, (manager.ui.mainCamera.transform.position - var_237_2.position).y, (manager.ui.mainCamera.transform.position - var_237_2.position).z)
				var_237_2.localEulerAngles.z = 0
				var_237_2.localEulerAngles.x = 0
				var_237_2.localEulerAngles = var_237_2.localEulerAngles
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_237_4 = 0
			local var_237_5 = 0.65

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(319341054)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 26 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 26)

				if (26 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 26)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341054", "story_v_out_319341.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341054", "story_v_out_319341.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_319341", "319341054", "story_v_out_319341.awb")

						arg_234_1:RecordAudio("319341054", var_237_11)
						arg_234_1:RecordAudio("319341054", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_319341", "319341054", "story_v_out_319341.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_319341", "319341054", "story_v_out_319341.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play319341055 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319341055
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play319341056(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:AudioAction("play", "effect", "se_story_130", "se_story_130__1095_skill1_2", "")
			end

			local var_241_1 = arg_238_1.actors_["1084ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_2)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_241_3 = arg_238_1.actors_["1084ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_3.localPosition

				arg_238_1:ShowWeapon(arg_238_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_241_4 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				var_241_3.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_4)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				var_241_3.localPosition = Vector3.New(0, 100, 0)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			local var_241_5 = 0
			local var_241_6 = 1.3

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_7 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(319341055).content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 52 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_7) / 52)

				if (52 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_7) / 52)) > 0 and var_241_6 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_10 and arg_238_1.time_ < var_241_5 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play319341056 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319341056
		arg_242_1.duration_ = 5.6

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319341057(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1084ui_story = arg_242_1.actors_["1084ui_story"].transform.localPosition

				arg_242_1:ShowWeapon(arg_242_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).z)
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles = arg_242_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).z)
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles = arg_242_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1084ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = false

				arg_242_1:SetGaussion(false)
			end

			local var_245_5 = 0.6

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_5 then
				local var_245_6 = Color.New(1, 1, 1)

				var_245_6.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_4) / var_245_5)
				arg_242_1.mask_.color = var_245_6
			end

			if arg_242_1.time_ >= var_245_4 + var_245_5 and arg_242_1.time_ < var_245_4 + var_245_5 + arg_245_0 then
				local var_245_7 = Color.New(1, 1, 1)

				arg_242_1.mask_.enabled = false
				var_245_7.a = 0
				arg_242_1.mask_.color = var_245_7
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_8 = 0.6
			local var_245_9 = 1.4

			if 0.6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_10 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_10:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_11 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(319341056).content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 56 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 56)

				if (56 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 56)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13
					var_245_8 = var_245_8 + 0.3

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = var_245_8 + 0.3
			local var_245_15 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_14 + var_245_15 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_14) / var_245_15

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_14 + var_245_15 and arg_242_1.time_ < var_245_14 + var_245_15 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play319341057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319341057
		arg_248_1.duration_ = 4.5

		local var_248_0 = {
			zh = 1.566,
			ja = 4.5
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play319341058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.2

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(319341057)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 8 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 8)

				if (8 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 8)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341057", "story_v_out_319341.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341057", "story_v_out_319341.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_319341", "319341057", "story_v_out_319341.awb")

						arg_248_1:RecordAudio("319341057", var_251_6)
						arg_248_1:RecordAudio("319341057", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_319341", "319341057", "story_v_out_319341.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_319341", "319341057", "story_v_out_319341.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play319341058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319341058
		arg_252_1.duration_ = 1

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319341059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story == nil then
				arg_252_1.var_.characterEffect1084ui_story = arg_252_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) then
				if arg_252_1.var_.characterEffect1084ui_story and not isNil(arg_252_1.actors_["1084ui_story"]) then
					arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story then
				arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_255_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_252_1.bgmTxt_.text ~= var_255_4 and arg_252_1.bgmTxt_.text ~= "" then
						if arg_252_1.bgmTxt2_.text ~= "" then
							arg_252_1.bgmTxt_.text = arg_252_1.bgmTxt2_.text
						end

						arg_252_1.bgmTxt2_.text = var_255_4

						arg_252_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_252_1.bgmTxt_.text = var_255_4
						arg_252_1.bgmTxt2_.text = var_255_4
					end

					if arg_252_1.bgmTimer then
						arg_252_1.bgmTimer:Stop()

						arg_252_1.bgmTimer = nil
					end

					if arg_252_1.settingData.show_music_name == 1 then
						arg_252_1.musicController:SetSelectedState("show")
						arg_252_1.musicAnimator_:Play("open", 0, 0)

						if arg_252_1.settingData.music_time ~= 0 then
							arg_252_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_252_1.settingData.music_time), function()
								if arg_252_1 == nil or isNil(arg_252_1.bgmTxt_) then
									return
								end

								arg_252_1.musicController:SetSelectedState("hide")
								arg_252_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_255_5 = 0
			local var_255_6 = 0.05

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_7 = arg_252_1:GetWordFromCfg(319341058)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 2 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 2)

				if (2 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 2)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341058", "story_v_out_319341.awb") ~= 0 then
					local var_255_11 = manager.audio:GetVoiceLength("story_v_out_319341", "319341058", "story_v_out_319341.awb") / 1000

					if var_255_11 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_5
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_319341", "319341058", "story_v_out_319341.awb")

						arg_252_1:RecordAudio("319341058", var_255_12)
						arg_252_1:RecordAudio("319341058", var_255_12)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319341", "319341058", "story_v_out_319341.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319341", "319341058", "story_v_out_319341.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_13 and arg_252_1.time_ < var_255_5 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319341059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319341059
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319341060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = arg_257_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) then
				if arg_257_1.var_.characterEffect1084ui_story and not isNil(arg_257_1.actors_["1084ui_story"]) then
					arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story then
				arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 0.875

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(319341059).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 35 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 35)

				if (35 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 35)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319341060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319341060
		arg_261_1.duration_ = 7.1

		local var_261_0 = {
			zh = 6.26633333333333,
			ja = 7.09933333333333
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319341061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.bgs_.ML0102 == nil then
				local var_264_0 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0102")
				var_264_0.name = "ML0102"
				var_264_0.transform.parent = arg_261_1.stage_.transform
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_.ML0102 = var_264_0
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				local var_264_1 = arg_261_1.bgs_.ML0102

				arg_261_1.bgs_.ML0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_2 = var_264_1:GetComponent("SpriteRenderer")

				if var_264_2 and var_264_2.sprite then
					local var_264_3 = 2 * (var_264_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_1.transform.localScale = Vector3.New(var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "ML0102" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_4 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_5 = 2

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_5 then
				local var_264_6 = Color.New(0, 0, 0)

				var_264_6.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_4) / var_264_5)
				arg_261_1.mask_.color = var_264_6
			end

			if arg_261_1.time_ >= var_264_4 + var_264_5 and arg_261_1.time_ < var_264_4 + var_264_5 + arg_264_0 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = 1
				arg_261_1.mask_.color = var_264_7
			end

			local var_264_8 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_9 = 2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 then
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_8) / var_264_9)
				arg_261_1.mask_.color = var_264_10
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				local var_264_11 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_11.a = 0
				arg_261_1.mask_.color = var_264_11
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_264_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_14 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_14

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_14
						arg_261_1.bgmTxt2_.text = var_264_14
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_261_1.time_ and arg_261_1.time_ <= 0.166666666666667 + arg_264_0 then
				arg_261_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_264_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_17 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_17

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_17
						arg_261_1.bgmTxt2_.text = var_264_17
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_264_18 = "ML0102_blur"

			if arg_261_1.bgs_.ML0102_blur == nil then
				local var_264_19 = Object.Instantiate(arg_261_1.blurPaintGo_)

				var_264_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_264_18)
				var_264_19.name = var_264_18
				var_264_19.transform.parent = arg_261_1.stage_.transform
				var_264_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_[var_264_18] = var_264_19
			end

			local var_264_20 = 1.999999999999
			local var_264_21 = arg_261_1.bgs_[var_264_18]

			if 1.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_20 + arg_264_0 then
				var_264_21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_22 = var_264_21:GetComponent("SpriteRenderer")

				if var_264_22 and var_264_22.sprite then
					local var_264_23 = 2 * (var_264_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_21.transform.localScale = Vector3.New(var_264_23 / var_264_22.sprite.bounds.size.y < var_264_23 * manager.ui.mainCameraCom_.aspect / var_264_22.sprite.bounds.size.x and var_264_23 * manager.ui.mainCameraCom_.aspect / var_264_22.sprite.bounds.size.x or var_264_23 / var_264_22.sprite.bounds.size.y, var_264_23 / var_264_22.sprite.bounds.size.y < var_264_23 * manager.ui.mainCameraCom_.aspect / var_264_22.sprite.bounds.size.x and var_264_23 * manager.ui.mainCameraCom_.aspect / var_264_22.sprite.bounds.size.x or var_264_23 / var_264_22.sprite.bounds.size.y, 0)
				end
			end

			local var_264_24 = 0.900000000001

			if var_264_20 <= arg_261_1.time_ and arg_261_1.time_ < var_264_20 + var_264_24 then
				local var_264_25 = Color.New(1, 1, 1)

				var_264_25.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_20) / var_264_24)

				var_264_21:GetComponent("SpriteRenderer").material:SetColor("_Color", var_264_25)
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_26 = 3.83333333333333
			local var_264_27 = 0.275

			if 3.83333333333333 < arg_261_1.time_ and arg_261_1.time_ <= var_264_26 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_28 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_28:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_261_1.dialogCg_.alpha = arg_267_0
				end))
				var_264_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_29 = arg_261_1:GetWordFromCfg(319341060)
				local var_264_30 = arg_261_1:FormatText(var_264_29.content)

				arg_261_1.text_.text = var_264_30

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_32 = 11 <= 0 and var_264_27 or var_264_27 * (utf8.len(var_264_30) / 11)

				if (11 <= 0 and var_264_27 or var_264_27 * (utf8.len(var_264_30) / 11)) > 0 and var_264_27 < var_264_32 then
					arg_261_1.talkMaxDuration = var_264_32
					var_264_26 = var_264_26 + 0.3

					if var_264_32 + var_264_26 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_32 + var_264_26
					end
				end

				arg_261_1.text_.text = var_264_30
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341060", "story_v_out_319341.awb") ~= 0 then
					local var_264_33 = manager.audio:GetVoiceLength("story_v_out_319341", "319341060", "story_v_out_319341.awb") / 1000

					if var_264_33 + var_264_26 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_33 + var_264_26
					end

					if var_264_29.prefab_name ~= "" and arg_261_1.actors_[var_264_29.prefab_name] ~= nil then
						local var_264_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_29.prefab_name].transform, "story_v_out_319341", "319341060", "story_v_out_319341.awb")

						arg_261_1:RecordAudio("319341060", var_264_34)
						arg_261_1:RecordAudio("319341060", var_264_34)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319341", "319341060", "story_v_out_319341.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319341", "319341060", "story_v_out_319341.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_35 = var_264_26 + 0.3
			local var_264_36 = math.max(var_264_27, arg_261_1.talkMaxDuration)

			if var_264_26 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_35 + var_264_36 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_35) / var_264_36

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_35 + var_264_36 and arg_261_1.time_ < var_264_35 + var_264_36 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319341061 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319341061
		arg_269_1.duration_ = 3.67

		local var_269_0 = {
			zh = 1.4,
			ja = 3.666
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
				arg_269_0:Play319341062(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.125

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

				local var_272_1 = arg_269_1:GetWordFromCfg(319341061)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 5 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 5)

				if (5 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 5)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341061", "story_v_out_319341.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341061", "story_v_out_319341.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_319341", "319341061", "story_v_out_319341.awb")

						arg_269_1:RecordAudio("319341061", var_272_6)
						arg_269_1:RecordAudio("319341061", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319341", "319341061", "story_v_out_319341.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319341", "319341061", "story_v_out_319341.awb")
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
	Play319341062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319341062
		arg_273_1.duration_ = 4

		local var_273_0 = {
			zh = 3.933,
			ja = 4
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
				arg_273_0:Play319341063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.4

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(319341062)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 16 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 16)

				if (16 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 16)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341062", "story_v_out_319341.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341062", "story_v_out_319341.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_319341", "319341062", "story_v_out_319341.awb")

						arg_273_1:RecordAudio("319341062", var_276_6)
						arg_273_1:RecordAudio("319341062", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319341", "319341062", "story_v_out_319341.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319341", "319341062", "story_v_out_319341.awb")
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
	Play319341063 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319341063
		arg_277_1.duration_ = 13.4

		local var_277_0 = {
			zh = 10.566,
			ja = 13.4
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
				arg_277_0:Play319341064(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.3

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(319341063)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 52 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 52)

				if (52 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 52)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341063", "story_v_out_319341.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341063", "story_v_out_319341.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_319341", "319341063", "story_v_out_319341.awb")

						arg_277_1:RecordAudio("319341063", var_280_6)
						arg_277_1:RecordAudio("319341063", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319341", "319341063", "story_v_out_319341.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319341", "319341063", "story_v_out_319341.awb")
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
	Play319341064 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319341064
		arg_281_1.duration_ = 10.4

		local var_281_0 = {
			zh = 6.366,
			ja = 10.4
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
				arg_281_0:Play319341065(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.525

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(319341064)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 21 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 21)

				if (21 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 21)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341064", "story_v_out_319341.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341064", "story_v_out_319341.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_319341", "319341064", "story_v_out_319341.awb")

						arg_281_1:RecordAudio("319341064", var_284_6)
						arg_281_1:RecordAudio("319341064", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319341", "319341064", "story_v_out_319341.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319341", "319341064", "story_v_out_319341.awb")
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
	Play319341065 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319341065
		arg_285_1.duration_ = 3.97

		local var_285_0 = {
			zh = 3.966,
			ja = 3.9
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
				arg_285_0:Play319341066(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(319341065)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 12)

				if (12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 12)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341065", "story_v_out_319341.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341065", "story_v_out_319341.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_319341", "319341065", "story_v_out_319341.awb")

						arg_285_1:RecordAudio("319341065", var_288_6)
						arg_285_1:RecordAudio("319341065", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319341", "319341065", "story_v_out_319341.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319341", "319341065", "story_v_out_319341.awb")
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
	Play319341066 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319341066
		arg_289_1.duration_ = 8.2

		local var_289_0 = {
			zh = 4.033,
			ja = 8.2
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
				arg_289_0:Play319341067(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.4

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(319341066)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 16 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 16)

				if (16 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 16)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341066", "story_v_out_319341.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341066", "story_v_out_319341.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_319341", "319341066", "story_v_out_319341.awb")

						arg_289_1:RecordAudio("319341066", var_292_6)
						arg_289_1:RecordAudio("319341066", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_319341", "319341066", "story_v_out_319341.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_319341", "319341066", "story_v_out_319341.awb")
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
	Play319341067 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319341067
		arg_293_1.duration_ = 1.13

		local var_293_0 = {
			zh = 1,
			ja = 1.133
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play319341068(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.075

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:GetWordFromCfg(319341067)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 3 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 3)

				if (3 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 3)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341067", "story_v_out_319341.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341067", "story_v_out_319341.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_319341", "319341067", "story_v_out_319341.awb")

						arg_293_1:RecordAudio("319341067", var_296_6)
						arg_293_1:RecordAudio("319341067", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319341", "319341067", "story_v_out_319341.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319341", "319341067", "story_v_out_319341.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play319341068 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319341068
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play319341069(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.35

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(319341068).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 54 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 54)

				if (54 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 54)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play319341069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 319341069
		arg_301_1.duration_ = 7.33

		local var_301_0 = {
			zh = 7.166,
			ja = 7.333
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play319341070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_0 = 1

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				local var_304_1 = Color.New(0, 0, 0)

				var_304_1.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.mask_.color = var_304_1
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				local var_304_2 = Color.New(0, 0, 0)

				var_304_2.a = 1
				arg_301_1.mask_.color = var_304_2
			end

			local var_304_3 = 1

			if 1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_4 = 1

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_4 then
				local var_304_5 = Color.New(0, 0, 0)

				var_304_5.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_3) / var_304_4)
				arg_301_1.mask_.color = var_304_5
			end

			if arg_301_1.time_ >= var_304_3 + var_304_4 and arg_301_1.time_ < var_304_3 + var_304_4 + arg_304_0 then
				local var_304_6 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_6.a = 0
				arg_301_1.mask_.color = var_304_6
			end

			local var_304_7 = arg_301_1.bgs_.ML0102.transform

			if 1 < arg_301_1.time_ and arg_301_1.time_ <= 1 + arg_304_0 then
				arg_301_1.var_.moveOldPosML0102 = var_304_7.localPosition
			end

			local var_304_8 = 0.001

			if 1 <= arg_301_1.time_ and arg_301_1.time_ < 1 + var_304_8 then
				var_304_7.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPosML0102, Vector3.New(1, 0, 4), (arg_301_1.time_ - 1) / var_304_8)
			end

			if arg_301_1.time_ >= 1 + var_304_8 and arg_301_1.time_ < 1 + var_304_8 + arg_304_0 then
				var_304_7.localPosition = Vector3.New(1, 0, 4)
			end

			local var_304_9 = arg_301_1.bgs_.ML0102.transform

			if 1.034 < arg_301_1.time_ and arg_301_1.time_ <= 1.034 + arg_304_0 then
				arg_301_1.var_.moveOldPosML0102 = var_304_9.localPosition
			end

			local var_304_10 = 3.5

			if 1.034 <= arg_301_1.time_ and arg_301_1.time_ < 1.034 + var_304_10 then
				var_304_9.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPosML0102, Vector3.New(1, -0.5, 4), (arg_301_1.time_ - 1.034) / var_304_10)
			end

			if arg_301_1.time_ >= 1.034 + var_304_10 and arg_301_1.time_ < 1.034 + var_304_10 + arg_304_0 then
				var_304_9.localPosition = Vector3.New(1, -0.5, 4)
			end

			local var_304_11 = 2.01733333333333

			if 2.01733333333333 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_11 + 2.51666666666667 and arg_301_1.time_ < var_304_11 + 2.51666666666667 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_12 = 1.8
			local var_304_13 = 0.475

			if 1.8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_14 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_14:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_15 = arg_301_1:GetWordFromCfg(319341069)
				local var_304_16 = arg_301_1:FormatText(var_304_15.content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_18 = 19 <= 0 and var_304_13 or var_304_13 * (utf8.len(var_304_16) / 19)

				if (19 <= 0 and var_304_13 or var_304_13 * (utf8.len(var_304_16) / 19)) > 0 and var_304_13 < var_304_18 then
					arg_301_1.talkMaxDuration = var_304_18
					var_304_12 = var_304_12 + 0.3

					if var_304_18 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_18 + var_304_12
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341069", "story_v_out_319341.awb") ~= 0 then
					local var_304_19 = manager.audio:GetVoiceLength("story_v_out_319341", "319341069", "story_v_out_319341.awb") / 1000

					if var_304_19 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_12
					end

					if var_304_15.prefab_name ~= "" and arg_301_1.actors_[var_304_15.prefab_name] ~= nil then
						local var_304_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_15.prefab_name].transform, "story_v_out_319341", "319341069", "story_v_out_319341.awb")

						arg_301_1:RecordAudio("319341069", var_304_20)
						arg_301_1:RecordAudio("319341069", var_304_20)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_319341", "319341069", "story_v_out_319341.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_319341", "319341069", "story_v_out_319341.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_21 = var_304_12 + 0.3
			local var_304_22 = math.max(var_304_13, arg_301_1.talkMaxDuration)

			if var_304_12 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_21 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_21) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_21 + var_304_22 and arg_301_1.time_ < var_304_21 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play319341070 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319341070
		arg_307_1.duration_ = 5.5

		local var_307_0 = {
			zh = 2.433,
			ja = 5.5
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
				arg_307_0:Play319341071(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.25

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(319341070)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 10 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 10)

				if (10 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 10)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341070", "story_v_out_319341.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341070", "story_v_out_319341.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_319341", "319341070", "story_v_out_319341.awb")

						arg_307_1:RecordAudio("319341070", var_310_6)
						arg_307_1:RecordAudio("319341070", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319341", "319341070", "story_v_out_319341.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319341", "319341070", "story_v_out_319341.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play319341071 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319341071
		arg_311_1.duration_ = 6.77

		local var_311_0 = {
			zh = 6.4,
			ja = 6.766
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
				arg_311_0:Play319341072(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 1.7 < arg_311_1.time_ and arg_311_1.time_ <= 1.7 + arg_314_0 then
				local var_314_0 = arg_311_1.bgs_.I11o

				arg_311_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_314_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_1 = var_314_0:GetComponent("SpriteRenderer")

				if var_314_1 and var_314_1.sprite then
					local var_314_2 = 2 * (var_314_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_314_0.transform.localScale = Vector3.New(var_314_2 / var_314_1.sprite.bounds.size.y < var_314_2 * manager.ui.mainCameraCom_.aspect / var_314_1.sprite.bounds.size.x and var_314_2 * manager.ui.mainCameraCom_.aspect / var_314_1.sprite.bounds.size.x or var_314_2 / var_314_1.sprite.bounds.size.y, var_314_2 / var_314_1.sprite.bounds.size.y < var_314_2 * manager.ui.mainCameraCom_.aspect / var_314_1.sprite.bounds.size.x and var_314_2 * manager.ui.mainCameraCom_.aspect / var_314_1.sprite.bounds.size.x or var_314_2 / var_314_1.sprite.bounds.size.y, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "I11o" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_3 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_3 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_4 = 1.7

			if var_314_3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_3 + var_314_4 then
				local var_314_5 = Color.New(0, 0, 0)

				var_314_5.a = Mathf.Lerp(0, 1, (arg_311_1.time_ - var_314_3) / var_314_4)
				arg_311_1.mask_.color = var_314_5
			end

			if arg_311_1.time_ >= var_314_3 + var_314_4 and arg_311_1.time_ < var_314_3 + var_314_4 + arg_314_0 then
				local var_314_6 = Color.New(0, 0, 0)

				var_314_6.a = 1
				arg_311_1.mask_.color = var_314_6
			end

			local var_314_7 = 1.7

			if 1.7 < arg_311_1.time_ and arg_311_1.time_ <= var_314_7 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_8 = 1.3

			if var_314_7 <= arg_311_1.time_ and arg_311_1.time_ < var_314_7 + var_314_8 then
				local var_314_9 = Color.New(0, 0, 0)

				var_314_9.a = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_7) / var_314_8)
				arg_311_1.mask_.color = var_314_9
			end

			if arg_311_1.time_ >= var_314_7 + var_314_8 and arg_311_1.time_ < var_314_7 + var_314_8 + arg_314_0 then
				local var_314_10 = Color.New(0, 0, 0)

				arg_311_1.mask_.enabled = false
				var_314_10.a = 0
				arg_311_1.mask_.color = var_314_10
			end

			local var_314_11 = arg_311_1.actors_["1084ui_story"].transform

			if 3 < arg_311_1.time_ and arg_311_1.time_ <= 3 + arg_314_0 then
				arg_311_1.var_.moveOldPos1084ui_story = var_314_11.localPosition
			end

			local var_314_12 = 0.001

			if 3 <= arg_311_1.time_ and arg_311_1.time_ < 3 + var_314_12 then
				var_314_11.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_311_1.time_ - 3) / var_314_12)
				var_314_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_11.position).x, (manager.ui.mainCamera.transform.position - var_314_11.position).y, (manager.ui.mainCamera.transform.position - var_314_11.position).z)
				var_314_11.localEulerAngles.z = 0
				var_314_11.localEulerAngles.x = 0
				var_314_11.localEulerAngles = var_314_11.localEulerAngles
			end

			if arg_311_1.time_ >= 3 + var_314_12 and arg_311_1.time_ < 3 + var_314_12 + arg_314_0 then
				var_314_11.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_314_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_11.position).x, (manager.ui.mainCamera.transform.position - var_314_11.position).y, (manager.ui.mainCamera.transform.position - var_314_11.position).z)
				var_314_11.localEulerAngles.z = 0
				var_314_11.localEulerAngles.x = 0
				var_314_11.localEulerAngles = var_314_11.localEulerAngles
			end

			local var_314_13 = arg_311_1.actors_["1084ui_story"]

			if 3 < arg_311_1.time_ and arg_311_1.time_ <= 3 + arg_314_0 and not isNil(var_314_13) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_14 = 0.200000002980232

			if 3 <= arg_311_1.time_ and arg_311_1.time_ < 3 + var_314_14 and not isNil(var_314_13) then
				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_13) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 3 + var_314_14 and arg_311_1.time_ < 3 + var_314_14 + arg_314_0 and not isNil(var_314_13) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3 < arg_311_1.time_ and arg_311_1.time_ <= 3 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 3 < arg_311_1.time_ and arg_311_1.time_ <= 3 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_16 = 3
			local var_314_17 = 0.4

			if 3 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_18 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_18:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(319341071)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_22 = 16 <= 0 and var_314_17 or var_314_17 * (utf8.len(var_314_20) / 16)

				if (16 <= 0 and var_314_17 or var_314_17 * (utf8.len(var_314_20) / 16)) > 0 and var_314_17 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22
					var_314_16 = var_314_16 + 0.3

					if var_314_22 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341071", "story_v_out_319341.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_319341", "319341071", "story_v_out_319341.awb") / 1000

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_319341", "319341071", "story_v_out_319341.awb")

						arg_311_1:RecordAudio("319341071", var_314_24)
						arg_311_1:RecordAudio("319341071", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319341", "319341071", "story_v_out_319341.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319341", "319341071", "story_v_out_319341.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = var_314_16 + 0.3
			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_25 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_25) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_25 + var_314_26 and arg_311_1.time_ < var_314_25 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play319341072 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319341072
		arg_317_1.duration_ = 2.7

		local var_317_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319341073(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if arg_317_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_320_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_317_1.stage_.transform)

				var_320_0.name = "10058ui_story"
				var_320_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["10058ui_story"] = var_320_0

				local var_320_1 = var_320_0:GetComponentInChildren(typeof(CharacterEffect))

				var_320_1.enabled = true

				local var_320_2 = GameObjectTools.GetOrAddComponent(var_320_0, typeof(DynamicBoneHelper))

				if var_320_2 then
					var_320_2:EnableDynamicBone(false)
				end

				arg_317_1:ShowWeapon(var_320_1.transform, false)

				arg_317_1.var_["10058ui_story" .. "Animator"] = var_320_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_317_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_317_1.var_["10058ui_story" .. "LipSync"] = var_320_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_320_3 = arg_317_1.actors_["10058ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10058ui_story = var_320_3.localPosition
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_3.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_317_1.time_ - 0) / var_320_4)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			local var_320_5 = arg_317_1.actors_["10058ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect10058ui_story == nil then
				arg_317_1.var_.characterEffect10058ui_story = var_320_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.characterEffect10058ui_story and not isNil(var_320_5) then
					arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect10058ui_story then
				arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_8 = arg_317_1.actors_["1084ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1084ui_story = var_320_8.localPosition
			end

			local var_320_9 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_9 then
				var_320_8.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_317_1.time_ - 0) / var_320_9)
				var_320_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_8.position).x, (manager.ui.mainCamera.transform.position - var_320_8.position).y, (manager.ui.mainCamera.transform.position - var_320_8.position).z)
				var_320_8.localEulerAngles.z = 0
				var_320_8.localEulerAngles.x = 0
				var_320_8.localEulerAngles = var_320_8.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_9 and arg_317_1.time_ < 0 + var_320_9 + arg_320_0 then
				var_320_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_320_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_8.position).x, (manager.ui.mainCamera.transform.position - var_320_8.position).y, (manager.ui.mainCamera.transform.position - var_320_8.position).z)
				var_320_8.localEulerAngles.z = 0
				var_320_8.localEulerAngles.x = 0
				var_320_8.localEulerAngles = var_320_8.localEulerAngles
			end

			local var_320_10 = arg_317_1.actors_["1084ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_10) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = var_320_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_11 and not isNil(var_320_10) then
				if arg_317_1.var_.characterEffect1084ui_story and not isNil(var_320_10) then
					arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_11)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_11 and arg_317_1.time_ < 0 + var_320_11 + arg_320_0 and not isNil(var_320_10) and arg_317_1.var_.characterEffect1084ui_story then
				arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_320_12 = 0
			local var_320_13 = 0.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_14 = arg_317_1:GetWordFromCfg(319341072)
				local var_320_15 = arg_317_1:FormatText(var_320_14.content)

				arg_317_1.text_.text = var_320_15

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_17 = 4 <= 0 and var_320_13 or var_320_13 * (utf8.len(var_320_15) / 4)

				if (4 <= 0 and var_320_13 or var_320_13 * (utf8.len(var_320_15) / 4)) > 0 and var_320_13 < var_320_17 then
					arg_317_1.talkMaxDuration = var_320_17

					if var_320_17 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_17 + var_320_12
					end
				end

				arg_317_1.text_.text = var_320_15
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341072", "story_v_out_319341.awb") ~= 0 then
					local var_320_18 = manager.audio:GetVoiceLength("story_v_out_319341", "319341072", "story_v_out_319341.awb") / 1000

					if var_320_18 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_18 + var_320_12
					end

					if var_320_14.prefab_name ~= "" and arg_317_1.actors_[var_320_14.prefab_name] ~= nil then
						local var_320_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_14.prefab_name].transform, "story_v_out_319341", "319341072", "story_v_out_319341.awb")

						arg_317_1:RecordAudio("319341072", var_320_19)
						arg_317_1:RecordAudio("319341072", var_320_19)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319341", "319341072", "story_v_out_319341.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319341", "319341072", "story_v_out_319341.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_20 = math.max(var_320_13, arg_317_1.talkMaxDuration)

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_20 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_12) / var_320_20

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_12 + var_320_20 and arg_317_1.time_ < var_320_12 + var_320_20 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play319341073 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 319341073
		arg_321_1.duration_ = 7.4

		local var_321_0 = {
			zh = 7.3,
			ja = 7.4
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play319341074(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10058ui_story"]) and arg_321_1.var_.characterEffect10058ui_story == nil then
				arg_321_1.var_.characterEffect10058ui_story = arg_321_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10058ui_story"]) then
				if arg_321_1.var_.characterEffect10058ui_story and not isNil(arg_321_1.actors_["10058ui_story"]) then
					arg_321_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10058ui_story"]) and arg_321_1.var_.characterEffect10058ui_story then
				arg_321_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_324_1 = arg_321_1.actors_["1084ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1084ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_324_4 = 0
			local var_324_5 = 0.9

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(319341073)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 36 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 36)

				if (36 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 36)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341073", "story_v_out_319341.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341073", "story_v_out_319341.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_319341", "319341073", "story_v_out_319341.awb")

						arg_321_1:RecordAudio("319341073", var_324_11)
						arg_321_1:RecordAudio("319341073", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_319341", "319341073", "story_v_out_319341.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_319341", "319341073", "story_v_out_319341.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play319341074 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 319341074
		arg_325_1.duration_ = 2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play319341075(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10058ui_story = arg_325_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).z)
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles = arg_325_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_325_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10058ui_story"].transform.position).z)
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10058ui_story"].transform.localEulerAngles = arg_325_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["10058ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10058ui_story == nil then
				arg_325_1.var_.characterEffect10058ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect10058ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10058ui_story then
				arg_325_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_328_4 = arg_325_1.actors_["1084ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1084ui_story == nil then
				arg_325_1.var_.characterEffect1084ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_5 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 and not isNil(var_328_4) then
				if arg_325_1.var_.characterEffect1084ui_story and not isNil(var_328_4) then
					arg_325_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_5)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1084ui_story then
				arg_325_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_328_6 = 0
			local var_328_7 = 0.05

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(319341074)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 2 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 2)

				if (2 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 2)) > 0 and var_328_7 < var_328_11 then
					arg_325_1.talkMaxDuration = var_328_11

					if var_328_11 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341074", "story_v_out_319341.awb") ~= 0 then
					local var_328_12 = manager.audio:GetVoiceLength("story_v_out_319341", "319341074", "story_v_out_319341.awb") / 1000

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_319341", "319341074", "story_v_out_319341.awb")

						arg_325_1:RecordAudio("319341074", var_328_13)
						arg_325_1:RecordAudio("319341074", var_328_13)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_319341", "319341074", "story_v_out_319341.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_319341", "319341074", "story_v_out_319341.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play319341075 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 319341075
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play319341076(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10058ui_story"]) and arg_329_1.var_.characterEffect10058ui_story == nil then
				arg_329_1.var_.characterEffect10058ui_story = arg_329_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10058ui_story"]) then
				if arg_329_1.var_.characterEffect10058ui_story and not isNil(arg_329_1.actors_["10058ui_story"]) then
					arg_329_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10058ui_story"]) and arg_329_1.var_.characterEffect10058ui_story then
				arg_329_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 1.2

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(319341075).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 48 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 48)

				if (48 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 48)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play319341076 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 319341076
		arg_333_1.duration_ = 8.7

		local var_333_0 = {
			zh = 7.766,
			ja = 8.7
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play319341077(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10058ui_story"]) and arg_333_1.var_.characterEffect10058ui_story == nil then
				arg_333_1.var_.characterEffect10058ui_story = arg_333_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10058ui_story"]) then
				if arg_333_1.var_.characterEffect10058ui_story and not isNil(arg_333_1.actors_["10058ui_story"]) then
					arg_333_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10058ui_story"]) and arg_333_1.var_.characterEffect10058ui_story then
				arg_333_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_336_2 = 0
			local var_336_3 = 0.9

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(319341076)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 36 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 36)

				if (36 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 36)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341076", "story_v_out_319341.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341076", "story_v_out_319341.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_out_319341", "319341076", "story_v_out_319341.awb")

						arg_333_1:RecordAudio("319341076", var_336_9)
						arg_333_1:RecordAudio("319341076", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_319341", "319341076", "story_v_out_319341.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_319341", "319341076", "story_v_out_319341.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play319341077 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 319341077
		arg_337_1.duration_ = 9.47

		local var_337_0 = {
			zh = 2.866,
			ja = 9.466
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play319341078(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["10058ui_story"]) and arg_337_1.var_.characterEffect10058ui_story == nil then
				arg_337_1.var_.characterEffect10058ui_story = arg_337_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["10058ui_story"]) then
				if arg_337_1.var_.characterEffect10058ui_story and not isNil(arg_337_1.actors_["10058ui_story"]) then
					arg_337_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["10058ui_story"]) and arg_337_1.var_.characterEffect10058ui_story then
				arg_337_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_340_1 = arg_337_1.actors_["1084ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1084ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_340_4 = 0
			local var_340_5 = 0.3

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(319341077)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 12)

				if (12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 12)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341077", "story_v_out_319341.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341077", "story_v_out_319341.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_319341", "319341077", "story_v_out_319341.awb")

						arg_337_1:RecordAudio("319341077", var_340_11)
						arg_337_1:RecordAudio("319341077", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_319341", "319341077", "story_v_out_319341.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_319341", "319341077", "story_v_out_319341.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play319341078 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 319341078
		arg_341_1.duration_ = 7.6

		local var_341_0 = {
			zh = 1.666,
			ja = 7.6
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play319341079(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["10058ui_story"]) and arg_341_1.var_.characterEffect10058ui_story == nil then
				arg_341_1.var_.characterEffect10058ui_story = arg_341_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["10058ui_story"]) then
				if arg_341_1.var_.characterEffect10058ui_story and not isNil(arg_341_1.actors_["10058ui_story"]) then
					arg_341_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["10058ui_story"]) and arg_341_1.var_.characterEffect10058ui_story then
				arg_341_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_344_1 = arg_341_1.actors_["1084ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1084ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_344_4 = 0
			local var_344_5 = 0.225

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(319341078)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 9 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 9)

				if (9 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 9)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341078", "story_v_out_319341.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341078", "story_v_out_319341.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_319341", "319341078", "story_v_out_319341.awb")

						arg_341_1:RecordAudio("319341078", var_344_11)
						arg_341_1:RecordAudio("319341078", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_319341", "319341078", "story_v_out_319341.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_319341", "319341078", "story_v_out_319341.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play319341079 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 319341079
		arg_345_1.duration_ = 6.2

		local var_345_0 = {
			zh = 1.999999999999,
			ja = 6.2
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play319341080(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1084ui_story = arg_345_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).z)
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles = arg_345_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_345_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).z)
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles = arg_345_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1084ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1084ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1084ui_story then
				arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_4 = 0
			local var_348_5 = 0.2

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(319341079)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 8 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 8)

				if (8 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 8)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341079", "story_v_out_319341.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341079", "story_v_out_319341.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_out_319341", "319341079", "story_v_out_319341.awb")

						arg_345_1:RecordAudio("319341079", var_348_11)
						arg_345_1:RecordAudio("319341079", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_319341", "319341079", "story_v_out_319341.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_319341", "319341079", "story_v_out_319341.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play319341080 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 319341080
		arg_349_1.duration_ = 17.23

		local var_349_0 = {
			zh = 14.1,
			ja = 17.233
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play319341081(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10058ui_story = arg_349_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).z)
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles = arg_349_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_349_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10058ui_story"].transform.position).z)
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10058ui_story"].transform.localEulerAngles = arg_349_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["10058ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10058ui_story == nil then
				arg_349_1.var_.characterEffect10058ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect10058ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10058ui_story then
				arg_349_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_352_4 = arg_349_1.actors_["1084ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_5 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_5 and not isNil(var_352_4) then
				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_4) then
					arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_5)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_5 and arg_349_1.time_ < 0 + var_352_5 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1084ui_story then
				arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_352_6 = 0
			local var_352_7 = 1.475

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:GetWordFromCfg(319341080)
				local var_352_9 = arg_349_1:FormatText(var_352_8.content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 59 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_9) / 59)

				if (59 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_9) / 59)) > 0 and var_352_7 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341080", "story_v_out_319341.awb") ~= 0 then
					local var_352_12 = manager.audio:GetVoiceLength("story_v_out_319341", "319341080", "story_v_out_319341.awb") / 1000

					if var_352_12 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_6
					end

					if var_352_8.prefab_name ~= "" and arg_349_1.actors_[var_352_8.prefab_name] ~= nil then
						local var_352_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_8.prefab_name].transform, "story_v_out_319341", "319341080", "story_v_out_319341.awb")

						arg_349_1:RecordAudio("319341080", var_352_13)
						arg_349_1:RecordAudio("319341080", var_352_13)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_319341", "319341080", "story_v_out_319341.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_319341", "319341080", "story_v_out_319341.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play319341081 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 319341081
		arg_353_1.duration_ = 9.13

		local var_353_0 = {
			zh = 5.333,
			ja = 9.133
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play319341082(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_356_0 = 0
			local var_356_1 = 0.925

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:GetWordFromCfg(319341081)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 37 <= 0 and var_356_1 or var_356_1 * (utf8.len(var_356_3) / 37)

				if (37 <= 0 and var_356_1 or var_356_1 * (utf8.len(var_356_3) / 37)) > 0 and var_356_1 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341081", "story_v_out_319341.awb") ~= 0 then
					local var_356_6 = manager.audio:GetVoiceLength("story_v_out_319341", "319341081", "story_v_out_319341.awb") / 1000

					if var_356_6 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_0
					end

					if var_356_2.prefab_name ~= "" and arg_353_1.actors_[var_356_2.prefab_name] ~= nil then
						local var_356_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_2.prefab_name].transform, "story_v_out_319341", "319341081", "story_v_out_319341.awb")

						arg_353_1:RecordAudio("319341081", var_356_7)
						arg_353_1:RecordAudio("319341081", var_356_7)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_319341", "319341081", "story_v_out_319341.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_319341", "319341081", "story_v_out_319341.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_8 and arg_353_1.time_ < var_356_0 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play319341082 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 319341082
		arg_357_1.duration_ = 2.13

		local var_357_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play319341083(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10058ui_story"]) and arg_357_1.var_.characterEffect10058ui_story == nil then
				arg_357_1.var_.characterEffect10058ui_story = arg_357_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10058ui_story"]) then
				if arg_357_1.var_.characterEffect10058ui_story and not isNil(arg_357_1.actors_["10058ui_story"]) then
					arg_357_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10058ui_story"]) and arg_357_1.var_.characterEffect10058ui_story then
				arg_357_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_360_1 = arg_357_1.actors_["1084ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1084ui_story == nil then
				arg_357_1.var_.characterEffect1084ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1084ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1084ui_story then
				arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_360_4 = 0
			local var_360_5 = 0.125

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(319341082)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 5 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 5)

				if (5 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 5)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341082", "story_v_out_319341.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341082", "story_v_out_319341.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_out_319341", "319341082", "story_v_out_319341.awb")

						arg_357_1:RecordAudio("319341082", var_360_11)
						arg_357_1:RecordAudio("319341082", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_319341", "319341082", "story_v_out_319341.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_319341", "319341082", "story_v_out_319341.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play319341083 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 319341083
		arg_361_1.duration_ = 10.6

		local var_361_0 = {
			zh = 4.6,
			ja = 10.6
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play319341084(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10058ui_story"]) and arg_361_1.var_.characterEffect10058ui_story == nil then
				arg_361_1.var_.characterEffect10058ui_story = arg_361_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10058ui_story"]) then
				if arg_361_1.var_.characterEffect10058ui_story and not isNil(arg_361_1.actors_["10058ui_story"]) then
					arg_361_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10058ui_story"]) and arg_361_1.var_.characterEffect10058ui_story then
				arg_361_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_364_2 = arg_361_1.actors_["1084ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = var_364_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_3 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.characterEffect1084ui_story and not isNil(var_364_2) then
					arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_3)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.characterEffect1084ui_story then
				arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_364_4 = 0
			local var_364_5 = 0.85

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_6 = arg_361_1:GetWordFromCfg(319341083)
				local var_364_7 = arg_361_1:FormatText(var_364_6.content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 34 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 34)

				if (34 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 34)) > 0 and var_364_5 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341083", "story_v_out_319341.awb") ~= 0 then
					local var_364_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341083", "story_v_out_319341.awb") / 1000

					if var_364_10 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_4
					end

					if var_364_6.prefab_name ~= "" and arg_361_1.actors_[var_364_6.prefab_name] ~= nil then
						local var_364_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_6.prefab_name].transform, "story_v_out_319341", "319341083", "story_v_out_319341.awb")

						arg_361_1:RecordAudio("319341083", var_364_11)
						arg_361_1:RecordAudio("319341083", var_364_11)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_319341", "319341083", "story_v_out_319341.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_319341", "319341083", "story_v_out_319341.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_12 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_12 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_12

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_12 and arg_361_1.time_ < var_364_4 + var_364_12 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play319341084 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 319341084
		arg_365_1.duration_ = 4.93

		local var_365_0 = {
			zh = 4.933,
			ja = 4.366
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play319341085(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.6

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(319341084)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 24 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 24)

				if (24 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 24)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341084", "story_v_out_319341.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341084", "story_v_out_319341.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_319341", "319341084", "story_v_out_319341.awb")

						arg_365_1:RecordAudio("319341084", var_368_6)
						arg_365_1:RecordAudio("319341084", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_319341", "319341084", "story_v_out_319341.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_319341", "319341084", "story_v_out_319341.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play319341085 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 319341085
		arg_369_1.duration_ = 7.97

		local var_369_0 = {
			zh = 3.066,
			ja = 7.966
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play319341086(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10058ui_story"]) and arg_369_1.var_.characterEffect10058ui_story == nil then
				arg_369_1.var_.characterEffect10058ui_story = arg_369_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10058ui_story"]) then
				if arg_369_1.var_.characterEffect10058ui_story and not isNil(arg_369_1.actors_["10058ui_story"]) then
					arg_369_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_369_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10058ui_story"]) and arg_369_1.var_.characterEffect10058ui_story then
				arg_369_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_369_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_372_1 = arg_369_1.actors_["1084ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1084ui_story == nil then
				arg_369_1.var_.characterEffect1084ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1084ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1084ui_story then
				arg_369_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_372_4 = 0
			local var_372_5 = 0.3

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:GetWordFromCfg(319341085)
				local var_372_7 = arg_369_1:FormatText(var_372_6.content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 12 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 12)

				if (12 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 12)) > 0 and var_372_5 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341085", "story_v_out_319341.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341085", "story_v_out_319341.awb") / 1000

					if var_372_10 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_4
					end

					if var_372_6.prefab_name ~= "" and arg_369_1.actors_[var_372_6.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_6.prefab_name].transform, "story_v_out_319341", "319341085", "story_v_out_319341.awb")

						arg_369_1:RecordAudio("319341085", var_372_11)
						arg_369_1:RecordAudio("319341085", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_319341", "319341085", "story_v_out_319341.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_319341", "319341085", "story_v_out_319341.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_12 and arg_369_1.time_ < var_372_4 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play319341086 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 319341086
		arg_373_1.duration_ = 9.43

		local var_373_0 = {
			zh = 4.466,
			ja = 9.433
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play319341087(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10058ui_story = arg_373_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).z)
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles = arg_373_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_373_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10058ui_story"].transform.position).z)
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10058ui_story"].transform.localEulerAngles = arg_373_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10058ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10058ui_story == nil then
				arg_373_1.var_.characterEffect10058ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10058ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10058ui_story then
				arg_373_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_376_4 = arg_373_1.actors_["1084ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect1084ui_story == nil then
				arg_373_1.var_.characterEffect1084ui_story = var_376_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_5 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_5 and not isNil(var_376_4) then
				if arg_373_1.var_.characterEffect1084ui_story and not isNil(var_376_4) then
					arg_373_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_5)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_5 and arg_373_1.time_ < 0 + var_376_5 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect1084ui_story then
				arg_373_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_6 = 0
			local var_376_7 = 0.55

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(319341086)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 22 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 22)

				if (22 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 22)) > 0 and var_376_7 < var_376_11 then
					arg_373_1.talkMaxDuration = var_376_11

					if var_376_11 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341086", "story_v_out_319341.awb") ~= 0 then
					local var_376_12 = manager.audio:GetVoiceLength("story_v_out_319341", "319341086", "story_v_out_319341.awb") / 1000

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end

					if var_376_8.prefab_name ~= "" and arg_373_1.actors_[var_376_8.prefab_name] ~= nil then
						local var_376_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_8.prefab_name].transform, "story_v_out_319341", "319341086", "story_v_out_319341.awb")

						arg_373_1:RecordAudio("319341086", var_376_13)
						arg_373_1:RecordAudio("319341086", var_376_13)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_319341", "319341086", "story_v_out_319341.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_319341", "319341086", "story_v_out_319341.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play319341087 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 319341087
		arg_377_1.duration_ = 4.07

		local var_377_0 = {
			zh = 1.999999999999,
			ja = 4.066
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play319341088(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["10058ui_story"]) and arg_377_1.var_.characterEffect10058ui_story == nil then
				arg_377_1.var_.characterEffect10058ui_story = arg_377_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["10058ui_story"]) then
				if arg_377_1.var_.characterEffect10058ui_story and not isNil(arg_377_1.actors_["10058ui_story"]) then
					arg_377_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_377_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["10058ui_story"]) and arg_377_1.var_.characterEffect10058ui_story then
				arg_377_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_377_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_380_1 = arg_377_1.actors_["1084ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1084ui_story == nil then
				arg_377_1.var_.characterEffect1084ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1084ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1084ui_story then
				arg_377_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.075

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(319341087)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 3 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 3)

				if (3 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 3)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341087", "story_v_out_319341.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341087", "story_v_out_319341.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_out_319341", "319341087", "story_v_out_319341.awb")

						arg_377_1:RecordAudio("319341087", var_380_11)
						arg_377_1:RecordAudio("319341087", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_319341", "319341087", "story_v_out_319341.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_319341", "319341087", "story_v_out_319341.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play319341088 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 319341088
		arg_381_1.duration_ = 10.87

		local var_381_0 = {
			zh = 8.9,
			ja = 10.866
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play319341089(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10058ui_story"]) and arg_381_1.var_.characterEffect10058ui_story == nil then
				arg_381_1.var_.characterEffect10058ui_story = arg_381_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10058ui_story"]) then
				if arg_381_1.var_.characterEffect10058ui_story and not isNil(arg_381_1.actors_["10058ui_story"]) then
					arg_381_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10058ui_story"]) and arg_381_1.var_.characterEffect10058ui_story then
				arg_381_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_384_2 = arg_381_1.actors_["1084ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect1084ui_story == nil then
				arg_381_1.var_.characterEffect1084ui_story = var_384_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_3 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.characterEffect1084ui_story and not isNil(var_384_2) then
					arg_381_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_3)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect1084ui_story then
				arg_381_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_384_4 = 0
			local var_384_5 = 0.975

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(319341088)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 39 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 39)

				if (39 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 39)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341088", "story_v_out_319341.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341088", "story_v_out_319341.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_out_319341", "319341088", "story_v_out_319341.awb")

						arg_381_1:RecordAudio("319341088", var_384_11)
						arg_381_1:RecordAudio("319341088", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_319341", "319341088", "story_v_out_319341.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_319341", "319341088", "story_v_out_319341.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play319341089 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 319341089
		arg_385_1.duration_ = 5.37

		local var_385_0 = {
			zh = 2.9,
			ja = 5.366
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play319341090(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10058ui_story"]) and arg_385_1.var_.characterEffect10058ui_story == nil then
				arg_385_1.var_.characterEffect10058ui_story = arg_385_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10058ui_story"]) then
				if arg_385_1.var_.characterEffect10058ui_story and not isNil(arg_385_1.actors_["10058ui_story"]) then
					arg_385_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_385_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10058ui_story"]) and arg_385_1.var_.characterEffect10058ui_story then
				arg_385_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_385_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_388_1 = arg_385_1.actors_["1084ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1084ui_story == nil then
				arg_385_1.var_.characterEffect1084ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1084ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1084ui_story then
				arg_385_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_388_4 = 0
			local var_388_5 = 0.15

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(319341089)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 6 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 6)

				if (6 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 6)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341089", "story_v_out_319341.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341089", "story_v_out_319341.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_out_319341", "319341089", "story_v_out_319341.awb")

						arg_385_1:RecordAudio("319341089", var_388_11)
						arg_385_1:RecordAudio("319341089", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_319341", "319341089", "story_v_out_319341.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_319341", "319341089", "story_v_out_319341.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play319341090 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 319341090
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play319341091(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = arg_389_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) then
				if arg_389_1.var_.characterEffect1084ui_story and not isNil(arg_389_1.actors_["1084ui_story"]) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.95

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(319341090).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 38 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 38)

				if (38 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 38)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play319341091 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 319341091
		arg_393_1.duration_ = 10.17

		local var_393_0 = {
			zh = 4.266,
			ja = 10.166
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play319341092(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10058ui_story"]) and arg_393_1.var_.characterEffect10058ui_story == nil then
				arg_393_1.var_.characterEffect10058ui_story = arg_393_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10058ui_story"]) then
				if arg_393_1.var_.characterEffect10058ui_story and not isNil(arg_393_1.actors_["10058ui_story"]) then
					arg_393_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10058ui_story"]) and arg_393_1.var_.characterEffect10058ui_story then
				arg_393_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_2 = 0
			local var_396_3 = 0.5

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:GetWordFromCfg(319341091)
				local var_396_5 = arg_393_1:FormatText(var_396_4.content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 20 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 20)

				if (20 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 20)) > 0 and var_396_3 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341091", "story_v_out_319341.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341091", "story_v_out_319341.awb") / 1000

					if var_396_8 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_2
					end

					if var_396_4.prefab_name ~= "" and arg_393_1.actors_[var_396_4.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_4.prefab_name].transform, "story_v_out_319341", "319341091", "story_v_out_319341.awb")

						arg_393_1:RecordAudio("319341091", var_396_9)
						arg_393_1:RecordAudio("319341091", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_319341", "319341091", "story_v_out_319341.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_319341", "319341091", "story_v_out_319341.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_10 and arg_393_1.time_ < var_396_2 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play319341092 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 319341092
		arg_397_1.duration_ = 5.57

		local var_397_0 = {
			zh = 2.5,
			ja = 5.566
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play319341093(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10058ui_story"]) and arg_397_1.var_.characterEffect10058ui_story == nil then
				arg_397_1.var_.characterEffect10058ui_story = arg_397_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10058ui_story"]) then
				if arg_397_1.var_.characterEffect10058ui_story and not isNil(arg_397_1.actors_["10058ui_story"]) then
					arg_397_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_397_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10058ui_story"]) and arg_397_1.var_.characterEffect10058ui_story then
				arg_397_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_397_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_400_1 = arg_397_1.actors_["1084ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1084ui_story == nil then
				arg_397_1.var_.characterEffect1084ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1084ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1084ui_story then
				arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			local var_400_4 = 0
			local var_400_5 = 0.2

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_6 = arg_397_1:GetWordFromCfg(319341092)
				local var_400_7 = arg_397_1:FormatText(var_400_6.content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 8 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 8)

				if (8 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 8)) > 0 and var_400_5 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_4
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341092", "story_v_out_319341.awb") ~= 0 then
					local var_400_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341092", "story_v_out_319341.awb") / 1000

					if var_400_10 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_4
					end

					if var_400_6.prefab_name ~= "" and arg_397_1.actors_[var_400_6.prefab_name] ~= nil then
						local var_400_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_6.prefab_name].transform, "story_v_out_319341", "319341092", "story_v_out_319341.awb")

						arg_397_1:RecordAudio("319341092", var_400_11)
						arg_397_1:RecordAudio("319341092", var_400_11)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_319341", "319341092", "story_v_out_319341.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_319341", "319341092", "story_v_out_319341.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_12 = math.max(var_400_5, arg_397_1.talkMaxDuration)

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_12 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_4) / var_400_12

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_4 + var_400_12 and arg_397_1.time_ < var_400_4 + var_400_12 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play319341093 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 319341093
		arg_401_1.duration_ = 4.33

		local var_401_0 = {
			zh = 3.033,
			ja = 4.333
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play319341094(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10058ui_story"]) and arg_401_1.var_.characterEffect10058ui_story == nil then
				arg_401_1.var_.characterEffect10058ui_story = arg_401_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10058ui_story"]) then
				if arg_401_1.var_.characterEffect10058ui_story and not isNil(arg_401_1.actors_["10058ui_story"]) then
					arg_401_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10058ui_story"]) and arg_401_1.var_.characterEffect10058ui_story then
				arg_401_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_404_2 = arg_401_1.actors_["1084ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.characterEffect1084ui_story == nil then
				arg_401_1.var_.characterEffect1084ui_story = var_404_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_3 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 and not isNil(var_404_2) then
				if arg_401_1.var_.characterEffect1084ui_story and not isNil(var_404_2) then
					arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_3)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.characterEffect1084ui_story then
				arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_404_4 = 0
			local var_404_5 = 0.425

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(319341093)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 17 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 17)

				if (17 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 17)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341093", "story_v_out_319341.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341093", "story_v_out_319341.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_out_319341", "319341093", "story_v_out_319341.awb")

						arg_401_1:RecordAudio("319341093", var_404_11)
						arg_401_1:RecordAudio("319341093", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_319341", "319341093", "story_v_out_319341.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_319341", "319341093", "story_v_out_319341.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play319341094 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 319341094
		arg_405_1.duration_ = 2.43

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play319341095(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10058ui_story = arg_405_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).z)
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles = arg_405_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10058ui_story"].transform.position).z)
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["10058ui_story"].transform.localEulerAngles = arg_405_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				local var_408_1 = arg_405_1.bgs_.STblack

				arg_405_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_408_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_2 = var_408_1:GetComponent("SpriteRenderer")

				if var_408_2 and var_408_2.sprite then
					local var_408_3 = 2 * (var_408_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_408_1.transform.localScale = Vector3.New(var_408_3 / var_408_2.sprite.bounds.size.y < var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x and var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x or var_408_3 / var_408_2.sprite.bounds.size.y, var_408_3 / var_408_2.sprite.bounds.size.y < var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x and var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x or var_408_3 / var_408_2.sprite.bounds.size.y, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "STblack" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_4 = arg_405_1.actors_["1084ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1084ui_story = var_408_4.localPosition
			end

			local var_408_5 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 then
				var_408_4.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_5)
				var_408_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_4.position).x, (manager.ui.mainCamera.transform.position - var_408_4.position).y, (manager.ui.mainCamera.transform.position - var_408_4.position).z)
				var_408_4.localEulerAngles.z = 0
				var_408_4.localEulerAngles.x = 0
				var_408_4.localEulerAngles = var_408_4.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 then
				var_408_4.localPosition = Vector3.New(0, 100, 0)
				var_408_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_4.position).x, (manager.ui.mainCamera.transform.position - var_408_4.position).y, (manager.ui.mainCamera.transform.position - var_408_4.position).z)
				var_408_4.localEulerAngles.z = 0
				var_408_4.localEulerAngles.x = 0
				var_408_4.localEulerAngles = var_408_4.localEulerAngles
			end

			if 4.44089209850063e-16 < arg_405_1.time_ and arg_405_1.time_ <= 4.44089209850063e-16 + arg_408_0 then
				local var_408_6 = arg_405_1.fswbg_.transform:Find("textbox/adapt/content") or arg_405_1.fswbg_.transform:Find("textbox/content")
				local var_408_7 = arg_405_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_408_8 = var_408_6:GetComponent("RectTransform")

				var_408_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_408_8.offsetMin = Vector2.New(0, 0)
				var_408_8.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.fswbg_:SetActive(true)
				arg_405_1.dialog_:SetActive(false)

				arg_405_1.fswtw_.percent = 0
				arg_405_1.fswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(319341094).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.fswt_)

				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_405_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_405_1.fswtw_:SetDirty()

				arg_405_1.typewritterCharCountI18N = 0

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_9 = 0.333333333333333

			if 0.333333333333333 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				arg_405_1.var_.oldValueTypewriter = arg_405_1.fswtw_.percent

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_10 = 10
			local var_408_11 = 0.666666666666667
			local var_408_12, var_408_13 = arg_405_1:GetPercentByPara(arg_405_1:FormatText(arg_405_1:GetWordFromCfg(319341094).content), 1)

			if var_408_9 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				local var_408_14 = var_408_10 <= 0 and var_408_11 or var_408_11 * ((var_408_13 - arg_405_1.typewritterCharCountI18N) / var_408_10)

				if (var_408_10 <= 0 and var_408_11 or var_408_11 * ((var_408_13 - arg_405_1.typewritterCharCountI18N) / var_408_10)) > 0 and var_408_11 < var_408_14 then
					arg_405_1.talkMaxDuration = var_408_14

					if var_408_14 + var_408_9 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_9
					end
				end
			end

			local var_408_15 = math.max(0.666666666666667, arg_405_1.talkMaxDuration)

			if var_408_9 <= arg_405_1.time_ and arg_405_1.time_ < var_408_9 + var_408_15 then
				arg_405_1.fswtw_.percent = Mathf.Lerp(arg_405_1.var_.oldValueTypewriter, var_408_12, (arg_405_1.time_ - var_408_9) / var_408_15)
				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.fswtw_:SetDirty()
			end

			if arg_405_1.time_ >= var_408_9 + var_408_15 and arg_405_1.time_ < var_408_9 + var_408_15 + arg_408_0 then
				arg_405_1.fswtw_.percent = var_408_12

				arg_405_1.fswtw_:SetDirty()
				arg_405_1:ShowNextGo(true)

				arg_405_1.typewritterCharCountI18N = var_408_13
			end

			if 4.44089209850063e-16 < arg_405_1.time_ and arg_405_1.time_ <= 4.44089209850063e-16 + arg_408_0 then
				arg_405_1.cswbg_:SetActive(true)

				local var_408_16 = arg_405_1.cswt_:GetComponent("RectTransform")

				arg_405_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_408_16.offsetMin = Vector2.New(410, 330)
				var_408_16.offsetMax = Vector2.New(-400, -175)
				arg_405_1.cswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(419012).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.cswt_)

				arg_405_1.cswt_.fontSize = 180
				arg_405_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_405_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_408_17 = 0.333333333333333
			local var_408_18 = manager.audio:GetVoiceLength("story_v_out_319341", "319341094", "story_v_out_319341.awb") / 1000

			if var_408_18 > 0 and 2.1 < var_408_18 and var_408_18 + var_408_17 > arg_405_1.duration_ then
				arg_405_1.duration_ = var_408_18 + var_408_17
			end

			if var_408_17 < arg_405_1.time_ and arg_405_1.time_ <= var_408_17 + arg_408_0 then
				arg_405_1:AudioAction("play", "voice", "story_v_out_319341", "319341094", "story_v_out_319341.awb")
			end
		end

		arg_405_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play319341095 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 319341095
		arg_409_1.duration_ = 1.4

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play319341096(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.fswbg_:SetActive(true)
				arg_409_1.dialog_:SetActive(false)

				arg_409_1.fswtw_.percent = 0
				arg_409_1.fswt_.text = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(319341095).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.fswt_)

				arg_409_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_409_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_409_1.fswtw_:SetDirty()

				arg_409_1.typewritterCharCountI18N = 0

				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			local var_412_0 = 0.1

			if 0.1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.var_.oldValueTypewriter = arg_409_1.fswtw_.percent

				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			local var_412_1 = 4
			local var_412_2 = 0.266666666666667
			local var_412_3, var_412_4 = arg_409_1:GetPercentByPara(arg_409_1:FormatText(arg_409_1:GetWordFromCfg(319341095).content), 1)

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				local var_412_5 = var_412_1 <= 0 and var_412_2 or var_412_2 * ((var_412_4 - arg_409_1.typewritterCharCountI18N) / var_412_1)

				if (var_412_1 <= 0 and var_412_2 or var_412_2 * ((var_412_4 - arg_409_1.typewritterCharCountI18N) / var_412_1)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_0
					end
				end
			end

			local var_412_6 = math.max(0.266666666666667, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_6 then
				arg_409_1.fswtw_.percent = Mathf.Lerp(arg_409_1.var_.oldValueTypewriter, var_412_3, (arg_409_1.time_ - var_412_0) / var_412_6)
				arg_409_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_409_1.fswtw_:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_6 and arg_409_1.time_ < var_412_0 + var_412_6 + arg_412_0 then
				arg_409_1.fswtw_.percent = var_412_3

				arg_409_1.fswtw_:SetDirty()
				arg_409_1:ShowNextGo(true)

				arg_409_1.typewritterCharCountI18N = var_412_4
			end

			local var_412_7 = 0.1
			local var_412_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341095", "story_v_out_319341.awb") / 1000

			if var_412_8 > 0 and 1.3 < var_412_8 and var_412_8 + var_412_7 > arg_409_1.duration_ then
				arg_409_1.duration_ = var_412_8 + var_412_7
			end

			if var_412_7 < arg_409_1.time_ and arg_409_1.time_ <= var_412_7 + arg_412_0 then
				arg_409_1:AudioAction("play", "voice", "story_v_out_319341", "319341095", "story_v_out_319341.awb")
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play319341096 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 319341096
		arg_413_1.duration_ = 13.97

		local var_413_0 = {
			zh = 12.366,
			ja = 13.966
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play319341097(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				local var_416_0 = arg_413_1.bgs_.I11o

				arg_413_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_416_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_1 = var_416_0:GetComponent("SpriteRenderer")

				if var_416_1 and var_416_1.sprite then
					local var_416_2 = 2 * (var_416_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_416_0.transform.localScale = Vector3.New(var_416_2 / var_416_1.sprite.bounds.size.y < var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x and var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x or var_416_2 / var_416_1.sprite.bounds.size.y, var_416_2 / var_416_1.sprite.bounds.size.y < var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x and var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x or var_416_2 / var_416_1.sprite.bounds.size.y, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "I11o" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_3 = arg_413_1.actors_["1084ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1084ui_story == nil then
				arg_413_1.var_.characterEffect1084ui_story = var_416_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_4 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 and not isNil(var_416_3) then
				if arg_413_1.var_.characterEffect1084ui_story and not isNil(var_416_3) then
					arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_4)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1084ui_story then
				arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_416_5 = arg_413_1.actors_["10058ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.characterEffect10058ui_story == nil then
				arg_413_1.var_.characterEffect10058ui_story = var_416_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_6 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_6 and not isNil(var_416_5) then
				if arg_413_1.var_.characterEffect10058ui_story and not isNil(var_416_5) then
					arg_413_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_6 and arg_413_1.time_ < 0 + var_416_6 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.characterEffect10058ui_story then
				arg_413_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.fswbg_:SetActive(false)
				arg_413_1.dialog_:SetActive(false)
				SetActive(arg_413_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_413_1:ShowNextGo(false)
			end

			if 0.233333333333334 < arg_413_1.time_ and arg_413_1.time_ <= 0.233333333333334 + arg_416_0 then
				arg_413_1.fswbg_:SetActive(false)
				arg_413_1.dialog_:SetActive(false)
				SetActive(arg_413_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_413_1:ShowNextGo(false)
			end

			if 4.44089209850063e-16 < arg_413_1.time_ and arg_413_1.time_ <= 4.44089209850063e-16 + arg_416_0 then
				arg_413_1.cswbg_:SetActive(false)
			end

			local var_416_8 = arg_413_1.actors_["10058ui_story"].transform

			if 1.46666666666667 < arg_413_1.time_ and arg_413_1.time_ <= 1.46666666666667 + arg_416_0 then
				arg_413_1.var_.moveOldPos10058ui_story = var_416_8.localPosition
			end

			local var_416_9 = 0.001

			if 1.46666666666667 <= arg_413_1.time_ and arg_413_1.time_ < 1.46666666666667 + var_416_9 then
				var_416_8.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_413_1.time_ - 1.46666666666667) / var_416_9)
				var_416_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_8.position).x, (manager.ui.mainCamera.transform.position - var_416_8.position).y, (manager.ui.mainCamera.transform.position - var_416_8.position).z)
				var_416_8.localEulerAngles.z = 0
				var_416_8.localEulerAngles.x = 0
				var_416_8.localEulerAngles = var_416_8.localEulerAngles
			end

			if arg_413_1.time_ >= 1.46666666666667 + var_416_9 and arg_413_1.time_ < 1.46666666666667 + var_416_9 + arg_416_0 then
				var_416_8.localPosition = Vector3.New(0, -0.98, -6.1)
				var_416_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_8.position).x, (manager.ui.mainCamera.transform.position - var_416_8.position).y, (manager.ui.mainCamera.transform.position - var_416_8.position).z)
				var_416_8.localEulerAngles.z = 0
				var_416_8.localEulerAngles.x = 0
				var_416_8.localEulerAngles = var_416_8.localEulerAngles
			end

			local var_416_10 = arg_413_1.actors_["10058ui_story"]

			if 1.46666666666667 < arg_413_1.time_ and arg_413_1.time_ <= 1.46666666666667 + arg_416_0 and not isNil(var_416_10) and arg_413_1.var_.characterEffect10058ui_story == nil then
				arg_413_1.var_.characterEffect10058ui_story = var_416_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if 1.46666666666667 <= arg_413_1.time_ and arg_413_1.time_ < 1.46666666666667 + var_416_11 and not isNil(var_416_10) then
				if arg_413_1.var_.characterEffect10058ui_story and not isNil(var_416_10) then
					arg_413_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 1.46666666666667 + var_416_11 and arg_413_1.time_ < 1.46666666666667 + var_416_11 + arg_416_0 and not isNil(var_416_10) and arg_413_1.var_.characterEffect10058ui_story then
				arg_413_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 1.46666666666667 < arg_413_1.time_ and arg_413_1.time_ <= 1.46666666666667 + arg_416_0 then
				arg_413_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_13 = 1.3
			local var_416_14 = 1.35

			if 1.3 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_15 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_15:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_16 = arg_413_1:GetWordFromCfg(319341096)
				local var_416_17 = arg_413_1:FormatText(var_416_16.content)

				arg_413_1.text_.text = var_416_17

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_19 = 54 <= 0 and var_416_14 or var_416_14 * (utf8.len(var_416_17) / 54)

				if (54 <= 0 and var_416_14 or var_416_14 * (utf8.len(var_416_17) / 54)) > 0 and var_416_14 < var_416_19 then
					arg_413_1.talkMaxDuration = var_416_19
					var_416_13 = var_416_13 + 0.3

					if var_416_19 + var_416_13 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_19 + var_416_13
					end
				end

				arg_413_1.text_.text = var_416_17
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341096", "story_v_out_319341.awb") ~= 0 then
					local var_416_20 = manager.audio:GetVoiceLength("story_v_out_319341", "319341096", "story_v_out_319341.awb") / 1000

					if var_416_20 + var_416_13 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_20 + var_416_13
					end

					if var_416_16.prefab_name ~= "" and arg_413_1.actors_[var_416_16.prefab_name] ~= nil then
						local var_416_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_16.prefab_name].transform, "story_v_out_319341", "319341096", "story_v_out_319341.awb")

						arg_413_1:RecordAudio("319341096", var_416_21)
						arg_413_1:RecordAudio("319341096", var_416_21)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_319341", "319341096", "story_v_out_319341.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_319341", "319341096", "story_v_out_319341.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_22 = var_416_13 + 0.3
			local var_416_23 = math.max(var_416_14, arg_413_1.talkMaxDuration)

			if var_416_13 + 0.3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_22 + var_416_23 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_22) / var_416_23

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_22 + var_416_23 and arg_413_1.time_ < var_416_22 + var_416_23 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play319341097 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 319341097
		arg_419_1.duration_ = 10.6

		local var_419_0 = {
			zh = 5.8,
			ja = 10.6
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play319341098(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.675

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:GetWordFromCfg(319341097)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)

				if (27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341097", "story_v_out_319341.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341097", "story_v_out_319341.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_319341", "319341097", "story_v_out_319341.awb")

						arg_419_1:RecordAudio("319341097", var_422_6)
						arg_419_1:RecordAudio("319341097", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_319341", "319341097", "story_v_out_319341.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_319341", "319341097", "story_v_out_319341.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play319341098 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 319341098
		arg_423_1.duration_ = 2.67

		local var_423_0 = {
			zh = 1.999999999999,
			ja = 2.666
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play319341099(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["10058ui_story"]) and arg_423_1.var_.characterEffect10058ui_story == nil then
				arg_423_1.var_.characterEffect10058ui_story = arg_423_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["10058ui_story"]) then
				if arg_423_1.var_.characterEffect10058ui_story and not isNil(arg_423_1.actors_["10058ui_story"]) then
					arg_423_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_423_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["10058ui_story"]) and arg_423_1.var_.characterEffect10058ui_story then
				arg_423_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_423_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_426_1 = arg_423_1.actors_["1084ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1084ui_story == nil then
				arg_423_1.var_.characterEffect1084ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1084ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1084ui_story then
				arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_426_4 = arg_423_1.actors_["1084ui_story"].transform

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1084ui_story = var_426_4.localPosition
			end

			local var_426_5 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_5 then
				var_426_4.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_423_1.time_ - 0) / var_426_5)
				var_426_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_4.position).x, (manager.ui.mainCamera.transform.position - var_426_4.position).y, (manager.ui.mainCamera.transform.position - var_426_4.position).z)
				var_426_4.localEulerAngles.z = 0
				var_426_4.localEulerAngles.x = 0
				var_426_4.localEulerAngles = var_426_4.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_5 and arg_423_1.time_ < 0 + var_426_5 + arg_426_0 then
				var_426_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_426_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_4.position).x, (manager.ui.mainCamera.transform.position - var_426_4.position).y, (manager.ui.mainCamera.transform.position - var_426_4.position).z)
				var_426_4.localEulerAngles.z = 0
				var_426_4.localEulerAngles.x = 0
				var_426_4.localEulerAngles = var_426_4.localEulerAngles
			end

			local var_426_6 = arg_423_1.actors_["10058ui_story"].transform

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos10058ui_story = var_426_6.localPosition
			end

			local var_426_7 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				var_426_6.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_423_1.time_ - 0) / var_426_7)
				var_426_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_6.position).x, (manager.ui.mainCamera.transform.position - var_426_6.position).y, (manager.ui.mainCamera.transform.position - var_426_6.position).z)
				var_426_6.localEulerAngles.z = 0
				var_426_6.localEulerAngles.x = 0
				var_426_6.localEulerAngles = var_426_6.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				var_426_6.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_426_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_6.position).x, (manager.ui.mainCamera.transform.position - var_426_6.position).y, (manager.ui.mainCamera.transform.position - var_426_6.position).z)
				var_426_6.localEulerAngles.z = 0
				var_426_6.localEulerAngles.x = 0
				var_426_6.localEulerAngles = var_426_6.localEulerAngles
			end

			local var_426_8 = 0
			local var_426_9 = 0.075

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_10 = arg_423_1:GetWordFromCfg(319341098)
				local var_426_11 = arg_423_1:FormatText(var_426_10.content)

				arg_423_1.text_.text = var_426_11

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_13 = 3 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 3)

				if (3 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 3)) > 0 and var_426_9 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_8
					end
				end

				arg_423_1.text_.text = var_426_11
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341098", "story_v_out_319341.awb") ~= 0 then
					local var_426_14 = manager.audio:GetVoiceLength("story_v_out_319341", "319341098", "story_v_out_319341.awb") / 1000

					if var_426_14 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_14 + var_426_8
					end

					if var_426_10.prefab_name ~= "" and arg_423_1.actors_[var_426_10.prefab_name] ~= nil then
						local var_426_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_10.prefab_name].transform, "story_v_out_319341", "319341098", "story_v_out_319341.awb")

						arg_423_1:RecordAudio("319341098", var_426_15)
						arg_423_1:RecordAudio("319341098", var_426_15)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_319341", "319341098", "story_v_out_319341.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_319341", "319341098", "story_v_out_319341.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_16 = math.max(var_426_9, arg_423_1.talkMaxDuration)

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_16 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_8) / var_426_16

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_8 + var_426_16 and arg_423_1.time_ < var_426_8 + var_426_16 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play319341099 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 319341099
		arg_427_1.duration_ = 13.8

		local var_427_0 = {
			zh = 13.8,
			ja = 12.666
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play319341100(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["10058ui_story"]) and arg_427_1.var_.characterEffect10058ui_story == nil then
				arg_427_1.var_.characterEffect10058ui_story = arg_427_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["10058ui_story"]) then
				if arg_427_1.var_.characterEffect10058ui_story and not isNil(arg_427_1.actors_["10058ui_story"]) then
					arg_427_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["10058ui_story"]) and arg_427_1.var_.characterEffect10058ui_story then
				arg_427_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_430_2 = arg_427_1.actors_["1084ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect1084ui_story == nil then
				arg_427_1.var_.characterEffect1084ui_story = var_430_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_3 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_3 and not isNil(var_430_2) then
				if arg_427_1.var_.characterEffect1084ui_story and not isNil(var_430_2) then
					arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_3)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_3 and arg_427_1.time_ < 0 + var_430_3 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect1084ui_story then
				arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_430_4 = 0
			local var_430_5 = 1.5

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(319341099)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 60 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 60)

				if (60 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 60)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341099", "story_v_out_319341.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341099", "story_v_out_319341.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_out_319341", "319341099", "story_v_out_319341.awb")

						arg_427_1:RecordAudio("319341099", var_430_11)
						arg_427_1:RecordAudio("319341099", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_319341", "319341099", "story_v_out_319341.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_319341", "319341099", "story_v_out_319341.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play319341100 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 319341100
		arg_431_1.duration_ = 10.73

		local var_431_0 = {
			zh = 8.6,
			ja = 10.733
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play319341101(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["10058ui_story"]) and arg_431_1.var_.characterEffect10058ui_story == nil then
				arg_431_1.var_.characterEffect10058ui_story = arg_431_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["10058ui_story"]) then
				if arg_431_1.var_.characterEffect10058ui_story and not isNil(arg_431_1.actors_["10058ui_story"]) then
					arg_431_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_431_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["10058ui_story"]) and arg_431_1.var_.characterEffect10058ui_story then
				arg_431_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_431_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_434_1 = arg_431_1.actors_["1084ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1084ui_story == nil then
				arg_431_1.var_.characterEffect1084ui_story = var_434_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 and not isNil(var_434_1) then
				if arg_431_1.var_.characterEffect1084ui_story and not isNil(var_434_1) then
					arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1084ui_story then
				arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_434_4 = 0
			local var_434_5 = 0.875

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(319341100)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 35 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 35)

				if (35 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 35)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341100", "story_v_out_319341.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341100", "story_v_out_319341.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_out_319341", "319341100", "story_v_out_319341.awb")

						arg_431_1:RecordAudio("319341100", var_434_11)
						arg_431_1:RecordAudio("319341100", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_319341", "319341100", "story_v_out_319341.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_319341", "319341100", "story_v_out_319341.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play319341101 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 319341101
		arg_435_1.duration_ = 1.53

		local var_435_0 = {
			zh = 1.033,
			ja = 1.533
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play319341102(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["10058ui_story"]) and arg_435_1.var_.characterEffect10058ui_story == nil then
				arg_435_1.var_.characterEffect10058ui_story = arg_435_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["10058ui_story"]) then
				if arg_435_1.var_.characterEffect10058ui_story and not isNil(arg_435_1.actors_["10058ui_story"]) then
					arg_435_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["10058ui_story"]) and arg_435_1.var_.characterEffect10058ui_story then
				arg_435_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_438_2 = arg_435_1.actors_["1084ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.characterEffect1084ui_story == nil then
				arg_435_1.var_.characterEffect1084ui_story = var_438_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_3 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_3 and not isNil(var_438_2) then
				if arg_435_1.var_.characterEffect1084ui_story and not isNil(var_438_2) then
					arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_3)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_3 and arg_435_1.time_ < 0 + var_438_3 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.characterEffect1084ui_story then
				arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_438_4 = 0
			local var_438_5 = 0.05

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(319341101)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 2 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 2)

				if (2 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 2)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341101", "story_v_out_319341.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341101", "story_v_out_319341.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_out_319341", "319341101", "story_v_out_319341.awb")

						arg_435_1:RecordAudio("319341101", var_438_11)
						arg_435_1:RecordAudio("319341101", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_319341", "319341101", "story_v_out_319341.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_319341", "319341101", "story_v_out_319341.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play319341102 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 319341102
		arg_439_1.duration_ = 3.73

		local var_439_0 = {
			zh = 2.133,
			ja = 3.733
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play319341103(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1084ui_story = arg_439_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).z)
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles = arg_439_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_439_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).z)
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles = arg_439_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_442_1 = arg_439_1.actors_["10058ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect10058ui_story == nil then
				arg_439_1.var_.characterEffect10058ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect10058ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_439_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_2)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect10058ui_story then
				arg_439_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_439_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_442_3 = arg_439_1.actors_["1084ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1084ui_story == nil then
				arg_439_1.var_.characterEffect1084ui_story = var_442_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_4 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 and not isNil(var_442_3) then
				if arg_439_1.var_.characterEffect1084ui_story and not isNil(var_442_3) then
					arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1084ui_story then
				arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_442_6 = 0
			local var_442_7 = 0.2

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_8 = arg_439_1:GetWordFromCfg(319341102)
				local var_442_9 = arg_439_1:FormatText(var_442_8.content)

				arg_439_1.text_.text = var_442_9

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 8 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 8)

				if (8 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 8)) > 0 and var_442_7 < var_442_11 then
					arg_439_1.talkMaxDuration = var_442_11

					if var_442_11 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_11 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_9
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341102", "story_v_out_319341.awb") ~= 0 then
					local var_442_12 = manager.audio:GetVoiceLength("story_v_out_319341", "319341102", "story_v_out_319341.awb") / 1000

					if var_442_12 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_12 + var_442_6
					end

					if var_442_8.prefab_name ~= "" and arg_439_1.actors_[var_442_8.prefab_name] ~= nil then
						local var_442_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_8.prefab_name].transform, "story_v_out_319341", "319341102", "story_v_out_319341.awb")

						arg_439_1:RecordAudio("319341102", var_442_13)
						arg_439_1:RecordAudio("319341102", var_442_13)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_319341", "319341102", "story_v_out_319341.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_319341", "319341102", "story_v_out_319341.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
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

		arg_439_1:InitPlayNodeList()
	end,
	Play319341103 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 319341103
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play319341104(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["1084ui_story"]) and arg_443_1.var_.characterEffect1084ui_story == nil then
				arg_443_1.var_.characterEffect1084ui_story = arg_443_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["1084ui_story"]) then
				if arg_443_1.var_.characterEffect1084ui_story and not isNil(arg_443_1.actors_["1084ui_story"]) then
					arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_0)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["1084ui_story"]) and arg_443_1.var_.characterEffect1084ui_story then
				arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_446_1 = arg_443_1.actors_["1084ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1084ui_story == nil then
				arg_443_1.var_.characterEffect1084ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1084ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_2)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1084ui_story then
				arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_446_3 = 0
			local var_446_4 = 1.325

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_3 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_5 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(319341103).content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 53 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 53)

				if (53 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 53)) > 0 and var_446_4 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_3 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_3
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_4, arg_443_1.talkMaxDuration)

			if var_446_3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_3 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_3) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_3 + var_446_8 and arg_443_1.time_ < var_446_3 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play319341104 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 319341104
		arg_447_1.duration_ = 13.73

		local var_447_0 = {
			zh = 13.733,
			ja = 13.266
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play319341105(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["10058ui_story"]) and arg_447_1.var_.characterEffect10058ui_story == nil then
				arg_447_1.var_.characterEffect10058ui_story = arg_447_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["10058ui_story"]) then
				if arg_447_1.var_.characterEffect10058ui_story and not isNil(arg_447_1.actors_["10058ui_story"]) then
					arg_447_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["10058ui_story"]) and arg_447_1.var_.characterEffect10058ui_story then
				arg_447_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_450_2 = 0
			local var_450_3 = 1.7

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_4 = arg_447_1:GetWordFromCfg(319341104)
				local var_450_5 = arg_447_1:FormatText(var_450_4.content)

				arg_447_1.text_.text = var_450_5

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_7 = 68 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_5) / 68)

				if (68 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_5) / 68)) > 0 and var_450_3 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_2
					end
				end

				arg_447_1.text_.text = var_450_5
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341104", "story_v_out_319341.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_319341", "319341104", "story_v_out_319341.awb") / 1000

					if var_450_8 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_2
					end

					if var_450_4.prefab_name ~= "" and arg_447_1.actors_[var_450_4.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_4.prefab_name].transform, "story_v_out_319341", "319341104", "story_v_out_319341.awb")

						arg_447_1:RecordAudio("319341104", var_450_9)
						arg_447_1:RecordAudio("319341104", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_319341", "319341104", "story_v_out_319341.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_319341", "319341104", "story_v_out_319341.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_3, arg_447_1.talkMaxDuration)

			if var_450_2 <= arg_447_1.time_ and arg_447_1.time_ < var_450_2 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_2) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_2 + var_450_10 and arg_447_1.time_ < var_450_2 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play319341105 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 319341105
		arg_451_1.duration_ = 10

		local var_451_0 = {
			zh = 7.666,
			ja = 10
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play319341106(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.875

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:GetWordFromCfg(319341105)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 35 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 35)

				if (35 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 35)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341105", "story_v_out_319341.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341105", "story_v_out_319341.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_out_319341", "319341105", "story_v_out_319341.awb")

						arg_451_1:RecordAudio("319341105", var_454_6)
						arg_451_1:RecordAudio("319341105", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_319341", "319341105", "story_v_out_319341.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_319341", "319341105", "story_v_out_319341.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play319341106 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 319341106
		arg_455_1.duration_ = 8.9

		local var_455_0 = {
			zh = 6.866,
			ja = 8.9
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play319341107(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["10058ui_story"]) and arg_455_1.var_.characterEffect10058ui_story == nil then
				arg_455_1.var_.characterEffect10058ui_story = arg_455_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["10058ui_story"]) then
				if arg_455_1.var_.characterEffect10058ui_story and not isNil(arg_455_1.actors_["10058ui_story"]) then
					arg_455_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_455_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_0)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["10058ui_story"]) and arg_455_1.var_.characterEffect10058ui_story then
				arg_455_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_455_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_458_1 = arg_455_1.actors_["1084ui_story"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1084ui_story == nil then
				arg_455_1.var_.characterEffect1084ui_story = var_458_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_2 and not isNil(var_458_1) then
				if arg_455_1.var_.characterEffect1084ui_story and not isNil(var_458_1) then
					arg_455_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= 0 + var_458_2 and arg_455_1.time_ < 0 + var_458_2 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1084ui_story then
				arg_455_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_458_4 = 0
			local var_458_5 = 0.725

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_6 = arg_455_1:GetWordFromCfg(319341106)
				local var_458_7 = arg_455_1:FormatText(var_458_6.content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_9 = 29 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 29)

				if (29 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 29)) > 0 and var_458_5 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_4
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341106", "story_v_out_319341.awb") ~= 0 then
					local var_458_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341106", "story_v_out_319341.awb") / 1000

					if var_458_10 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_4
					end

					if var_458_6.prefab_name ~= "" and arg_455_1.actors_[var_458_6.prefab_name] ~= nil then
						local var_458_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_6.prefab_name].transform, "story_v_out_319341", "319341106", "story_v_out_319341.awb")

						arg_455_1:RecordAudio("319341106", var_458_11)
						arg_455_1:RecordAudio("319341106", var_458_11)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_319341", "319341106", "story_v_out_319341.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_319341", "319341106", "story_v_out_319341.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_12 = math.max(var_458_5, arg_455_1.talkMaxDuration)

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_12 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_4) / var_458_12

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_4 + var_458_12 and arg_455_1.time_ < var_458_4 + var_458_12 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play319341107 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 319341107
		arg_459_1.duration_ = 4.77

		local var_459_0 = {
			zh = 2.333,
			ja = 4.766
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play319341108(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["10058ui_story"]) and arg_459_1.var_.characterEffect10058ui_story == nil then
				arg_459_1.var_.characterEffect10058ui_story = arg_459_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["10058ui_story"]) then
				if arg_459_1.var_.characterEffect10058ui_story and not isNil(arg_459_1.actors_["10058ui_story"]) then
					arg_459_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["10058ui_story"]) and arg_459_1.var_.characterEffect10058ui_story then
				arg_459_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_462_2 = arg_459_1.actors_["1084ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.characterEffect1084ui_story == nil then
				arg_459_1.var_.characterEffect1084ui_story = var_462_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_3 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_3 and not isNil(var_462_2) then
				if arg_459_1.var_.characterEffect1084ui_story and not isNil(var_462_2) then
					arg_459_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_3)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_3 and arg_459_1.time_ < 0 + var_462_3 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.characterEffect1084ui_story then
				arg_459_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_462_4 = 0
			local var_462_5 = 0.325

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(319341107)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 13 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 13)

				if (13 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 13)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341107", "story_v_out_319341.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341107", "story_v_out_319341.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_out_319341", "319341107", "story_v_out_319341.awb")

						arg_459_1:RecordAudio("319341107", var_462_11)
						arg_459_1:RecordAudio("319341107", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_319341", "319341107", "story_v_out_319341.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_319341", "319341107", "story_v_out_319341.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play319341108 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 319341108
		arg_463_1.duration_ = 4.13

		local var_463_0 = {
			zh = 4.133,
			ja = 3.9
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play319341109(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_466_0 = 0
			local var_466_1 = 0.525

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_2 = arg_463_1:GetWordFromCfg(319341108)
				local var_466_3 = arg_463_1:FormatText(var_466_2.content)

				arg_463_1.text_.text = var_466_3

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 21 <= 0 and var_466_1 or var_466_1 * (utf8.len(var_466_3) / 21)

				if (21 <= 0 and var_466_1 or var_466_1 * (utf8.len(var_466_3) / 21)) > 0 and var_466_1 < var_466_5 then
					arg_463_1.talkMaxDuration = var_466_5

					if var_466_5 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_3
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341108", "story_v_out_319341.awb") ~= 0 then
					local var_466_6 = manager.audio:GetVoiceLength("story_v_out_319341", "319341108", "story_v_out_319341.awb") / 1000

					if var_466_6 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_0
					end

					if var_466_2.prefab_name ~= "" and arg_463_1.actors_[var_466_2.prefab_name] ~= nil then
						local var_466_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_2.prefab_name].transform, "story_v_out_319341", "319341108", "story_v_out_319341.awb")

						arg_463_1:RecordAudio("319341108", var_466_7)
						arg_463_1:RecordAudio("319341108", var_466_7)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_319341", "319341108", "story_v_out_319341.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_319341", "319341108", "story_v_out_319341.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_8 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_8 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_8

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_8 and arg_463_1.time_ < var_466_0 + var_466_8 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play319341109 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 319341109
		arg_467_1.duration_ = 13.87

		local var_467_0 = {
			zh = 9.366,
			ja = 13.866
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play319341110(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 1.275

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:GetWordFromCfg(319341109)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 51 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 51)

				if (51 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 51)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341109", "story_v_out_319341.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341109", "story_v_out_319341.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_319341", "319341109", "story_v_out_319341.awb")

						arg_467_1:RecordAudio("319341109", var_470_6)
						arg_467_1:RecordAudio("319341109", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_319341", "319341109", "story_v_out_319341.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_319341", "319341109", "story_v_out_319341.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play319341110 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 319341110
		arg_471_1.duration_ = 8.57

		local var_471_0 = {
			zh = 5.7,
			ja = 8.566
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play319341111(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.875

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:GetWordFromCfg(319341110)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 35 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 35)

				if (35 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 35)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341110", "story_v_out_319341.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341110", "story_v_out_319341.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_319341", "319341110", "story_v_out_319341.awb")

						arg_471_1:RecordAudio("319341110", var_474_6)
						arg_471_1:RecordAudio("319341110", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_319341", "319341110", "story_v_out_319341.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_319341", "319341110", "story_v_out_319341.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play319341111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 319341111
		arg_475_1.duration_ = 8.87

		local var_475_0 = {
			zh = 3.6,
			ja = 8.866
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play319341112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1084ui_story = arg_475_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).z)
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles = arg_475_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_475_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1084ui_story"].transform.position).z)
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1084ui_story"].transform.localEulerAngles = arg_475_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1084ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1084ui_story == nil then
				arg_475_1.var_.characterEffect1084ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1084ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1084ui_story then
				arg_475_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_478_4 = arg_475_1.actors_["10058ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_4) and arg_475_1.var_.characterEffect10058ui_story == nil then
				arg_475_1.var_.characterEffect10058ui_story = var_478_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_5 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_5 and not isNil(var_478_4) then
				if arg_475_1.var_.characterEffect10058ui_story and not isNil(var_478_4) then
					arg_475_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_475_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_5)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_5 and arg_475_1.time_ < 0 + var_478_5 + arg_478_0 and not isNil(var_478_4) and arg_475_1.var_.characterEffect10058ui_story then
				arg_475_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_475_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_478_6 = 0
			local var_478_7 = 0.375

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_6 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_8 = arg_475_1:GetWordFromCfg(319341111)
				local var_478_9 = arg_475_1:FormatText(var_478_8.content)

				arg_475_1.text_.text = var_478_9

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_11 = 15 <= 0 and var_478_7 or var_478_7 * (utf8.len(var_478_9) / 15)

				if (15 <= 0 and var_478_7 or var_478_7 * (utf8.len(var_478_9) / 15)) > 0 and var_478_7 < var_478_11 then
					arg_475_1.talkMaxDuration = var_478_11

					if var_478_11 + var_478_6 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_6
					end
				end

				arg_475_1.text_.text = var_478_9
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341111", "story_v_out_319341.awb") ~= 0 then
					local var_478_12 = manager.audio:GetVoiceLength("story_v_out_319341", "319341111", "story_v_out_319341.awb") / 1000

					if var_478_12 + var_478_6 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_12 + var_478_6
					end

					if var_478_8.prefab_name ~= "" and arg_475_1.actors_[var_478_8.prefab_name] ~= nil then
						local var_478_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_8.prefab_name].transform, "story_v_out_319341", "319341111", "story_v_out_319341.awb")

						arg_475_1:RecordAudio("319341111", var_478_13)
						arg_475_1:RecordAudio("319341111", var_478_13)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_319341", "319341111", "story_v_out_319341.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_319341", "319341111", "story_v_out_319341.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_14 = math.max(var_478_7, arg_475_1.talkMaxDuration)

			if var_478_6 <= arg_475_1.time_ and arg_475_1.time_ < var_478_6 + var_478_14 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_6) / var_478_14

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_6 + var_478_14 and arg_475_1.time_ < var_478_6 + var_478_14 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
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

		arg_475_1:InitPlayNodeList()
	end,
	Play319341112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 319341112
		arg_479_1.duration_ = 7.3

		local var_479_0 = {
			zh = 5.9,
			ja = 7.3
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play319341113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["10058ui_story"]) and arg_479_1.var_.characterEffect10058ui_story == nil then
				arg_479_1.var_.characterEffect10058ui_story = arg_479_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["10058ui_story"]) then
				if arg_479_1.var_.characterEffect10058ui_story and not isNil(arg_479_1.actors_["10058ui_story"]) then
					arg_479_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["10058ui_story"]) and arg_479_1.var_.characterEffect10058ui_story then
				arg_479_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_482_2 = arg_479_1.actors_["1084ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.characterEffect1084ui_story == nil then
				arg_479_1.var_.characterEffect1084ui_story = var_482_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_3 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_2) then
				if arg_479_1.var_.characterEffect1084ui_story and not isNil(var_482_2) then
					arg_479_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_3)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.characterEffect1084ui_story then
				arg_479_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_482_4 = 0
			local var_482_5 = 0.675

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(319341112)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 27 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 27)

				if (27 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 27)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341112", "story_v_out_319341.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_out_319341", "319341112", "story_v_out_319341.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_out_319341", "319341112", "story_v_out_319341.awb")

						arg_479_1:RecordAudio("319341112", var_482_11)
						arg_479_1:RecordAudio("319341112", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_319341", "319341112", "story_v_out_319341.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_319341", "319341112", "story_v_out_319341.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play319341113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 319341113
		arg_483_1.duration_ = 13.97

		local var_483_0 = {
			zh = 9.733,
			ja = 13.966
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play319341114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 1.35

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:GetWordFromCfg(319341113)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 54 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 54)

				if (54 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 54)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341113", "story_v_out_319341.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341113", "story_v_out_319341.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_out_319341", "319341113", "story_v_out_319341.awb")

						arg_483_1:RecordAudio("319341113", var_486_6)
						arg_483_1:RecordAudio("319341113", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_319341", "319341113", "story_v_out_319341.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_319341", "319341113", "story_v_out_319341.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play319341114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 319341114
		arg_487_1.duration_ = 9.5

		local var_487_0 = {
			zh = 5.466,
			ja = 9.5
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play319341115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.575

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:GetWordFromCfg(319341114)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 23 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 23)

				if (23 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 23)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319341", "319341114", "story_v_out_319341.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_319341", "319341114", "story_v_out_319341.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_319341", "319341114", "story_v_out_319341.awb")

						arg_487_1:RecordAudio("319341114", var_490_6)
						arg_487_1:RecordAudio("319341114", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_319341", "319341114", "story_v_out_319341.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_319341", "319341114", "story_v_out_319341.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play319341115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 319341115
		arg_491_1.duration_ = 109.96

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
			arg_491_1.auto_ = false
		end

		function arg_491_1.playNext_(arg_493_0)
			arg_491_1.onStoryFinished_()
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_0 = 1

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				local var_494_1 = Color.New(0, 0, 0)

				var_494_1.a = Mathf.Lerp(0, 1, (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.mask_.color = var_494_1
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				local var_494_2 = Color.New(0, 0, 0)

				var_494_2.a = 1
				arg_491_1.mask_.color = var_494_2
			end

			local var_494_3 = 1

			if 1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_3 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_4 = 0.0333333333333334

			if var_494_3 <= arg_491_1.time_ and arg_491_1.time_ < var_494_3 + var_494_4 then
				local var_494_5 = Color.New(0, 0, 0)

				var_494_5.a = Mathf.Lerp(1, 0, (arg_491_1.time_ - var_494_3) / var_494_4)
				arg_491_1.mask_.color = var_494_5
			end

			if arg_491_1.time_ >= var_494_3 + var_494_4 and arg_491_1.time_ < var_494_3 + var_494_4 + arg_494_0 then
				local var_494_6 = Color.New(0, 0, 0)

				arg_491_1.mask_.enabled = false
				var_494_6.a = 0
				arg_491_1.mask_.color = var_494_6
			end

			local var_494_7 = 1

			if 1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_7 + arg_494_0 then
				SetActive(arg_491_1.dialog_, false)
				SetActive(arg_491_1.allBtn_.gameObject, false)
				arg_491_1.hideBtnsController_:SetSelectedIndex(1)
				arg_491_1:StopAllVoice()

				arg_491_1.marker = "stop1111"

				manager.video:Play("SofdecAsset/story/story_1031934.usm", function(arg_495_0)
					arg_491_1:Skip(arg_495_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_496_0)
					arg_491_1.state_ = arg_496_0 and "pause" or "playing"
				end, 1031934)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_494_8 = 108.958333333333

			if var_494_7 <= arg_491_1.time_ and arg_491_1.time_ < var_494_7 + var_494_8 then
				-- block empty
			end

			if arg_491_1.time_ >= var_494_7 + var_494_8 and arg_491_1.time_ < var_494_7 + var_494_8 + arg_494_0 then
				arg_491_1.marker = ""
			end

			local var_494_9 = arg_491_1.actors_["1084ui_story"].transform

			if 0.966 < arg_491_1.time_ and arg_491_1.time_ <= 0.966 + arg_494_0 then
				arg_491_1.var_.moveOldPos1084ui_story = var_494_9.localPosition
			end

			local var_494_10 = 0.001

			if 0.966 <= arg_491_1.time_ and arg_491_1.time_ < 0.966 + var_494_10 then
				var_494_9.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_491_1.time_ - 0.966) / var_494_10)
				var_494_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_9.position).x, (manager.ui.mainCamera.transform.position - var_494_9.position).y, (manager.ui.mainCamera.transform.position - var_494_9.position).z)
				var_494_9.localEulerAngles.z = 0
				var_494_9.localEulerAngles.x = 0
				var_494_9.localEulerAngles = var_494_9.localEulerAngles
			end

			if arg_491_1.time_ >= 0.966 + var_494_10 and arg_491_1.time_ < 0.966 + var_494_10 + arg_494_0 then
				var_494_9.localPosition = Vector3.New(0, 100, 0)
				var_494_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_9.position).x, (manager.ui.mainCamera.transform.position - var_494_9.position).y, (manager.ui.mainCamera.transform.position - var_494_9.position).z)
				var_494_9.localEulerAngles.z = 0
				var_494_9.localEulerAngles.x = 0
				var_494_9.localEulerAngles = var_494_9.localEulerAngles
			end

			local var_494_11 = "1095ui_story"

			if arg_491_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_494_12 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_491_1.stage_.transform)

				var_494_12.name = var_494_11
				var_494_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_491_1.actors_[var_494_11] = var_494_12

				local var_494_13 = var_494_12:GetComponentInChildren(typeof(CharacterEffect))

				var_494_13.enabled = true

				local var_494_14 = GameObjectTools.GetOrAddComponent(var_494_12, typeof(DynamicBoneHelper))

				if var_494_14 then
					var_494_14:EnableDynamicBone(false)
				end

				arg_491_1:ShowWeapon(var_494_13.transform, false)

				arg_491_1.var_[var_494_11 .. "Animator"] = var_494_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_491_1.var_[var_494_11 .. "Animator"].applyRootMotion = true
				arg_491_1.var_[var_494_11 .. "LipSync"] = var_494_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_494_15 = arg_491_1.actors_["1095ui_story"].transform

			if 0.966 < arg_491_1.time_ and arg_491_1.time_ <= 0.966 + arg_494_0 then
				arg_491_1.var_.moveOldPos1095ui_story = var_494_15.localPosition
			end

			local var_494_16 = 0.001

			if 0.966 <= arg_491_1.time_ and arg_491_1.time_ < 0.966 + var_494_16 then
				var_494_15.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_491_1.time_ - 0.966) / var_494_16)
				var_494_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_15.position).x, (manager.ui.mainCamera.transform.position - var_494_15.position).y, (manager.ui.mainCamera.transform.position - var_494_15.position).z)
				var_494_15.localEulerAngles.z = 0
				var_494_15.localEulerAngles.x = 0
				var_494_15.localEulerAngles = var_494_15.localEulerAngles
			end

			if arg_491_1.time_ >= 0.966 + var_494_16 and arg_491_1.time_ < 0.966 + var_494_16 + arg_494_0 then
				var_494_15.localPosition = Vector3.New(0, 100, 0)
				var_494_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_15.position).x, (manager.ui.mainCamera.transform.position - var_494_15.position).y, (manager.ui.mainCamera.transform.position - var_494_15.position).z)
				var_494_15.localEulerAngles.z = 0
				var_494_15.localEulerAngles.x = 0
				var_494_15.localEulerAngles = var_494_15.localEulerAngles
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ML0102",
		"SofdecAsset/story/story_1031934.usm"
	},
	voices = {
		"story_v_out_319341.awb"
	},
	skipMarkers = {
		319341115
	}
}
