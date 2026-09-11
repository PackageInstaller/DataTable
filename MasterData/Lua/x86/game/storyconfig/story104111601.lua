return {
	Play411161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.B10b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10b")
				var_4_0.name = "B10b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10b

				arg_1_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10b" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_rain02_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.var_.effect工厂雨

				if not arg_1_1.var_.effect工厂雨 then
					var_4_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_4_15.name = "工厂雨"
					arg_1_1.var_.effect工厂雨 = var_4_15
				else
					var_4_15.transform:SetParent(var_4_9000)
				end

				var_4_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 2
			local var_4_18 = 0.55

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411161001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 22 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 22)

				if (22 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 22)) > 0 and var_4_18 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_17 = var_4_17 + 0.3

					if var_4_22 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_17 + 0.3
			local var_4_24 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
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
	Play411161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411161002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.975

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411161002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)) > 0 and var_12_0 < var_12_3 then
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
	Play411161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411161003
		arg_13_1.duration_ = 2.37

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_13_0:Play411161004(arg_13_1)
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
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.3

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

				local var_16_10 = arg_13_1:GetWordFromCfg(411161003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 12)

				if (12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 12)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161003", "story_v_out_411161.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161003", "story_v_out_411161.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_411161", "411161003", "story_v_out_411161.awb")

						arg_13_1:RecordAudio("411161003", var_16_15)
						arg_13_1:RecordAudio("411161003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411161", "411161003", "story_v_out_411161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411161", "411161003", "story_v_out_411161.awb")
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
	Play411161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411161004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = arg_17_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).z)
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles = arg_17_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).z)
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles = arg_17_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.825

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(411161004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 33 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 33)

				if (33 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 33)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
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
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play411161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411161005
		arg_21_1.duration_ = 1.77

		local var_21_0 = {
			zh = 1.166,
			ja = 1.766
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
				arg_21_0:Play411161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "2079ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["2079ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["2079ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["2079ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["2079ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos2079ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["2079ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect2079ui_story == nil then
				arg_21_1.var_.characterEffect2079ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect2079ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect2079ui_story then
				arg_21_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_8 = 0
			local var_24_9 = 0.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(411161005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 6 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 6)

				if (6 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 6)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161005", "story_v_out_411161.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161005", "story_v_out_411161.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_411161", "411161005", "story_v_out_411161.awb")

						arg_21_1:RecordAudio("411161005", var_24_15)
						arg_21_1:RecordAudio("411161005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411161", "411161005", "story_v_out_411161.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411161", "411161005", "story_v_out_411161.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play411161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411161006
		arg_25_1.duration_ = 5.5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos2079ui_story = arg_25_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).z)
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles = arg_25_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2079ui_story"].transform.position).z)
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2079ui_story"].transform.localEulerAngles = arg_25_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["2079ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2079ui_story == nil then
				arg_25_1.var_.characterEffect2079ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect2079ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2079ui_story then
				arg_25_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_4 = 0.5

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_4 then
				local var_28_5 = Color.New(1, 1, 1)

				var_28_5.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_3) / var_28_4)
				arg_25_1.mask_.color = var_28_5
			end

			if arg_25_1.time_ >= var_28_3 + var_28_4 and arg_25_1.time_ < var_28_3 + var_28_4 + arg_28_0 then
				local var_28_6 = Color.New(1, 1, 1)

				arg_25_1.mask_.enabled = false
				var_28_6.a = 0
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_7 = 0.5
			local var_28_8 = 0.875

			if 0.5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_9 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_9:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(411161006).content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 35 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 35)

				if (35 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 35)) > 0 and var_28_8 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12
					var_28_7 = var_28_7 + 0.3

					if var_28_12 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = var_28_7 + 0.3
			local var_28_14 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_14 and arg_25_1.time_ < var_28_13 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play411161007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 411161007
		arg_31_1.duration_ = 7.2

		local var_31_0 = {
			zh = 5.233,
			ja = 7.2
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play411161008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_34_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_31_1.stage_.transform)

				var_34_0.name = "2078ui_story"
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["2078ui_story"] = var_34_0

				local var_34_1 = var_34_0:GetComponentInChildren(typeof(CharacterEffect))

				var_34_1.enabled = true

				local var_34_2 = GameObjectTools.GetOrAddComponent(var_34_0, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_1.transform, false)

				arg_31_1.var_["2078ui_story" .. "Animator"] = var_34_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_31_1.var_["2078ui_story" .. "LipSync"] = var_34_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_3 = arg_31_1.actors_["2078ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos2078ui_story = var_34_3.localPosition
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			local var_34_5 = arg_31_1.actors_["2078ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect2078ui_story == nil then
				arg_31_1.var_.characterEffect2078ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect2078ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect2078ui_story then
				arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_8 = arg_31_1.actors_["2079ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos2079ui_story = var_34_8.localPosition
			end

			local var_34_9 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_9 then
				var_34_8.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_31_1.time_ - 0) / var_34_9)
				var_34_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_8.position).x, (manager.ui.mainCamera.transform.position - var_34_8.position).y, (manager.ui.mainCamera.transform.position - var_34_8.position).z)
				var_34_8.localEulerAngles.z = 0
				var_34_8.localEulerAngles.x = 0
				var_34_8.localEulerAngles = var_34_8.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_9 and arg_31_1.time_ < 0 + var_34_9 + arg_34_0 then
				var_34_8.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_34_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_8.position).x, (manager.ui.mainCamera.transform.position - var_34_8.position).y, (manager.ui.mainCamera.transform.position - var_34_8.position).z)
				var_34_8.localEulerAngles.z = 0
				var_34_8.localEulerAngles.x = 0
				var_34_8.localEulerAngles = var_34_8.localEulerAngles
			end

			local var_34_10 = 0
			local var_34_11 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_12 = arg_31_1:GetWordFromCfg(411161007)
				local var_34_13 = arg_31_1:FormatText(var_34_12.content)

				arg_31_1.text_.text = var_34_13

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 18 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 18)

				if (18 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 18)) > 0 and var_34_11 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_13
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161007", "story_v_out_411161.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_411161", "411161007", "story_v_out_411161.awb") / 1000

					if var_34_16 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_10
					end

					if var_34_12.prefab_name ~= "" and arg_31_1.actors_[var_34_12.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_12.prefab_name].transform, "story_v_out_411161", "411161007", "story_v_out_411161.awb")

						arg_31_1:RecordAudio("411161007", var_34_17)
						arg_31_1:RecordAudio("411161007", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_411161", "411161007", "story_v_out_411161.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_411161", "411161007", "story_v_out_411161.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_18 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_18 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_18

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_18 and arg_31_1.time_ < var_34_10 + var_34_18 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_31_1:InitPlayNodeList()
	end,
	Play411161008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 411161008
		arg_35_1.duration_ = 4.93

		local var_35_0 = {
			zh = 2.533,
			ja = 4.933
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play411161009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) and arg_35_1.var_.characterEffect2078ui_story == nil then
				arg_35_1.var_.characterEffect2078ui_story = arg_35_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) then
				if arg_35_1.var_.characterEffect2078ui_story and not isNil(arg_35_1.actors_["2078ui_story"]) then
					arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_35_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) and arg_35_1.var_.characterEffect2078ui_story then
				arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_35_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_38_1 = arg_35_1.actors_["2079ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect2079ui_story == nil then
				arg_35_1.var_.characterEffect2079ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect2079ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect2079ui_story then
				arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_38_4 = 0
			local var_38_5 = 0.175

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(411161008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 7 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 7)

				if (7 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 7)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161008", "story_v_out_411161.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161008", "story_v_out_411161.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_411161", "411161008", "story_v_out_411161.awb")

						arg_35_1:RecordAudio("411161008", var_38_11)
						arg_35_1:RecordAudio("411161008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_411161", "411161008", "story_v_out_411161.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_411161", "411161008", "story_v_out_411161.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play411161009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 411161009
		arg_39_1.duration_ = 6.1

		local var_39_0 = {
			zh = 3.533,
			ja = 6.1
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
				arg_39_0:Play411161010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["2078ui_story"]) and arg_39_1.var_.characterEffect2078ui_story == nil then
				arg_39_1.var_.characterEffect2078ui_story = arg_39_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["2078ui_story"]) then
				if arg_39_1.var_.characterEffect2078ui_story and not isNil(arg_39_1.actors_["2078ui_story"]) then
					arg_39_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["2078ui_story"]) and arg_39_1.var_.characterEffect2078ui_story then
				arg_39_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_42_2 = arg_39_1.actors_["2079ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect2079ui_story == nil then
				arg_39_1.var_.characterEffect2079ui_story = var_42_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.characterEffect2079ui_story and not isNil(var_42_2) then
					arg_39_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_39_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_3)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect2079ui_story then
				arg_39_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_39_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_42_4 = 0
			local var_42_5 = 0.45

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(411161009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 18 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 18)

				if (18 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 18)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161009", "story_v_out_411161.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161009", "story_v_out_411161.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_411161", "411161009", "story_v_out_411161.awb")

						arg_39_1:RecordAudio("411161009", var_42_11)
						arg_39_1:RecordAudio("411161009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_411161", "411161009", "story_v_out_411161.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_411161", "411161009", "story_v_out_411161.awb")
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

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play411161010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 411161010
		arg_43_1.duration_ = 5.13

		local var_43_0 = {
			zh = 2.1,
			ja = 5.133
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
				arg_43_0:Play411161011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["2078ui_story"]) and arg_43_1.var_.characterEffect2078ui_story == nil then
				arg_43_1.var_.characterEffect2078ui_story = arg_43_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["2078ui_story"]) then
				if arg_43_1.var_.characterEffect2078ui_story and not isNil(arg_43_1.actors_["2078ui_story"]) then
					arg_43_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_43_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["2078ui_story"]) and arg_43_1.var_.characterEffect2078ui_story then
				arg_43_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_43_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_46_1 = arg_43_1.actors_["2079ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect2079ui_story == nil then
				arg_43_1.var_.characterEffect2079ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect2079ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect2079ui_story then
				arg_43_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.3

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(411161010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 12 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 12)

				if (12 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 12)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161010", "story_v_out_411161.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161010", "story_v_out_411161.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_411161", "411161010", "story_v_out_411161.awb")

						arg_43_1:RecordAudio("411161010", var_46_11)
						arg_43_1:RecordAudio("411161010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_411161", "411161010", "story_v_out_411161.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_411161", "411161010", "story_v_out_411161.awb")
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

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play411161011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411161011
		arg_47_1.duration_ = 9.33

		local var_47_0 = {
			zh = 3.166,
			ja = 9.333
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
				arg_47_0:Play411161012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) and arg_47_1.var_.characterEffect2078ui_story == nil then
				arg_47_1.var_.characterEffect2078ui_story = arg_47_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) then
				if arg_47_1.var_.characterEffect2078ui_story and not isNil(arg_47_1.actors_["2078ui_story"]) then
					arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) and arg_47_1.var_.characterEffect2078ui_story then
				arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["2079ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect2079ui_story == nil then
				arg_47_1.var_.characterEffect2079ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect2079ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_47_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect2079ui_story then
				arg_47_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_47_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 0.375

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(411161011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 15 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 15)

				if (15 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 15)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161011", "story_v_out_411161.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161011", "story_v_out_411161.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_411161", "411161011", "story_v_out_411161.awb")

						arg_47_1:RecordAudio("411161011", var_50_11)
						arg_47_1:RecordAudio("411161011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_411161", "411161011", "story_v_out_411161.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_411161", "411161011", "story_v_out_411161.awb")
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
	Play411161012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411161012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411161013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos2078ui_story = arg_51_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).z)
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles = arg_51_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["2078ui_story"].transform.position).z)
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["2078ui_story"].transform.localEulerAngles = arg_51_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["2078ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect2078ui_story == nil then
				arg_51_1.var_.characterEffect2078ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect2078ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_51_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect2078ui_story then
				arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_51_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_54_3 = arg_51_1.actors_["2079ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos2079ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, 100, 0)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["2078ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect2078ui_story == nil then
				arg_51_1.var_.characterEffect2078ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect2078ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_51_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_6)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect2078ui_story then
				arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_51_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_54_7 = 0
			local var_54_8 = 1.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(411161012).content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 65 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_9) / 65)

				if (65 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_9) / 65)) > 0 and var_54_8 < var_54_11 then
					arg_51_1.talkMaxDuration = var_54_11

					if var_54_11 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_7
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_8, arg_51_1.talkMaxDuration)

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_7) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_7 + var_54_12 and arg_51_1.time_ < var_54_7 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_51_1:InitPlayNodeList()
	end,
	Play411161013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411161013
		arg_55_1.duration_ = 3.13

		local var_55_0 = {
			zh = 2.666,
			ja = 3.133
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
				arg_55_0:Play411161014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos2078ui_story = arg_55_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).z)
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles = arg_55_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_55_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2078ui_story"].transform.position).z)
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2078ui_story"].transform.localEulerAngles = arg_55_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["2078ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2078ui_story == nil then
				arg_55_1.var_.characterEffect2078ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect2078ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2078ui_story then
				arg_55_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.325

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(411161013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 13 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 13)

				if (13 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 13)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161013", "story_v_out_411161.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161013", "story_v_out_411161.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_411161", "411161013", "story_v_out_411161.awb")

						arg_55_1:RecordAudio("411161013", var_58_11)
						arg_55_1:RecordAudio("411161013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_411161", "411161013", "story_v_out_411161.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_411161", "411161013", "story_v_out_411161.awb")
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
				actorName = "2078ui_story",
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
	Play411161014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411161014
		arg_59_1.duration_ = 6

		local var_59_0 = {
			zh = 6,
			ja = 2.066
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
				arg_59_0:Play411161015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["2078ui_story"]) and arg_59_1.var_.characterEffect2078ui_story == nil then
				arg_59_1.var_.characterEffect2078ui_story = arg_59_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["2078ui_story"]) then
				if arg_59_1.var_.characterEffect2078ui_story and not isNil(arg_59_1.actors_["2078ui_story"]) then
					arg_59_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_59_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["2078ui_story"]) and arg_59_1.var_.characterEffect2078ui_story then
				arg_59_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_59_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.825

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[712].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(411161014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 33 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 33)

				if (33 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 33)) > 0 and var_62_2 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161014", "story_v_out_411161.awb") ~= 0 then
					local var_62_7 = manager.audio:GetVoiceLength("story_v_out_411161", "411161014", "story_v_out_411161.awb") / 1000

					if var_62_7 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_1
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_411161", "411161014", "story_v_out_411161.awb")

						arg_59_1:RecordAudio("411161014", var_62_8)
						arg_59_1:RecordAudio("411161014", var_62_8)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_411161", "411161014", "story_v_out_411161.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_411161", "411161014", "story_v_out_411161.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_9 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_9 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_9

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_9 and arg_59_1.time_ < var_62_1 + var_62_9 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play411161015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411161015
		arg_63_1.duration_ = 4.97

		local var_63_0 = {
			zh = 4.966,
			ja = 4.566
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
				arg_63_0:Play411161016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.75

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[712].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(411161015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)

				if (30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161015", "story_v_out_411161.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161015", "story_v_out_411161.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_411161", "411161015", "story_v_out_411161.awb")

						arg_63_1:RecordAudio("411161015", var_66_6)
						arg_63_1:RecordAudio("411161015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_411161", "411161015", "story_v_out_411161.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_411161", "411161015", "story_v_out_411161.awb")
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
	Play411161016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411161016
		arg_67_1.duration_ = 5.7

		local var_67_0 = {
			zh = 4.1,
			ja = 5.7
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
				arg_67_0:Play411161017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["2078ui_story"]) and arg_67_1.var_.characterEffect2078ui_story == nil then
				arg_67_1.var_.characterEffect2078ui_story = arg_67_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["2078ui_story"]) then
				if arg_67_1.var_.characterEffect2078ui_story and not isNil(arg_67_1.actors_["2078ui_story"]) then
					arg_67_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["2078ui_story"]) and arg_67_1.var_.characterEffect2078ui_story then
				arg_67_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_70_2 = 0
			local var_70_3 = 0.525

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(411161016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 21 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 21)

				if (21 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 21)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161016", "story_v_out_411161.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_411161", "411161016", "story_v_out_411161.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_411161", "411161016", "story_v_out_411161.awb")

						arg_67_1:RecordAudio("411161016", var_70_9)
						arg_67_1:RecordAudio("411161016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_411161", "411161016", "story_v_out_411161.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_411161", "411161016", "story_v_out_411161.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play411161017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411161017
		arg_71_1.duration_ = 5.33

		local var_71_0 = {
			zh = 2.266,
			ja = 5.333
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
				arg_71_0:Play411161018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[712].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(411161017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)

				if (16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161017", "story_v_out_411161.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161017", "story_v_out_411161.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_411161", "411161017", "story_v_out_411161.awb")

						arg_71_1:RecordAudio("411161017", var_74_6)
						arg_71_1:RecordAudio("411161017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_411161", "411161017", "story_v_out_411161.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_411161", "411161017", "story_v_out_411161.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play411161018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411161018
		arg_75_1.duration_ = 4.33

		local var_75_0 = {
			zh = 2.1,
			ja = 4.333
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
				arg_75_0:Play411161019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) and arg_75_1.var_.characterEffect2078ui_story == nil then
				arg_75_1.var_.characterEffect2078ui_story = arg_75_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) then
				if arg_75_1.var_.characterEffect2078ui_story and not isNil(arg_75_1.actors_["2078ui_story"]) then
					arg_75_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["2078ui_story"]) and arg_75_1.var_.characterEffect2078ui_story then
				arg_75_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_78_2 = 0
			local var_78_3 = 0.25

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[711].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:GetWordFromCfg(411161018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 10 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 10)

				if (10 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 10)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161018", "story_v_out_411161.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_411161", "411161018", "story_v_out_411161.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_411161", "411161018", "story_v_out_411161.awb")

						arg_75_1:RecordAudio("411161018", var_78_9)
						arg_75_1:RecordAudio("411161018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_411161", "411161018", "story_v_out_411161.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_411161", "411161018", "story_v_out_411161.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play411161019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411161019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411161020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos2078ui_story = arg_79_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).z)
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles = arg_79_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["2078ui_story"].transform.position).z)
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["2078ui_story"].transform.localEulerAngles = arg_79_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["2078ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect2078ui_story == nil then
				arg_79_1.var_.characterEffect2078ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect2078ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_79_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_2)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect2078ui_story then
				arg_79_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_79_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_82_3 = 0
			local var_82_4 = 1.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(411161019).content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 51 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 51)

				if (51 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 51)) > 0 and var_82_4 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_8 and arg_79_1.time_ < var_82_3 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play411161020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411161020
		arg_83_1.duration_ = 4.97

		local var_83_0 = {
			zh = 4.966,
			ja = 4.4
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
				arg_83_0:Play411161021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1095ui_story = arg_83_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1095ui_story"].transform.position).z)
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1095ui_story"].transform.localEulerAngles = arg_83_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
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
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_4 = 0
			local var_86_5 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[695].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(411161020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 26 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 26)

				if (26 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 26)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161020", "story_v_out_411161.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161020", "story_v_out_411161.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_out_411161", "411161020", "story_v_out_411161.awb")

						arg_83_1:RecordAudio("411161020", var_86_11)
						arg_83_1:RecordAudio("411161020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_411161", "411161020", "story_v_out_411161.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_411161", "411161020", "story_v_out_411161.awb")
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
	Play411161021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411161021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411161022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1095ui_story = arg_87_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_2)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_90_3 = 0
			local var_90_4 = 0.75

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(411161021).content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 30 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 30)

				if (30 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 30)) > 0 and var_90_4 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_8 and arg_87_1.time_ < var_90_3 + var_90_8 + arg_90_0 then
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
	Play411161022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411161022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play411161023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(411161022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 48 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 48)

				if (48 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 48)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411161023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411161023
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411161024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.bgs_.ST75 == nil then
				local var_98_0 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")
				var_98_0.name = "ST75"
				var_98_0.transform.parent = arg_95_1.stage_.transform
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_.ST75 = var_98_0
			end

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				local var_98_1 = arg_95_1.bgs_.ST75

				arg_95_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_2 = var_98_1:GetComponent("SpriteRenderer")

				if var_98_2 and var_98_2.sprite then
					local var_98_3 = 2 * (var_98_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_1.transform.localScale = Vector3.New(var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST75" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_4 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_5 = 2

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_5 then
				local var_98_6 = Color.New(0, 0, 0)

				var_98_6.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_4) / var_98_5)
				arg_95_1.mask_.color = var_98_6
			end

			if arg_95_1.time_ >= var_98_4 + var_98_5 and arg_95_1.time_ < var_98_4 + var_98_5 + arg_98_0 then
				local var_98_7 = Color.New(0, 0, 0)

				var_98_7.a = 1
				arg_95_1.mask_.color = var_98_7
			end

			local var_98_8 = 2

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_9 = 2

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 then
				local var_98_10 = Color.New(0, 0, 0)

				var_98_10.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_8) / var_98_9)
				arg_95_1.mask_.color = var_98_10
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 then
				local var_98_11 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_11.a = 0
				arg_95_1.mask_.color = var_98_11
			end

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				if arg_95_1.var_.effect工厂雨 then
					Object.Destroy(arg_95_1.var_.effect工厂雨)

					arg_95_1.var_.effect工厂雨 = nil
				end
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_13 = 4
			local var_98_14 = 1

			if 4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_15 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_15:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(411161023).content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_18 = 38 <= 0 and var_98_14 or var_98_14 * (utf8.len(var_98_16) / 38)

				if (38 <= 0 and var_98_14 or var_98_14 * (utf8.len(var_98_16) / 38)) > 0 and var_98_14 < var_98_18 then
					arg_95_1.talkMaxDuration = var_98_18
					var_98_13 = var_98_13 + 0.3

					if var_98_18 + var_98_13 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_13
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_19 = var_98_13 + 0.3
			local var_98_20 = math.max(var_98_14, arg_95_1.talkMaxDuration)

			if var_98_13 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_20 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_19) / var_98_20

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_19 + var_98_20 and arg_95_1.time_ < var_98_19 + var_98_20 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play411161024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411161024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411161025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(411161024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 24 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 24)

				if (24 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 24)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play411161025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411161025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411161026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(411161025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 55 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 55)

				if (55 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 55)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play411161026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411161026
		arg_109_1.duration_ = 5.67

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play411161027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_hit", "")
			end

			local var_112_1 = manager.ui.mainCamera.transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.shakeOldPos = var_112_1.localPosition
			end

			local var_112_2 = 0.5

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				local var_112_3, var_112_4 = math.modf((arg_109_1.time_ - 0) / 0.066)

				var_112_1.localPosition = Vector3.New(var_112_4 * 0.13, var_112_4 * 0.13, var_112_4 * 0.13) + arg_109_1.var_.shakeOldPos
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = arg_109_1.var_.shakeOldPos
			end

			local var_112_5 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			if arg_109_1.time_ >= var_112_5 + 0.5 and arg_109_1.time_ < var_112_5 + 0.5 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_6 = 0.666666666666667
			local var_112_7 = 0.1

			if 0.666666666666667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_8 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_8:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(411161026).content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 4 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 4)

				if (4 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 4)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11
					var_112_6 = var_112_6 + 0.3

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = var_112_6 + 0.3
			local var_112_13 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_12) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_12 + var_112_13 and arg_109_1.time_ < var_112_12 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play411161027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411161027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play411161028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.725

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(411161027).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 30 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 30)

				if (30 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 30)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play411161028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411161028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play411161029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 1.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(411161028).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 48 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 48)

				if (48 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 48)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play411161029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411161029
		arg_123_1.duration_ = 5.13

		local var_123_0 = {
			zh = 2.766,
			ja = 5.133
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
				arg_123_0:Play411161030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.325

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[713].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(411161029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 13 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 13)

				if (13 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 13)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161029", "story_v_out_411161.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161029", "story_v_out_411161.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_411161", "411161029", "story_v_out_411161.awb")

						arg_123_1:RecordAudio("411161029", var_126_6)
						arg_123_1:RecordAudio("411161029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_411161", "411161029", "story_v_out_411161.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_411161", "411161029", "story_v_out_411161.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411161030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411161030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411161031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.675

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(411161030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 27 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 27)

				if (27 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 27)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411161031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411161031
		arg_131_1.duration_ = 1.23

		local var_131_0 = {
			zh = 0.999999999999,
			ja = 1.233
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
				arg_131_0:Play411161032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.05

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[713].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(411161031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 2 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 2)

				if (2 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 2)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161031", "story_v_out_411161.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161031", "story_v_out_411161.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_411161", "411161031", "story_v_out_411161.awb")

						arg_131_1:RecordAudio("411161031", var_134_6)
						arg_131_1:RecordAudio("411161031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411161", "411161031", "story_v_out_411161.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411161", "411161031", "story_v_out_411161.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411161032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411161032
		arg_135_1.duration_ = 4.13

		local var_135_0 = {
			zh = 2.466,
			ja = 4.133
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
				arg_135_0:Play411161033(arg_135_1)
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
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.25

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
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

				local var_138_6 = arg_135_1:GetWordFromCfg(411161032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 10 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 10)

				if (10 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 10)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161032", "story_v_out_411161.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161032", "story_v_out_411161.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_411161", "411161032", "story_v_out_411161.awb")

						arg_135_1:RecordAudio("411161032", var_138_11)
						arg_135_1:RecordAudio("411161032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411161", "411161032", "story_v_out_411161.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411161", "411161032", "story_v_out_411161.awb")
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
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play411161033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411161033
		arg_139_1.duration_ = 6.53

		local var_139_0 = {
			zh = 4.366,
			ja = 6.533
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
				arg_139_0:Play411161034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = arg_139_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) then
				if arg_139_1.var_.characterEffect1095ui_story and not isNil(arg_139_1.actors_["1095ui_story"]) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.475

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[713].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(411161033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 19 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 19)

				if (19 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 19)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161033", "story_v_out_411161.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_411161", "411161033", "story_v_out_411161.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_411161", "411161033", "story_v_out_411161.awb")

						arg_139_1:RecordAudio("411161033", var_142_8)
						arg_139_1:RecordAudio("411161033", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411161", "411161033", "story_v_out_411161.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411161", "411161033", "story_v_out_411161.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play411161034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411161034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411161035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(411161034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 21)

				if (21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 21)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411161035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411161035
		arg_147_1.duration_ = 3.2

		local var_147_0 = {
			zh = 2.333,
			ja = 3.2
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
				arg_147_0:Play411161036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1095ui_story = arg_147_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).z)
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles = arg_147_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_147_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1095ui_story"].transform.position).z)
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1095ui_story"].transform.localEulerAngles = arg_147_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1095ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1095ui_story == nil then
				arg_147_1.var_.characterEffect1095ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1095ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1095ui_story then
				arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.2

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(411161035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 8 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 8)

				if (8 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 8)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161035", "story_v_out_411161.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161035", "story_v_out_411161.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_411161", "411161035", "story_v_out_411161.awb")

						arg_147_1:RecordAudio("411161035", var_150_11)
						arg_147_1:RecordAudio("411161035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411161", "411161035", "story_v_out_411161.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411161", "411161035", "story_v_out_411161.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play411161036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411161036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411161037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1095ui_story = arg_151_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1095ui_story"].transform.position).z)
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1095ui_story"].transform.localEulerAngles = arg_151_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1095ui_story then
				arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_154_3 = 0
			local var_154_4 = 0.65

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(411161036).content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 26 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 26)

				if (26 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 26)) > 0 and var_154_4 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_8 and arg_151_1.time_ < var_154_3 + var_154_8 + arg_154_0 then
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
	Play411161037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411161037
		arg_155_1.duration_ = 3.17

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411161038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if arg_155_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_158_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_155_1.stage_.transform)

				var_158_0.name = "4010ui_story"
				var_158_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["4010ui_story"] = var_158_0

				local var_158_1 = var_158_0:GetComponentInChildren(typeof(CharacterEffect))

				var_158_1.enabled = true

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end

				arg_155_1:ShowWeapon(var_158_1.transform, false)

				arg_155_1.var_["4010ui_story" .. "Animator"] = var_158_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_155_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_155_1.var_["4010ui_story" .. "LipSync"] = var_158_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_158_3 = arg_155_1.actors_["4010ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos4010ui_story = var_158_3.localPosition
			end

			local var_158_4 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				var_158_3.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_155_1.time_ - 0) / var_158_4)
				var_158_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_3.position).x, (manager.ui.mainCamera.transform.position - var_158_3.position).y, (manager.ui.mainCamera.transform.position - var_158_3.position).z)
				var_158_3.localEulerAngles.z = 0
				var_158_3.localEulerAngles.x = 0
				var_158_3.localEulerAngles = var_158_3.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				var_158_3.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_158_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_3.position).x, (manager.ui.mainCamera.transform.position - var_158_3.position).y, (manager.ui.mainCamera.transform.position - var_158_3.position).z)
				var_158_3.localEulerAngles.z = 0
				var_158_3.localEulerAngles.x = 0
				var_158_3.localEulerAngles = var_158_3.localEulerAngles
			end

			local var_158_5 = arg_155_1.actors_["4010ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect4010ui_story == nil then
				arg_155_1.var_.characterEffect4010ui_story = var_158_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_6 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.characterEffect4010ui_story and not isNil(var_158_5) then
					arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect4010ui_story then
				arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_158_8 = arg_155_1.actors_["1095ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1095ui_story = var_158_8.localPosition
			end

			local var_158_9 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 then
				var_158_8.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_155_1.time_ - 0) / var_158_9)
				var_158_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_8.position).x, (manager.ui.mainCamera.transform.position - var_158_8.position).y, (manager.ui.mainCamera.transform.position - var_158_8.position).z)
				var_158_8.localEulerAngles.z = 0
				var_158_8.localEulerAngles.x = 0
				var_158_8.localEulerAngles = var_158_8.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 then
				var_158_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_158_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_8.position).x, (manager.ui.mainCamera.transform.position - var_158_8.position).y, (manager.ui.mainCamera.transform.position - var_158_8.position).z)
				var_158_8.localEulerAngles.z = 0
				var_158_8.localEulerAngles.x = 0
				var_158_8.localEulerAngles = var_158_8.localEulerAngles
			end

			local var_158_10 = 0
			local var_158_11 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
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

				local var_158_12 = arg_155_1:GetWordFromCfg(411161037)
				local var_158_13 = arg_155_1:FormatText(var_158_12.content)

				arg_155_1.text_.text = var_158_13

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 15 <= 0 and var_158_11 or var_158_11 * (utf8.len(var_158_13) / 15)

				if (15 <= 0 and var_158_11 or var_158_11 * (utf8.len(var_158_13) / 15)) > 0 and var_158_11 < var_158_15 then
					arg_155_1.talkMaxDuration = var_158_15

					if var_158_15 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_15 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_13
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161037", "story_v_out_411161.awb") ~= 0 then
					local var_158_16 = manager.audio:GetVoiceLength("story_v_out_411161", "411161037", "story_v_out_411161.awb") / 1000

					if var_158_16 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_10
					end

					if var_158_12.prefab_name ~= "" and arg_155_1.actors_[var_158_12.prefab_name] ~= nil then
						local var_158_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_12.prefab_name].transform, "story_v_out_411161", "411161037", "story_v_out_411161.awb")

						arg_155_1:RecordAudio("411161037", var_158_17)
						arg_155_1:RecordAudio("411161037", var_158_17)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411161", "411161037", "story_v_out_411161.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411161", "411161037", "story_v_out_411161.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_18 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_18 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_18

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_18 and arg_155_1.time_ < var_158_10 + var_158_18 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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
	Play411161038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411161038
		arg_159_1.duration_ = 5.53

		local var_159_0 = {
			zh = 5.166,
			ja = 5.533
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
				arg_159_0:Play411161039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.525

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(411161038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 21 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 21)

				if (21 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 21)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161038", "story_v_out_411161.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161038", "story_v_out_411161.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_411161", "411161038", "story_v_out_411161.awb")

						arg_159_1:RecordAudio("411161038", var_162_6)
						arg_159_1:RecordAudio("411161038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411161", "411161038", "story_v_out_411161.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411161", "411161038", "story_v_out_411161.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411161039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411161039
		arg_163_1.duration_ = 2.57

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_163_0:Play411161040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1095ui_story = arg_163_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).z)
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles = arg_163_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_163_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1095ui_story"].transform.position).z)
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1095ui_story"].transform.localEulerAngles = arg_163_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1095ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1095ui_story == nil then
				arg_163_1.var_.characterEffect1095ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1095ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1095ui_story then
				arg_163_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["4010ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4010ui_story = var_166_4.localPosition
			end

			local var_166_5 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 then
				var_166_4.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_163_1.time_ - 0) / var_166_5)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 then
				var_166_4.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			local var_166_6 = arg_163_1.actors_["4010ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect4010ui_story == nil then
				arg_163_1.var_.characterEffect4010ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_7 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 and not isNil(var_166_6) then
				if arg_163_1.var_.characterEffect4010ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_163_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_7)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect4010ui_story then
				arg_163_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_163_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_8 = 0
			local var_166_9 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(411161039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 12 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 12)

				if (12 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 12)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161039", "story_v_out_411161.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161039", "story_v_out_411161.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_411161", "411161039", "story_v_out_411161.awb")

						arg_163_1:RecordAudio("411161039", var_166_15)
						arg_163_1:RecordAudio("411161039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411161", "411161039", "story_v_out_411161.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411161", "411161039", "story_v_out_411161.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play411161040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411161040
		arg_167_1.duration_ = 7.27

		local var_167_0 = {
			zh = 7.066,
			ja = 7.266
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
				arg_167_0:Play411161041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) and arg_167_1.var_.characterEffect1095ui_story == nil then
				arg_167_1.var_.characterEffect1095ui_story = arg_167_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) then
				if arg_167_1.var_.characterEffect1095ui_story and not isNil(arg_167_1.actors_["1095ui_story"]) then
					arg_167_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1095ui_story"]) and arg_167_1.var_.characterEffect1095ui_story then
				arg_167_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_170_1 = arg_167_1.actors_["4010ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect4010ui_story == nil then
				arg_167_1.var_.characterEffect4010ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect4010ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect4010ui_story then
				arg_167_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.55

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(411161040)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 22 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 22)

				if (22 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 22)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161040", "story_v_out_411161.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161040", "story_v_out_411161.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_411161", "411161040", "story_v_out_411161.awb")

						arg_167_1:RecordAudio("411161040", var_170_11)
						arg_167_1:RecordAudio("411161040", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411161", "411161040", "story_v_out_411161.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411161", "411161040", "story_v_out_411161.awb")
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
	Play411161041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411161041
		arg_171_1.duration_ = 6

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411161042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_9000

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["4010ui_story"]) and arg_171_1.var_.characterEffect4010ui_story == nil then
				arg_171_1.var_.characterEffect4010ui_story = arg_171_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["4010ui_story"]) then
				if arg_171_1.var_.characterEffect4010ui_story and not isNil(arg_171_1.actors_["4010ui_story"]) then
					arg_171_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_171_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["4010ui_story"]) and arg_171_1.var_.characterEffect4010ui_story then
				arg_171_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_171_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_174_1 = arg_171_1.actors_["1095ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1095ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["4010ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos4010ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, 100, 0)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if 0.416666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.416666666666667 + arg_174_0 then
				local var_174_5 = arg_171_1.var_.effect666666

				if not arg_171_1.var_.effect666666 then
					var_174_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_174_5.name = "666"
					arg_171_1.var_.effect666666 = var_174_5
				else
					var_174_5.transform:SetParent(var_174_9000)
				end

				var_174_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_174_7 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_8 = 0.416666666666667

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 then
				local var_174_9 = Color.New(1, 1, 1)

				var_174_9.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_7) / var_174_8)
				arg_171_1.mask_.color = var_174_9
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 then
				local var_174_10 = Color.New(1, 1, 1)

				arg_171_1.mask_.enabled = false
				var_174_10.a = 0
				arg_171_1.mask_.color = var_174_10
			end

			local var_174_11 = 0.416666666666667

			if 0.416666666666667 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_11 + 0.583333333333333 and arg_171_1.time_ < var_174_11 + 0.583333333333333 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_12 = 1
			local var_174_13 = 1.55

			if 1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_14 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_14:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411161041).content)

				arg_171_1.text_.text = var_174_15

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 62 <= 0 and var_174_13 or var_174_13 * (utf8.len(var_174_15) / 62)

				if (62 <= 0 and var_174_13 or var_174_13 * (utf8.len(var_174_15) / 62)) > 0 and var_174_13 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17
					var_174_12 = var_174_12 + 0.3

					if var_174_17 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_15
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_18 = var_174_12 + 0.3
			local var_174_19 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_18) / var_174_19

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play411161042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 411161042
		arg_177_1.duration_ = 4.1

		local var_177_0 = {
			zh = 4.033,
			ja = 4.1
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
				arg_177_0:Play411161043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = arg_177_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(arg_177_1.actors_["1095ui_story"]) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				if arg_177_1.var_.effect666666 then
					Object.Destroy(arg_177_1.var_.effect666666)

					arg_177_1.var_.effect666666 = nil
				end
			end

			local var_180_3 = arg_177_1.actors_["1095ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_3.localPosition
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_3.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_177_1.time_ - 0) / var_180_4)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			local var_180_5 = 0
			local var_180_6 = 0.5

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(411161042)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 20 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 20)

				if (20 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 20)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161042", "story_v_out_411161.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_411161", "411161042", "story_v_out_411161.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_411161", "411161042", "story_v_out_411161.awb")

						arg_177_1:RecordAudio("411161042", var_180_12)
						arg_177_1:RecordAudio("411161042", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_411161", "411161042", "story_v_out_411161.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_411161", "411161042", "story_v_out_411161.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play411161043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 411161043
		arg_181_1.duration_ = 3.97

		local var_181_0 = {
			zh = 3.966,
			ja = 2.866
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
				arg_181_0:Play411161044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.475

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(411161043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 19 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 19)

				if (19 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 19)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161043", "story_v_out_411161.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161043", "story_v_out_411161.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_411161", "411161043", "story_v_out_411161.awb")

						arg_181_1:RecordAudio("411161043", var_184_6)
						arg_181_1:RecordAudio("411161043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_411161", "411161043", "story_v_out_411161.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_411161", "411161043", "story_v_out_411161.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play411161044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 411161044
		arg_185_1.duration_ = 6.1

		local var_185_0 = {
			zh = 3.6,
			ja = 6.1
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play411161045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story == nil then
				arg_185_1.var_.characterEffect1095ui_story = arg_185_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) then
				if arg_185_1.var_.characterEffect1095ui_story and not isNil(arg_185_1.actors_["1095ui_story"]) then
					arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story then
				arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_188_1 = arg_185_1.actors_["4010ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect4010ui_story == nil then
				arg_185_1.var_.characterEffect4010ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect4010ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect4010ui_story then
				arg_185_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["1095ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1095ui_story = var_188_4.localPosition
			end

			local var_188_5 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 then
				var_188_4.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_185_1.time_ - 0) / var_188_5)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 then
				var_188_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			local var_188_6 = arg_185_1.actors_["4010ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos4010ui_story = var_188_6.localPosition
			end

			local var_188_7 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				var_188_6.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_185_1.time_ - 0) / var_188_7)
				var_188_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_6.position).x, (manager.ui.mainCamera.transform.position - var_188_6.position).y, (manager.ui.mainCamera.transform.position - var_188_6.position).z)
				var_188_6.localEulerAngles.z = 0
				var_188_6.localEulerAngles.x = 0
				var_188_6.localEulerAngles = var_188_6.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				var_188_6.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_188_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_6.position).x, (manager.ui.mainCamera.transform.position - var_188_6.position).y, (manager.ui.mainCamera.transform.position - var_188_6.position).z)
				var_188_6.localEulerAngles.z = 0
				var_188_6.localEulerAngles.x = 0
				var_188_6.localEulerAngles = var_188_6.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_188_8 = 0
			local var_188_9 = 0.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(411161044)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 12 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 12)

				if (12 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 12)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161044", "story_v_out_411161.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161044", "story_v_out_411161.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_411161", "411161044", "story_v_out_411161.awb")

						arg_185_1:RecordAudio("411161044", var_188_15)
						arg_185_1:RecordAudio("411161044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_411161", "411161044", "story_v_out_411161.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_411161", "411161044", "story_v_out_411161.awb")
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
				actorName = "4010ui_story",
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
	Play411161045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 411161045
		arg_189_1.duration_ = 8.03

		local var_189_0 = {
			zh = 5.5,
			ja = 8.033
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
				arg_189_0:Play411161046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = arg_189_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) then
				if arg_189_1.var_.characterEffect1095ui_story and not isNil(arg_189_1.actors_["1095ui_story"]) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["4010ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect4010ui_story == nil then
				arg_189_1.var_.characterEffect4010ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect4010ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_189_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect4010ui_story then
				arg_189_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_189_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_4 = 0
			local var_192_5 = 0.725

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
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

				local var_192_6 = arg_189_1:GetWordFromCfg(411161045)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 29 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 29)

				if (29 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 29)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161045", "story_v_out_411161.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161045", "story_v_out_411161.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_411161", "411161045", "story_v_out_411161.awb")

						arg_189_1:RecordAudio("411161045", var_192_11)
						arg_189_1:RecordAudio("411161045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_411161", "411161045", "story_v_out_411161.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_411161", "411161045", "story_v_out_411161.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play411161046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 411161046
		arg_193_1.duration_ = 9.3

		local var_193_0 = {
			zh = 6.833,
			ja = 9.3
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
				arg_193_0:Play411161047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.825

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

				local var_196_1 = arg_193_1:GetWordFromCfg(411161046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 33 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 33)

				if (33 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 33)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161046", "story_v_out_411161.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_411161", "411161046", "story_v_out_411161.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_411161", "411161046", "story_v_out_411161.awb")

						arg_193_1:RecordAudio("411161046", var_196_6)
						arg_193_1:RecordAudio("411161046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_411161", "411161046", "story_v_out_411161.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_411161", "411161046", "story_v_out_411161.awb")
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
	Play411161047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 411161047
		arg_197_1.duration_ = 4.3

		local var_197_0 = {
			zh = 3.166,
			ja = 4.3
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
				arg_197_0:Play411161048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1095ui_story"]) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = arg_197_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1095ui_story"]) then
				if arg_197_1.var_.characterEffect1095ui_story and not isNil(arg_197_1.actors_["1095ui_story"]) then
					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1095ui_story"]) and arg_197_1.var_.characterEffect1095ui_story then
				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_200_1 = arg_197_1.actors_["4010ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4010ui_story == nil then
				arg_197_1.var_.characterEffect4010ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect4010ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4010ui_story then
				arg_197_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_200_4 = 0
			local var_200_5 = 0.225

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(411161047)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 9 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 9)

				if (9 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 9)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161047", "story_v_out_411161.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161047", "story_v_out_411161.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_411161", "411161047", "story_v_out_411161.awb")

						arg_197_1:RecordAudio("411161047", var_200_11)
						arg_197_1:RecordAudio("411161047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_411161", "411161047", "story_v_out_411161.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_411161", "411161047", "story_v_out_411161.awb")
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

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play411161048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 411161048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play411161049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["4010ui_story"]) and arg_201_1.var_.characterEffect4010ui_story == nil then
				arg_201_1.var_.characterEffect4010ui_story = arg_201_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["4010ui_story"]) then
				if arg_201_1.var_.characterEffect4010ui_story and not isNil(arg_201_1.actors_["4010ui_story"]) then
					arg_201_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_201_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["4010ui_story"]) and arg_201_1.var_.characterEffect4010ui_story then
				arg_201_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_201_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.55

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(411161048).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 22 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 22)

				if (22 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 22)) > 0 and var_204_2 < var_204_5 then
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
	Play411161049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411161049
		arg_205_1.duration_ = 2.47

		local var_205_0 = {
			zh = 1.333,
			ja = 2.466
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
				arg_205_0:Play411161050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1095ui_story"]) and arg_205_1.var_.characterEffect1095ui_story == nil then
				arg_205_1.var_.characterEffect1095ui_story = arg_205_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1095ui_story"]) then
				if arg_205_1.var_.characterEffect1095ui_story and not isNil(arg_205_1.actors_["1095ui_story"]) then
					arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1095ui_story"]) and arg_205_1.var_.characterEffect1095ui_story then
				arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_208_2 = 0
			local var_208_3 = 0.15

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(411161049)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 6 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 6)

				if (6 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 6)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161049", "story_v_out_411161.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_411161", "411161049", "story_v_out_411161.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_411161", "411161049", "story_v_out_411161.awb")

						arg_205_1:RecordAudio("411161049", var_208_9)
						arg_205_1:RecordAudio("411161049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_411161", "411161049", "story_v_out_411161.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_411161", "411161049", "story_v_out_411161.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play411161050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 411161050
		arg_209_1.duration_ = 4.3

		local var_209_0 = {
			zh = 4.3,
			ja = 3.9
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
				arg_209_0:Play411161051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1095ui_story"]) and arg_209_1.var_.characterEffect1095ui_story == nil then
				arg_209_1.var_.characterEffect1095ui_story = arg_209_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1095ui_story"]) then
				if arg_209_1.var_.characterEffect1095ui_story and not isNil(arg_209_1.actors_["1095ui_story"]) then
					arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1095ui_story"]) and arg_209_1.var_.characterEffect1095ui_story then
				arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_212_1 = arg_209_1.actors_["4010ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4010ui_story == nil then
				arg_209_1.var_.characterEffect4010ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect4010ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4010ui_story then
				arg_209_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.475

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(411161050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 19 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 19)

				if (19 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 19)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161050", "story_v_out_411161.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161050", "story_v_out_411161.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_411161", "411161050", "story_v_out_411161.awb")

						arg_209_1:RecordAudio("411161050", var_212_11)
						arg_209_1:RecordAudio("411161050", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_411161", "411161050", "story_v_out_411161.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_411161", "411161050", "story_v_out_411161.awb")
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

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play411161051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 411161051
		arg_213_1.duration_ = 5.07

		local var_213_0 = {
			zh = 1.999999999999,
			ja = 5.066
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
				arg_213_0:Play411161052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_216_0 = 0
			local var_216_1 = 0.2

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(411161051)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 8 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 8)

				if (8 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 8)) > 0 and var_216_1 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161051", "story_v_out_411161.awb") ~= 0 then
					local var_216_6 = manager.audio:GetVoiceLength("story_v_out_411161", "411161051", "story_v_out_411161.awb") / 1000

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end

					if var_216_2.prefab_name ~= "" and arg_213_1.actors_[var_216_2.prefab_name] ~= nil then
						local var_216_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_2.prefab_name].transform, "story_v_out_411161", "411161051", "story_v_out_411161.awb")

						arg_213_1:RecordAudio("411161051", var_216_7)
						arg_213_1:RecordAudio("411161051", var_216_7)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_411161", "411161051", "story_v_out_411161.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_411161", "411161051", "story_v_out_411161.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play411161052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 411161052
		arg_217_1.duration_ = 9.33

		local var_217_0 = {
			zh = 9.3,
			ja = 9.333
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
				arg_217_0:Play411161053(arg_217_1)
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

			local var_220_2 = arg_217_1.actors_["4010ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect4010ui_story == nil then
				arg_217_1.var_.characterEffect4010ui_story = var_220_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_3 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.characterEffect4010ui_story and not isNil(var_220_2) then
					arg_217_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_217_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_3)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect4010ui_story then
				arg_217_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_217_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_220_4 = 0
			local var_220_5 = 0.975

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
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

				local var_220_6 = arg_217_1:GetWordFromCfg(411161052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 39 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 39)

				if (39 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 39)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161052", "story_v_out_411161.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161052", "story_v_out_411161.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_411161", "411161052", "story_v_out_411161.awb")

						arg_217_1:RecordAudio("411161052", var_220_11)
						arg_217_1:RecordAudio("411161052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_411161", "411161052", "story_v_out_411161.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_411161", "411161052", "story_v_out_411161.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play411161053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 411161053
		arg_221_1.duration_ = 8.27

		local var_221_0 = {
			zh = 4.5,
			ja = 8.266
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
				arg_221_0:Play411161054(arg_221_1)
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

			local var_224_1 = arg_221_1.actors_["4010ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect4010ui_story == nil then
				arg_221_1.var_.characterEffect4010ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect4010ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect4010ui_story then
				arg_221_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_224_4 = 0
			local var_224_5 = 0.425

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(411161053)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 17 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 17)

				if (17 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 17)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161053", "story_v_out_411161.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161053", "story_v_out_411161.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_411161", "411161053", "story_v_out_411161.awb")

						arg_221_1:RecordAudio("411161053", var_224_11)
						arg_221_1:RecordAudio("411161053", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_411161", "411161053", "story_v_out_411161.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_411161", "411161053", "story_v_out_411161.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play411161054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 411161054
		arg_225_1.duration_ = 8.3

		local var_225_0 = {
			zh = 5.4,
			ja = 8.3
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
				arg_225_0:Play411161055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_228_0 = 0
			local var_228_1 = 0.525

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(411161054)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 21 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 21)

				if (21 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 21)) > 0 and var_228_1 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161054", "story_v_out_411161.awb") ~= 0 then
					local var_228_6 = manager.audio:GetVoiceLength("story_v_out_411161", "411161054", "story_v_out_411161.awb") / 1000

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end

					if var_228_2.prefab_name ~= "" and arg_225_1.actors_[var_228_2.prefab_name] ~= nil then
						local var_228_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_2.prefab_name].transform, "story_v_out_411161", "411161054", "story_v_out_411161.awb")

						arg_225_1:RecordAudio("411161054", var_228_7)
						arg_225_1:RecordAudio("411161054", var_228_7)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_411161", "411161054", "story_v_out_411161.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_411161", "411161054", "story_v_out_411161.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play411161055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 411161055
		arg_229_1.duration_ = 10.6

		local var_229_0 = {
			zh = 5.066,
			ja = 10.6
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
				arg_229_0:Play411161056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) and arg_229_1.var_.characterEffect1095ui_story == nil then
				arg_229_1.var_.characterEffect1095ui_story = arg_229_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) then
				if arg_229_1.var_.characterEffect1095ui_story and not isNil(arg_229_1.actors_["1095ui_story"]) then
					arg_229_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) and arg_229_1.var_.characterEffect1095ui_story then
				arg_229_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["4010ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect4010ui_story == nil then
				arg_229_1.var_.characterEffect4010ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect4010ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_229_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect4010ui_story then
				arg_229_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_229_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.525

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(411161055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 21 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 21)

				if (21 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 21)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161055", "story_v_out_411161.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161055", "story_v_out_411161.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_411161", "411161055", "story_v_out_411161.awb")

						arg_229_1:RecordAudio("411161055", var_232_11)
						arg_229_1:RecordAudio("411161055", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_411161", "411161055", "story_v_out_411161.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_411161", "411161055", "story_v_out_411161.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play411161056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 411161056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play411161057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1095ui_story = arg_233_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).z)
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles = arg_233_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).z)
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles = arg_233_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1095ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1095ui_story == nil then
				arg_233_1.var_.characterEffect1095ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1095ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_2)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1095ui_story then
				arg_233_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_236_3 = arg_233_1.actors_["4010ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos4010ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, 100, 0)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			local var_236_5 = arg_233_1.actors_["4010ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect4010ui_story == nil then
				arg_233_1.var_.characterEffect4010ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect4010ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_233_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_6)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect4010ui_story then
				arg_233_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_233_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_236_7 = 0
			local var_236_8 = 0.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_9 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(411161056).content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 16 <= 0 and var_236_8 or var_236_8 * (utf8.len(var_236_9) / 16)

				if (16 <= 0 and var_236_8 or var_236_8 * (utf8.len(var_236_9) / 16)) > 0 and var_236_8 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_7
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_7) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_7 + var_236_12 and arg_233_1.time_ < var_236_7 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play411161057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 411161057
		arg_237_1.duration_ = 4.43

		local var_237_0 = {
			zh = 3.966,
			ja = 4.433
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play411161058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1095ui_story = arg_237_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).z)
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles = arg_237_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_237_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1095ui_story"].transform.position).z)
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1095ui_story"].transform.localEulerAngles = arg_237_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1095ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1095ui_story == nil then
				arg_237_1.var_.characterEffect1095ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1095ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1095ui_story then
				arg_237_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.5

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(411161057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 20 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 20)

				if (20 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 20)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161057", "story_v_out_411161.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161057", "story_v_out_411161.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_411161", "411161057", "story_v_out_411161.awb")

						arg_237_1:RecordAudio("411161057", var_240_11)
						arg_237_1:RecordAudio("411161057", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_411161", "411161057", "story_v_out_411161.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_411161", "411161057", "story_v_out_411161.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play411161058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 411161058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play411161059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1095ui_story = arg_241_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).z)
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles = arg_241_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1095ui_story"].transform.position).z)
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1095ui_story"].transform.localEulerAngles = arg_241_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1095ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1095ui_story == nil then
				arg_241_1.var_.characterEffect1095ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1095ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1095ui_story then
				arg_241_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_244_3 = 0
			local var_244_4 = 0.6

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(411161058).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 24 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 24)

				if (24 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 24)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play411161059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 411161059
		arg_245_1.duration_ = 5.73

		local var_245_0 = {
			zh = 2.1,
			ja = 5.733
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play411161060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos4010ui_story = arg_245_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).z)
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles = arg_245_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_245_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).z)
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles = arg_245_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["4010ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4010ui_story == nil then
				arg_245_1.var_.characterEffect4010ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect4010ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4010ui_story then
				arg_245_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.25

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(411161059)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 10 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 10)

				if (10 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 10)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161059", "story_v_out_411161.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161059", "story_v_out_411161.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_411161", "411161059", "story_v_out_411161.awb")

						arg_245_1:RecordAudio("411161059", var_248_11)
						arg_245_1:RecordAudio("411161059", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_411161", "411161059", "story_v_out_411161.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_411161", "411161059", "story_v_out_411161.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play411161060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 411161060
		arg_249_1.duration_ = 10.5

		local var_249_0 = {
			zh = 3.8,
			ja = 10.5
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play411161061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1095ui_story = arg_249_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).z)
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles = arg_249_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_249_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).z)
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles = arg_249_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1095ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1095ui_story == nil then
				arg_249_1.var_.characterEffect1095ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1095ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1095ui_story then
				arg_249_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_4 = arg_249_1.actors_["4010ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos4010ui_story = var_252_4.localPosition
			end

			local var_252_5 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 then
				var_252_4.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_249_1.time_ - 0) / var_252_5)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 then
				var_252_4.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			local var_252_6 = arg_249_1.actors_["4010ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect4010ui_story == nil then
				arg_249_1.var_.characterEffect4010ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 and not isNil(var_252_6) then
				if arg_249_1.var_.characterEffect4010ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_249_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_7)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect4010ui_story then
				arg_249_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_249_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_252_8 = 0
			local var_252_9 = 0.475

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(411161060)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 19 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 19)

				if (19 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 19)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161060", "story_v_out_411161.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161060", "story_v_out_411161.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_411161", "411161060", "story_v_out_411161.awb")

						arg_249_1:RecordAudio("411161060", var_252_15)
						arg_249_1:RecordAudio("411161060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_411161", "411161060", "story_v_out_411161.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_411161", "411161060", "story_v_out_411161.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play411161061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 411161061
		arg_253_1.duration_ = 5.9

		local var_253_0 = {
			zh = 5.9,
			ja = 4.3
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play411161062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) and arg_253_1.var_.characterEffect1095ui_story == nil then
				arg_253_1.var_.characterEffect1095ui_story = arg_253_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) then
				if arg_253_1.var_.characterEffect1095ui_story and not isNil(arg_253_1.actors_["1095ui_story"]) then
					arg_253_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) and arg_253_1.var_.characterEffect1095ui_story then
				arg_253_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_256_1 = arg_253_1.actors_["4010ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4010ui_story == nil then
				arg_253_1.var_.characterEffect4010ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect4010ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4010ui_story then
				arg_253_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_256_4 = 0
			local var_256_5 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(411161061)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 21 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 21)

				if (21 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 21)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161061", "story_v_out_411161.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161061", "story_v_out_411161.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_411161", "411161061", "story_v_out_411161.awb")

						arg_253_1:RecordAudio("411161061", var_256_11)
						arg_253_1:RecordAudio("411161061", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_411161", "411161061", "story_v_out_411161.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_411161", "411161061", "story_v_out_411161.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play411161062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 411161062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play411161063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["4010ui_story"]) and arg_257_1.var_.characterEffect4010ui_story == nil then
				arg_257_1.var_.characterEffect4010ui_story = arg_257_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["4010ui_story"]) then
				if arg_257_1.var_.characterEffect4010ui_story and not isNil(arg_257_1.actors_["4010ui_story"]) then
					arg_257_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["4010ui_story"]) and arg_257_1.var_.characterEffect4010ui_story then
				arg_257_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 0.525

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

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(411161062).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 21 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 21)

				if (21 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 21)) > 0 and var_260_2 < var_260_5 then
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
	Play411161063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 411161063
		arg_261_1.duration_ = 4

		local var_261_0 = {
			zh = 3.833,
			ja = 4
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
				arg_261_0:Play411161064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_brake", "")
			end

			local var_264_1 = arg_261_1.actors_["4010ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect4010ui_story == nil then
				arg_261_1.var_.characterEffect4010ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect4010ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect4010ui_story then
				arg_261_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_264_4 = 0
			local var_264_5 = 0.375

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(411161063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 15 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 15)

				if (15 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 15)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161063", "story_v_out_411161.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161063", "story_v_out_411161.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_411161", "411161063", "story_v_out_411161.awb")

						arg_261_1:RecordAudio("411161063", var_264_11)
						arg_261_1:RecordAudio("411161063", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_411161", "411161063", "story_v_out_411161.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_411161", "411161063", "story_v_out_411161.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play411161064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 411161064
		arg_265_1.duration_ = 5.88

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play411161065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1095ui_story = arg_265_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).z)
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles = arg_265_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1095ui_story"].transform.position).z)
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1095ui_story"].transform.localEulerAngles = arg_265_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1095ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1095ui_story == nil then
				arg_265_1.var_.characterEffect1095ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1095ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_2)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1095ui_story then
				arg_265_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_268_3 = arg_265_1.actors_["4010ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos4010ui_story = var_268_3.localPosition
			end

			local var_268_4 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				var_268_3.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_4)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				var_268_3.localPosition = Vector3.New(0, 100, 0)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			local var_268_5 = arg_265_1.actors_["4010ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect4010ui_story == nil then
				arg_265_1.var_.characterEffect4010ui_story = var_268_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.characterEffect4010ui_story and not isNil(var_268_5) then
					arg_265_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_265_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_6)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect4010ui_story then
				arg_265_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_265_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_268_7 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 0.366666666666667 + arg_268_0 then
				arg_265_1.var_.shakeOldPos = var_268_7.localPosition
			end

			local var_268_8 = 0.366666666666667

			if 0.366666666666667 <= arg_265_1.time_ and arg_265_1.time_ < 0.366666666666667 + var_268_8 then
				local var_268_9, var_268_10 = math.modf((arg_265_1.time_ - 0.366666666666667) / 0.066)

				var_268_7.localPosition = Vector3.New(var_268_10 * 0.13, var_268_10 * 0.13, var_268_10 * 0.13) + arg_265_1.var_.shakeOldPos
			end

			if arg_265_1.time_ >= 0.366666666666667 + var_268_8 and arg_265_1.time_ < 0.366666666666667 + var_268_8 + arg_268_0 then
				var_268_7.localPosition = arg_265_1.var_.shakeOldPos
			end

			local var_268_11 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = false

				arg_265_1:SetGaussion(false)
			end

			local var_268_12 = 0.366666666666667

			if var_268_11 <= arg_265_1.time_ and arg_265_1.time_ < var_268_11 + var_268_12 then
				local var_268_13 = Color.New(1, 1, 1)

				var_268_13.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_11) / var_268_12)
				arg_265_1.mask_.color = var_268_13
			end

			if arg_265_1.time_ >= var_268_11 + var_268_12 and arg_265_1.time_ < var_268_11 + var_268_12 + arg_268_0 then
				local var_268_14 = Color.New(1, 1, 1)

				arg_265_1.mask_.enabled = false
				var_268_14.a = 0
				arg_265_1.mask_.color = var_268_14
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_15 = 0.875
			local var_268_16 = 0.125

			if 0.875 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_17 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_17:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(411161064).content)

				arg_265_1.text_.text = var_268_18

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 5 <= 0 and var_268_16 or var_268_16 * (utf8.len(var_268_18) / 5)

				if (5 <= 0 and var_268_16 or var_268_16 * (utf8.len(var_268_18) / 5)) > 0 and var_268_16 < var_268_20 then
					arg_265_1.talkMaxDuration = var_268_20
					var_268_15 = var_268_15 + 0.3

					if var_268_20 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_18
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_21 = var_268_15 + 0.3
			local var_268_22 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_21) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_21 + var_268_22 and arg_265_1.time_ < var_268_21 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play411161065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411161065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411161066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.775

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(411161065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 31 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 31)

				if (31 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 31)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411161066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411161066
		arg_275_1.duration_ = 2

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play411161067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos4010ui_story = arg_275_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["4010ui_story"].transform.position).z)
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["4010ui_story"].transform.localEulerAngles = arg_275_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
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

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_278_4 = 0
			local var_278_5 = 0.075

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
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

				local var_278_6 = arg_275_1:GetWordFromCfg(411161066)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 3 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 3)

				if (3 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 3)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161066", "story_v_out_411161.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_411161", "411161066", "story_v_out_411161.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_411161", "411161066", "story_v_out_411161.awb")

						arg_275_1:RecordAudio("411161066", var_278_11)
						arg_275_1:RecordAudio("411161066", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411161", "411161066", "story_v_out_411161.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411161", "411161066", "story_v_out_411161.awb")
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
				actorName = "4010ui_story",
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
	Play411161067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411161067
		arg_279_1.duration_ = 3.13

		local var_279_0 = {
			zh = 2.1,
			ja = 3.133
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
			arg_279_1.auto_ = false
		end

		function arg_279_1.playNext_(arg_281_0)
			arg_279_1.onStoryFinished_()
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1095ui_story = arg_279_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).z)
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles = arg_279_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_279_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1095ui_story"].transform.position).z)
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1095ui_story"].transform.localEulerAngles = arg_279_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1095ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1095ui_story == nil then
				arg_279_1.var_.characterEffect1095ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1095ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1095ui_story then
				arg_279_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_282_4 = arg_279_1.actors_["4010ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos4010ui_story = var_282_4.localPosition
			end

			local var_282_5 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_5 then
				var_282_4.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_5)
				var_282_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_4.position).x, (manager.ui.mainCamera.transform.position - var_282_4.position).y, (manager.ui.mainCamera.transform.position - var_282_4.position).z)
				var_282_4.localEulerAngles.z = 0
				var_282_4.localEulerAngles.x = 0
				var_282_4.localEulerAngles = var_282_4.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_5 and arg_279_1.time_ < 0 + var_282_5 + arg_282_0 then
				var_282_4.localPosition = Vector3.New(0, 100, 0)
				var_282_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_4.position).x, (manager.ui.mainCamera.transform.position - var_282_4.position).y, (manager.ui.mainCamera.transform.position - var_282_4.position).z)
				var_282_4.localEulerAngles.z = 0
				var_282_4.localEulerAngles.x = 0
				var_282_4.localEulerAngles = var_282_4.localEulerAngles
			end

			local var_282_6 = arg_279_1.actors_["4010ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect4010ui_story == nil then
				arg_279_1.var_.characterEffect4010ui_story = var_282_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_7 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 and not isNil(var_282_6) then
				if arg_279_1.var_.characterEffect4010ui_story and not isNil(var_282_6) then
					arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_7)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect4010ui_story then
				arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_282_8 = 0
			local var_282_9 = 0.225

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(411161067)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 9 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 9)

				if (9 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 9)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411161", "411161067", "story_v_out_411161.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_411161", "411161067", "story_v_out_411161.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_411161", "411161067", "story_v_out_411161.awb")

						arg_279_1:RecordAudio("411161067", var_282_15)
						arg_279_1:RecordAudio("411161067", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_411161", "411161067", "story_v_out_411161.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_411161", "411161067", "story_v_out_411161.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10b",
		"TextureConfig/Background/ST75"
	},
	voices = {
		"story_v_out_411161.awb"
	}
}
