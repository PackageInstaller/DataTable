return {
	Play120132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J16f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J16f")
				var_4_0.name = "J16f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J16f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J16f

				arg_1_1.bgs_.J16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J16f" then
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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
			local var_4_15 = 1.025

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(120132001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 41 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 41)

				if (41 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 41)) > 0 and var_4_15 < var_4_19 then
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
	Play120132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120132002
		arg_9_1.duration_ = 2.4

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_9_0:Play120132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1075ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1075ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1075ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1075ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1075ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1075ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = "1069ui_story"

			if arg_9_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_12_6 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_9_1.stage_.transform)

				var_12_6.name = var_12_5
				var_12_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_5] = var_12_6

				local var_12_7 = var_12_6:GetComponentInChildren(typeof(CharacterEffect))

				var_12_7.enabled = true

				local var_12_8 = GameObjectTools.GetOrAddComponent(var_12_6, typeof(DynamicBoneHelper))

				if var_12_8 then
					var_12_8:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_7.transform, false)

				arg_9_1.var_[var_12_5 .. "Animator"] = var_12_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_5 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_5 .. "LipSync"] = var_12_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_9 = arg_9_1.actors_["1069ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1069ui_story = var_12_9.localPosition
			end

			local var_12_10 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				var_12_9.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_9_1.time_ - 0) / var_12_10)
				var_12_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_9.position).x, (manager.ui.mainCamera.transform.position - var_12_9.position).y, (manager.ui.mainCamera.transform.position - var_12_9.position).z)
				var_12_9.localEulerAngles.z = 0
				var_12_9.localEulerAngles.x = 0
				var_12_9.localEulerAngles = var_12_9.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 then
				var_12_9.localPosition = Vector3.New(0.7, -1, -6)
				var_12_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_9.position).x, (manager.ui.mainCamera.transform.position - var_12_9.position).y, (manager.ui.mainCamera.transform.position - var_12_9.position).z)
				var_12_9.localEulerAngles.z = 0
				var_12_9.localEulerAngles.x = 0
				var_12_9.localEulerAngles = var_12_9.localEulerAngles
			end

			local var_12_11 = arg_9_1.actors_["1075ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.characterEffect1075ui_story == nil then
				arg_9_1.var_.characterEffect1075ui_story = var_12_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_12 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 and not isNil(var_12_11) then
				if arg_9_1.var_.characterEffect1075ui_story and not isNil(var_12_11) then
					arg_9_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.characterEffect1075ui_story then
				arg_9_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_12_14 = arg_9_1.actors_["1069ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1069ui_story == nil then
				arg_9_1.var_.characterEffect1069ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_15 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 and not isNil(var_12_14) then
				if arg_9_1.var_.characterEffect1069ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_15)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1069ui_story then
				arg_9_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_12_16 = 0
			local var_12_17 = 0.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(120132002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 9 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 9)

				if (9 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 9)) > 0 and var_12_17 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_16
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132002", "story_v_out_120132.awb") ~= 0 then
					local var_12_22 = manager.audio:GetVoiceLength("story_v_out_120132", "120132002", "story_v_out_120132.awb") / 1000

					if var_12_22 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_16
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_120132", "120132002", "story_v_out_120132.awb")

						arg_9_1:RecordAudio("120132002", var_12_23)
						arg_9_1:RecordAudio("120132002", var_12_23)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120132", "120132002", "story_v_out_120132.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120132", "120132002", "story_v_out_120132.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_24 = math.max(var_12_17, arg_9_1.talkMaxDuration)

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_24 and arg_9_1.time_ < var_12_16 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play120132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120132003
		arg_13_1.duration_ = 3.03

		local var_13_0 = {
			zh = 2.466666666666,
			ja = 3.033
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
				arg_13_0:Play120132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1075ui_story"]) and arg_13_1.var_.characterEffect1075ui_story == nil then
				arg_13_1.var_.characterEffect1075ui_story = arg_13_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1075ui_story"]) then
				if arg_13_1.var_.characterEffect1075ui_story and not isNil(arg_13_1.actors_["1075ui_story"]) then
					arg_13_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1075ui_story"]) and arg_13_1.var_.characterEffect1075ui_story then
				arg_13_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_16_1 = arg_13_1.actors_["1069ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1069ui_story == nil then
				arg_13_1.var_.characterEffect1069ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1069ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1069ui_story then
				arg_13_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_16_4 = 0
			local var_16_5 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(120132003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 12 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 12)

				if (12 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 12)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132003", "story_v_out_120132.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_120132", "120132003", "story_v_out_120132.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_120132", "120132003", "story_v_out_120132.awb")

						arg_13_1:RecordAudio("120132003", var_16_11)
						arg_13_1:RecordAudio("120132003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_120132", "120132003", "story_v_out_120132.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_120132", "120132003", "story_v_out_120132.awb")
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

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120132004
		arg_17_1.duration_ = 9.8

		local var_17_0 = {
			zh = 6.4,
			ja = 9.8
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
				arg_17_0:Play120132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.8

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(120132004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 32 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 32)

				if (32 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 32)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132004", "story_v_out_120132.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_120132", "120132004", "story_v_out_120132.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_120132", "120132004", "story_v_out_120132.awb")

						arg_17_1:RecordAudio("120132004", var_20_6)
						arg_17_1:RecordAudio("120132004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120132", "120132004", "story_v_out_120132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120132", "120132004", "story_v_out_120132.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play120132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120132005
		arg_21_1.duration_ = 8.6

		local var_21_0 = {
			zh = 8.6,
			ja = 7.766
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
				arg_21_0:Play120132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(120132005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 43)

				if (43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 43)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132005", "story_v_out_120132.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_120132", "120132005", "story_v_out_120132.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_120132", "120132005", "story_v_out_120132.awb")

						arg_21_1:RecordAudio("120132005", var_24_6)
						arg_21_1:RecordAudio("120132005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120132", "120132005", "story_v_out_120132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120132", "120132005", "story_v_out_120132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play120132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120132006
		arg_25_1.duration_ = 4.03

		local var_25_0 = {
			zh = 3.733,
			ja = 4.033
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
				arg_25_0:Play120132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action426")
			end

			local var_28_0 = 0
			local var_28_1 = 0.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(120132006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 14 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 14)

				if (14 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 14)) > 0 and var_28_1 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132006", "story_v_out_120132.awb") ~= 0 then
					local var_28_6 = manager.audio:GetVoiceLength("story_v_out_120132", "120132006", "story_v_out_120132.awb") / 1000

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_120132", "120132006", "story_v_out_120132.awb")

						arg_25_1:RecordAudio("120132006", var_28_7)
						arg_25_1:RecordAudio("120132006", var_28_7)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120132", "120132006", "story_v_out_120132.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120132", "120132006", "story_v_out_120132.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play120132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120132007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1069ui_story"]) and arg_29_1.var_.characterEffect1069ui_story == nil then
				arg_29_1.var_.characterEffect1069ui_story = arg_29_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1069ui_story"]) then
				if arg_29_1.var_.characterEffect1069ui_story and not isNil(arg_29_1.actors_["1069ui_story"]) then
					arg_29_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1069ui_story"]) and arg_29_1.var_.characterEffect1069ui_story then
				arg_29_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 1.275

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

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(120132007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 51 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 51)

				if (51 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 51)) > 0 and var_32_2 < var_32_5 then
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
	Play120132008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120132008
		arg_33_1.duration_ = 6.57

		local var_33_0 = {
			zh = 4.366,
			ja = 6.566
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
				arg_33_0:Play120132009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1069ui_story"]) and arg_33_1.var_.characterEffect1069ui_story == nil then
				arg_33_1.var_.characterEffect1069ui_story = arg_33_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1069ui_story"]) then
				if arg_33_1.var_.characterEffect1069ui_story and not isNil(arg_33_1.actors_["1069ui_story"]) then
					arg_33_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1069ui_story"]) and arg_33_1.var_.characterEffect1069ui_story then
				arg_33_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_36_2 = 0
			local var_36_3 = 0.575

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(120132008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 23 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 23)

				if (23 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 23)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132008", "story_v_out_120132.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_120132", "120132008", "story_v_out_120132.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_120132", "120132008", "story_v_out_120132.awb")

						arg_33_1:RecordAudio("120132008", var_36_9)
						arg_33_1:RecordAudio("120132008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120132", "120132008", "story_v_out_120132.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120132", "120132008", "story_v_out_120132.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play120132009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120132009
		arg_37_1.duration_ = 4.87

		local var_37_0 = {
			zh = 1.6,
			ja = 4.866
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
				arg_37_0:Play120132010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1069ui_story = arg_37_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).z)
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles = arg_37_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1069ui_story"].transform.position).z)
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1069ui_story"].transform.localEulerAngles = arg_37_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1075ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1075ui_story = var_40_1.localPosition
			end

			local var_40_2 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 then
				var_40_1.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_2)
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

			local var_40_3 = manager.ui.mainCamera.transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_3.localPosition
			end

			local var_40_4 = 0.6

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				local var_40_5, var_40_6 = math.modf((arg_37_1.time_ - 0) / 0.066)

				var_40_3.localPosition = Vector3.New(var_40_6 * 0.13, var_40_6 * 0.13, var_40_6 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_7 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_7 + 0.6 and arg_37_1.time_ < var_40_7 + 0.6 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_8 = 0
			local var_40_9 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_10 = arg_37_1:GetWordFromCfg(120132009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 7 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 7)

				if (7 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 7)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132009", "story_v_out_120132.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_120132", "120132009", "story_v_out_120132.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_120132", "120132009", "story_v_out_120132.awb")

						arg_37_1:RecordAudio("120132009", var_40_15)
						arg_37_1:RecordAudio("120132009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120132", "120132009", "story_v_out_120132.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120132", "120132009", "story_v_out_120132.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play120132010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120132010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play120132011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_0 = 1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				local var_44_1 = Color.New(1, 1, 1)

				var_44_1.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.mask_.color = var_44_1
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				local var_44_2 = Color.New(1, 1, 1)

				arg_41_1.mask_.enabled = false
				var_44_2.a = 0
				arg_41_1.mask_.color = var_44_2
			end

			local var_44_3 = arg_41_1.actors_["1069ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1069ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0, 100, 0)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["1075ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1075ui_story = var_44_5.localPosition
			end

			local var_44_6 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_6)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, 100, 0)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_jianbing03", "")
			end

			local var_44_8 = 0
			local var_44_9 = 1.475

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_10 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_10:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_11 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(120132010).content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 59 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 59)

				if (59 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 59)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13
					var_44_8 = var_44_8 + 0.3

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = var_44_8 + 0.3
			local var_44_15 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play120132011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 120132011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play120132012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.275

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

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(120132011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 51 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 51)

				if (51 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 51)) > 0 and var_50_0 < var_50_3 then
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
	Play120132012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 120132012
		arg_51_1.duration_ = 8.9

		local var_51_0 = {
			zh = 6.766,
			ja = 8.9
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
				arg_51_0:Play120132013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1069ui_story = arg_51_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).z)
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles = arg_51_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_51_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1069ui_story"].transform.position).z)
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1069ui_story"].transform.localEulerAngles = arg_51_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1075ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1075ui_story = var_54_1.localPosition
			end

			local var_54_2 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_51_1.time_ - 0) / var_54_2)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			local var_54_3 = arg_51_1.actors_["1069ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1069ui_story == nil then
				arg_51_1.var_.characterEffect1069ui_story = var_54_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_4 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 and not isNil(var_54_3) then
				if arg_51_1.var_.characterEffect1069ui_story and not isNil(var_54_3) then
					arg_51_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1069ui_story then
				arg_51_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_54_6 = arg_51_1.actors_["1075ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1075ui_story == nil then
				arg_51_1.var_.characterEffect1075ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_7 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 and not isNil(var_54_6) then
				if arg_51_1.var_.characterEffect1075ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_7)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1075ui_story then
				arg_51_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_54_8 = 0
			local var_54_9 = 0.55

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(120132012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 22 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 22)

				if (22 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 22)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132012", "story_v_out_120132.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_120132", "120132012", "story_v_out_120132.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_120132", "120132012", "story_v_out_120132.awb")

						arg_51_1:RecordAudio("120132012", var_54_15)
						arg_51_1:RecordAudio("120132012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_120132", "120132012", "story_v_out_120132.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_120132", "120132012", "story_v_out_120132.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play120132013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 120132013
		arg_55_1.duration_ = 4.43

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play120132014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1075ui_story = arg_55_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).z)
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles = arg_55_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1075ui_story"].transform.position).z)
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1075ui_story"].transform.localEulerAngles = arg_55_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1069ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1069ui_story = var_58_1.localPosition
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_2)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0, 100, 0)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			local var_58_3 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_4 = 2

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_4 then
				local var_58_5 = Color.New(1, 1, 1)

				var_58_5.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_3) / var_58_4)
				arg_55_1.mask_.color = var_58_5
			end

			if arg_55_1.time_ >= var_58_3 + var_58_4 and arg_55_1.time_ < var_58_3 + var_58_4 + arg_58_0 then
				local var_58_6 = Color.New(1, 1, 1)

				var_58_6.a = 1
				arg_55_1.mask_.color = var_58_6
			end

			local var_58_7 = 2

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_8 = 2

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_8 then
				local var_58_9 = Color.New(1, 1, 1)

				var_58_9.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_7) / var_58_8)
				arg_55_1.mask_.color = var_58_9
			end

			if arg_55_1.time_ >= var_58_7 + var_58_8 and arg_55_1.time_ < var_58_7 + var_58_8 + arg_58_0 then
				local var_58_10 = Color.New(1, 1, 1)

				arg_55_1.mask_.enabled = false
				var_58_10.a = 0
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_11 = 2.5
			local var_58_12 = 0.1

			if 2.5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_13 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_13:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_14 = arg_55_1:GetWordFromCfg(120132013)
				local var_58_15 = arg_55_1:FormatText(var_58_14.content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_17 = 4 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_15) / 4)

				if (4 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_15) / 4)) > 0 and var_58_12 < var_58_17 then
					arg_55_1.talkMaxDuration = var_58_17
					var_58_11 = var_58_11 + 0.3

					if var_58_17 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132013", "story_v_out_120132.awb") ~= 0 then
					local var_58_18 = manager.audio:GetVoiceLength("story_v_out_120132", "120132013", "story_v_out_120132.awb") / 1000

					if var_58_18 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_11
					end

					if var_58_14.prefab_name ~= "" and arg_55_1.actors_[var_58_14.prefab_name] ~= nil then
						local var_58_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_14.prefab_name].transform, "story_v_out_120132", "120132013", "story_v_out_120132.awb")

						arg_55_1:RecordAudio("120132013", var_58_19)
						arg_55_1:RecordAudio("120132013", var_58_19)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_120132", "120132013", "story_v_out_120132.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_120132", "120132013", "story_v_out_120132.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_20 = var_58_11 + 0.3
			local var_58_21 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_20 + var_58_21 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_20) / var_58_21

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_20 + var_58_21 and arg_55_1.time_ < var_58_20 + var_58_21 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play120132014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120132014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120132015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1069ui_story = arg_61_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).z)
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles = arg_61_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1069ui_story"].transform.position).z)
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1069ui_story"].transform.localEulerAngles = arg_61_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1075ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1075ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = 0
			local var_64_4 = 1.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(120132014).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 48 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 48)

				if (48 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 48)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play120132015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120132015
		arg_65_1.duration_ = 4.13

		local var_65_0 = {
			zh = 2.933,
			ja = 4.133
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
				arg_65_0:Play120132016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.45

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(120132015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 18)

				if (18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 18)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132015", "story_v_out_120132.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_120132", "120132015", "story_v_out_120132.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_120132", "120132015", "story_v_out_120132.awb")

						arg_65_1:RecordAudio("120132015", var_68_6)
						arg_65_1:RecordAudio("120132015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120132", "120132015", "story_v_out_120132.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120132", "120132015", "story_v_out_120132.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play120132016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120132016
		arg_69_1.duration_ = 6.33

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120132017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.J03f == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03f")
				var_72_0.name = "J03f"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.J03f = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.J03f

				arg_69_1.bgs_.J03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "J03f" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 2

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			local var_72_12 = arg_69_1.actors_["1075ui_story"].transform

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= 4 + arg_72_0 then
				arg_69_1.var_.moveOldPos1075ui_story = var_72_12.localPosition
			end

			local var_72_13 = 0.001

			if 4 <= arg_69_1.time_ and arg_69_1.time_ < 4 + var_72_13 then
				var_72_12.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_69_1.time_ - 4) / var_72_13)
				var_72_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_12.position).x, (manager.ui.mainCamera.transform.position - var_72_12.position).y, (manager.ui.mainCamera.transform.position - var_72_12.position).z)
				var_72_12.localEulerAngles.z = 0
				var_72_12.localEulerAngles.x = 0
				var_72_12.localEulerAngles = var_72_12.localEulerAngles
			end

			if arg_69_1.time_ >= 4 + var_72_13 and arg_69_1.time_ < 4 + var_72_13 + arg_72_0 then
				var_72_12.localPosition = Vector3.New(0, -1.055, -6.16)
				var_72_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_12.position).x, (manager.ui.mainCamera.transform.position - var_72_12.position).y, (manager.ui.mainCamera.transform.position - var_72_12.position).z)
				var_72_12.localEulerAngles.z = 0
				var_72_12.localEulerAngles.x = 0
				var_72_12.localEulerAngles = var_72_12.localEulerAngles
			end

			local var_72_14 = arg_69_1.actors_["1075ui_story"]

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= 4 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1075ui_story == nil then
				arg_69_1.var_.characterEffect1075ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_15 = 0.2

			if 4 <= arg_69_1.time_ and arg_69_1.time_ < 4 + var_72_15 and not isNil(var_72_14) then
				if arg_69_1.var_.characterEffect1075ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 4 + var_72_15 and arg_69_1.time_ < 4 + var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1075ui_story then
				arg_69_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= 4 + arg_72_0 then
				arg_69_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= 4 + arg_72_0 then
				arg_69_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_17 = 4
			local var_72_18 = 0.075

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_19 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_19:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_20 = arg_69_1:GetWordFromCfg(120132016)
				local var_72_21 = arg_69_1:FormatText(var_72_20.content)

				arg_69_1.text_.text = var_72_21

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_23 = 3 <= 0 and var_72_18 or var_72_18 * (utf8.len(var_72_21) / 3)

				if (3 <= 0 and var_72_18 or var_72_18 * (utf8.len(var_72_21) / 3)) > 0 and var_72_18 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23
					var_72_17 = var_72_17 + 0.3

					if var_72_23 + var_72_17 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_17
					end
				end

				arg_69_1.text_.text = var_72_21
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132016", "story_v_out_120132.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_120132", "120132016", "story_v_out_120132.awb") / 1000

					if var_72_24 + var_72_17 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_17
					end

					if var_72_20.prefab_name ~= "" and arg_69_1.actors_[var_72_20.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_20.prefab_name].transform, "story_v_out_120132", "120132016", "story_v_out_120132.awb")

						arg_69_1:RecordAudio("120132016", var_72_25)
						arg_69_1:RecordAudio("120132016", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120132", "120132016", "story_v_out_120132.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120132", "120132016", "story_v_out_120132.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_26 = var_72_17 + 0.3
			local var_72_27 = math.max(var_72_18, arg_69_1.talkMaxDuration)

			if var_72_17 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_26 + var_72_27 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_26) / var_72_27

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_26 + var_72_27 and arg_69_1.time_ < var_72_26 + var_72_27 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play120132017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 120132017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play120132018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1075ui_story = arg_75_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).z)
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles = arg_75_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1075ui_story"].transform.position).z)
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1075ui_story"].transform.localEulerAngles = arg_75_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_78_1 = 0
			local var_78_2 = 1.075

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

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(120132017).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 43 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 43)

				if (43 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 43)) > 0 and var_78_2 < var_78_5 then
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

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play120132018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 120132018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play120132019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.7

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(120132018).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 28 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 28)

				if (28 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 28)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play120132019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120132019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play120132020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.625

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(120132019).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 25 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 25)

				if (25 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 25)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play120132020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120132020
		arg_87_1.duration_ = 3.13

		local var_87_0 = {
			zh = 3.133,
			ja = 2.2
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
				arg_87_0:Play120132021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_90_0 = arg_87_1.actors_["1075ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1075ui_story = var_90_0.localPosition
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_87_1.time_ - 0) / var_90_1)
				var_90_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_0.position).x, (manager.ui.mainCamera.transform.position - var_90_0.position).y, (manager.ui.mainCamera.transform.position - var_90_0.position).z)
				var_90_0.localEulerAngles.z = 0
				var_90_0.localEulerAngles.x = 0
				var_90_0.localEulerAngles = var_90_0.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -1.055, -6.16)
				var_90_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_0.position).x, (manager.ui.mainCamera.transform.position - var_90_0.position).y, (manager.ui.mainCamera.transform.position - var_90_0.position).z)
				var_90_0.localEulerAngles.z = 0
				var_90_0.localEulerAngles.x = 0
				var_90_0.localEulerAngles = var_90_0.localEulerAngles
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_90_2 = 0
			local var_90_3 = 0.175

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(120132020)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 7 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 7)

				if (7 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 7)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120132", "120132020", "story_v_out_120132.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_120132", "120132020", "story_v_out_120132.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_120132", "120132020", "story_v_out_120132.awb")

						arg_87_1:RecordAudio("120132020", var_90_9)
						arg_87_1:RecordAudio("120132020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_120132", "120132020", "story_v_out_120132.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_120132", "120132020", "story_v_out_120132.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play120132021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120132021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
			arg_91_1.auto_ = false
		end

		function arg_91_1.playNext_(arg_93_0)
			arg_91_1.onStoryFinished_()
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1075ui_story = arg_91_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).z)
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles = arg_91_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1075ui_story"].transform.position).z)
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1075ui_story"].transform.localEulerAngles = arg_91_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_94_1 = 0
			local var_94_2 = 0.725

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(120132021).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 29 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 29)

				if (29 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 29)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	assets = {
		"TextureConfig/Background/J16f",
		"TextureConfig/Background/J03f"
	},
	voices = {
		"story_v_out_120132.awb"
	}
}
